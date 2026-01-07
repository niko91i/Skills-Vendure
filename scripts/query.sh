#!/opt/homebrew/bin/bash
##
# query.sh - Exécution simplifiée de requêtes GraphQL Vendure
#
# Wrapper qui gère automatiquement l'authentification et les headers.
#
# Usage:
#   ./query.sh '{ me { id identifier } }'
#   ./query.sh 'query { products { items { id name } } }'
#   ./query.sh --file queries/get-product.graphql
#   ./query.sh --superadmin '{ administrators { items { id } } }'
#   echo '{ me { id } }' | ./query.sh
#
# Prérequis:
#   - curl, jq installés
#   - Serveur Vendure accessible
#   - login.sh dans le même répertoire
##

set -euo pipefail

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOGIN_SCRIPT="$SCRIPT_DIR/login.sh"
TOKEN_CACHE="$SCRIPT_DIR/.token-cache"
HISTORY_FILE="$SCRIPT_DIR/.query-history"
QUERIES_DIR="$SCRIPT_DIR/queries"
HISTORY_MAX=50

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# Options
VERBOSE=false
USE_SUPERADMIN=false
RAW_OUTPUT=false
ONLY_DATA=false
QUERY_FILE=""
VARIABLES="{}"
CUSTOM_ENV_PATH=""
QUERY_ARG=""
CLEAR_CACHE=false
TIMEOUT=30
SHOW_HISTORY=false
RUN_LAST=false
SAVE_NAME=""
USE_SHOP_API=false
SHOW_TIME=false
REPLAY_INDEX=""
INSPECT_INDEX=""
SET_EXPRESSIONS=()
DIFF_OPTIONS=""
DIFF_ONLY=false
NO_FAIL=false
DRY_RUN=false
GENERATE_CURL=false
JQ_FILTER=""
ASSERT_EXPR=""
QUIET_MODE=false
OUTPUT_FILE=""

# Fichiers temporaires pour diff
DIFF_FILE_A="/tmp/query-diff-a.json"
DIFF_FILE_B="/tmp/query-diff-b.json"

# Tokens
AUTH_TOKEN=""
CHANNEL_TOKEN=""
API_URL="http://localhost:3000"

# ═══════════════════════════════════════════════════════════════════════════════
# FONCTIONS UTILITAIRES
# ═══════════════════════════════════════════════════════════════════════════════

log_error() {
    [[ "$QUIET_MODE" == "true" ]] && return
    echo -e "${RED}✗ $1${NC}" >&2
}

log_success() {
    [[ "$QUIET_MODE" == "true" ]] && return
    echo -e "${GREEN}✓ $1${NC}" >&2
}

log_info() {
    [[ "$QUIET_MODE" == "true" ]] && return
    echo -e "${BLUE}ℹ $1${NC}" >&2
}

log_warning() {
    [[ "$QUIET_MODE" == "true" ]] && return
    echo -e "${YELLOW}⚠ $1${NC}" >&2
}

log_verbose() {
    [[ "$QUIET_MODE" == "true" ]] && return
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${DIM}  → $1${NC}" >&2
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# HISTORIQUE
# ═══════════════════════════════════════════════════════════════════════════════

##
# Ajoute une requête à l'historique
#
# @param $1 - Query
# @param $2 - Variables JSON
##
add_to_history() {
    local query="$1"
    local vars="$2"
    local ts
    ts=$(date +%s)

    # Créer l'entrée JSON (encoder la query en base64 pour éviter les problèmes d'échappement)
    local query_b64
    query_b64=$(echo -n "$query" | base64 | tr -d '\n')

    # Vérifier si la dernière entrée est identique (éviter les doublons)
    if [[ -f "$HISTORY_FILE" ]]; then
        local last_entry last_q last_v
        last_entry=$(tail -n 1 "$HISTORY_FILE" 2>/dev/null)
        if [[ -n "$last_entry" ]]; then
            last_q=$(echo "$last_entry" | jq -r '.q' 2>/dev/null)
            last_v=$(echo "$last_entry" | jq -r '.v' 2>/dev/null)
            if [[ "$last_q" == "$query_b64" && "$last_v" == "$vars" ]]; then
                log_verbose "Requête identique à la précédente - historique non modifié"
                return 0
            fi
        fi
    fi

    local entry
    entry=$(jq -cn --arg ts "$ts" --arg q "$query_b64" --arg v "$vars" \
        '{ts: $ts, q: $q, v: $v}')

    # Ajouter au fichier
    echo "$entry" >> "$HISTORY_FILE"

    # Limiter à HISTORY_MAX lignes
    if [[ -f "$HISTORY_FILE" ]]; then
        local count
        count=$(wc -l < "$HISTORY_FILE" | tr -d ' ')
        if [[ "$count" -gt "$HISTORY_MAX" ]]; then
            local temp_file
            temp_file=$(mktemp)
            tail -n "$HISTORY_MAX" "$HISTORY_FILE" > "$temp_file"
            mv "$temp_file" "$HISTORY_FILE"
        fi
    fi

    log_verbose "Requête ajoutée à l'historique"
}

##
# Affiche les dernières requêtes de l'historique
##
show_history() {
    if [[ ! -f "$HISTORY_FILE" ]]; then
        log_info "Historique vide"
        exit 0
    fi

    local count
    count=$(wc -l < "$HISTORY_FILE" | tr -d ' ')

    echo -e "${BOLD}Historique des requêtes (${count}/${HISTORY_MAX})${NC}" >&2
    echo "" >&2

    local i=1
    local display_count=10

    # Lire les 10 dernières lignes
    tail -n "$display_count" "$HISTORY_FILE" | while read -r line; do
        local ts query_b64 vars query_preview
        ts=$(echo "$line" | jq -r '.ts')
        query_b64=$(echo "$line" | jq -r '.q')
        vars=$(echo "$line" | jq -r '.v')

        # Décoder la query
        local query
        query=$(echo "$query_b64" | base64 -d 2>/dev/null || echo "[decode error]")

        # Formater la date
        local date_str
        if [[ "$(uname)" == "Darwin" ]]; then
            date_str=$(date -r "$ts" "+%H:%M:%S" 2>/dev/null || echo "??:??:??")
        else
            date_str=$(date -d "@$ts" "+%H:%M:%S" 2>/dev/null || echo "??:??:??")
        fi

        # Aperçu de la requête (première ligne, max 60 chars)
        query_preview=$(echo "$query" | head -1 | cut -c1-60)
        [[ ${#query} -gt 60 ]] && query_preview="${query_preview}..."

        # Afficher
        echo -e "${CYAN}[$i]${NC} ${DIM}$date_str${NC} $query_preview" >&2

        ((i++))
    done

    echo "" >&2
    echo -e "${DIM}Utiliser ${NC}--last${DIM} pour la dernière, ou ${NC}--replay N${DIM} pour la requête #N${NC}" >&2
}

##
# Récupère la dernière requête de l'historique
##
get_last_query() {
    if [[ ! -f "$HISTORY_FILE" ]]; then
        log_error "Historique vide - aucune requête à ré-exécuter"
        exit 1
    fi

    local last_line
    last_line=$(tail -n 1 "$HISTORY_FILE")

    if [[ -z "$last_line" ]]; then
        log_error "Historique vide"
        exit 1
    fi

    local query_b64 vars
    query_b64=$(echo "$last_line" | jq -r '.q')
    vars=$(echo "$last_line" | jq -r '.v')

    # Décoder la query
    QUERY_ARG=$(echo "$query_b64" | base64 -d)

    # Ne pas écraser les variables si l'utilisateur en a fourni
    if [[ "$VARIABLES" == "{}" ]]; then
        VARIABLES="$vars"
    fi

    log_info "Ré-exécution de la dernière requête..."
}

##
# Récupère une requête de l'historique par son index
#
# @param $1 - Index de la requête (1-10, comme affiché par --history)
##
get_query_by_index() {
    local index="$1"

    if [[ ! -f "$HISTORY_FILE" ]]; then
        log_error "Historique vide - aucune requête à ré-exécuter"
        exit 1
    fi

    # Valider que l'index est un nombre
    if ! [[ "$index" =~ ^[0-9]+$ ]]; then
        log_error "Index invalide: $index (doit être un nombre)"
        exit 1
    fi

    # Récupérer les 10 dernières lignes (comme show_history)
    local display_count=10
    local total_lines
    total_lines=$(wc -l < "$HISTORY_FILE" | tr -d ' ')

    if [[ "$total_lines" -eq 0 ]]; then
        log_error "Historique vide"
        exit 1
    fi

    # Limiter display_count au nombre de lignes disponibles
    [[ "$total_lines" -lt "$display_count" ]] && display_count="$total_lines"

    # Valider que l'index est dans la plage
    if [[ "$index" -lt 1 ]] || [[ "$index" -gt "$display_count" ]]; then
        log_error "Index hors plage: $index (doit être entre 1 et $display_count)"
        exit 1
    fi

    # Récupérer la ligne à l'index demandé
    local target_line
    target_line=$(tail -n "$display_count" "$HISTORY_FILE" | sed -n "${index}p")

    if [[ -z "$target_line" ]]; then
        log_error "Requête #$index introuvable"
        exit 1
    fi

    local query_b64 vars
    query_b64=$(echo "$target_line" | jq -r '.q')
    vars=$(echo "$target_line" | jq -r '.v')

    # Décoder la query
    QUERY_ARG=$(echo "$query_b64" | base64 -d)

    # Ne pas écraser les variables si l'utilisateur en a fourni
    if [[ "$VARIABLES" == "{}" ]]; then
        VARIABLES="$vars"
    fi

    log_info "Ré-exécution de la requête #$index..."
}

##
# Inspecte une requête de l'historique (affiche sans exécuter)
#
# @param $1 - Index de la requête (1-10)
##
inspect_query() {
    local index="$1"

    if [[ ! -f "$HISTORY_FILE" ]]; then
        log_error "Historique vide"
        exit 1
    fi

    # Valider que l'index est un nombre
    if ! [[ "$index" =~ ^[0-9]+$ ]]; then
        log_error "Index invalide: $index (doit être un nombre)"
        exit 1
    fi

    # Récupérer les 10 dernières lignes
    local display_count=10
    local total_lines
    total_lines=$(wc -l < "$HISTORY_FILE" | tr -d ' ')

    if [[ "$total_lines" -eq 0 ]]; then
        log_error "Historique vide"
        exit 1
    fi

    [[ "$total_lines" -lt "$display_count" ]] && display_count="$total_lines"

    if [[ "$index" -lt 1 ]] || [[ "$index" -gt "$display_count" ]]; then
        log_error "Index hors plage: $index (doit être entre 1 et $display_count)"
        exit 1
    fi

    # Récupérer la ligne
    local target_line
    target_line=$(tail -n "$display_count" "$HISTORY_FILE" | sed -n "${index}p")

    if [[ -z "$target_line" ]]; then
        log_error "Requête #$index introuvable"
        exit 1
    fi

    local ts query_b64 vars query
    ts=$(echo "$target_line" | jq -r '.ts')
    query_b64=$(echo "$target_line" | jq -r '.q')
    vars=$(echo "$target_line" | jq -r '.v')
    query=$(echo "$query_b64" | base64 -d)

    # Formater la date
    local date_str
    if [[ "$(uname)" == "Darwin" ]]; then
        date_str=$(date -r "$ts" "+%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "??")
    else
        date_str=$(date -d "@$ts" "+%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "??")
    fi

    # Afficher
    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2
    echo -e "${BOLD}Query #$index${NC} ${DIM}($date_str)${NC}" >&2
    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2
    echo "" >&2
    echo -e "${CYAN}$query${NC}" >&2
    echo "" >&2
    echo -e "${BOLD}───────────────────────────────────────────────────────────${NC}" >&2
    echo -e "${BOLD}Variables:${NC} ${YELLOW}$vars${NC}" >&2
    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2
}

##
# Applique les expressions --set aux variables (merge avec jq)
##
apply_set_expressions() {
    # Si pas d'expressions --set, rien à faire
    if [[ ${#SET_EXPRESSIONS[@]} -eq 0 ]]; then
        return 0
    fi

    local current_vars="$VARIABLES"

    # Appliquer chaque expression --set
    for expr in "${SET_EXPRESSIONS[@]}"; do
        local new_vars error_output

        # Capturer stdout et stderr séparément
        error_output=$(echo "$current_vars" | jq "$expr" 2>&1 >/dev/null) || {
            log_error "Expression --set invalide: $expr"
            log_error "Erreur jq: $error_output"
            exit 1
        }

        # Si pas d'erreur, récupérer le résultat
        new_vars=$(echo "$current_vars" | jq "$expr")

        if [[ -z "$new_vars" || "$new_vars" == "null" ]]; then
            log_error "Expression --set a produit une valeur vide: $expr"
            exit 1
        fi

        current_vars="$new_vars"
        log_verbose "Applied --set '$expr' → $current_vars"
    done

    VARIABLES="$current_vars"
    log_verbose "Variables finales: $VARIABLES"
}

##
# Affiche les différences JSON de manière compacte (--diff-only)
# Aplatit les JSON et compare les valeurs à chaque chemin
#
# @param $1 - Fichier JSON A
# @param $2 - Fichier JSON B
##
show_json_diff() {
    local file_a="$1"
    local file_b="$2"

    # Script jq pour aplatir un JSON en paires chemin|valeur
    local flatten_script='
        paths(scalars) as $p
        | {"path": $p | map(if type == "number" then "[\(.)]" else ".\(.)" end) | join(""), "value": getpath($p)}
        | "\(.path)|\(.value | @json)"
    '

    # Aplatir les deux JSON dans des tableaux associatifs
    declare -A values_a values_b
    local all_paths=()

    # Lire les valeurs de A
    while IFS='|' read -r path value; do
        if [[ -n "$path" ]]; then
            values_a["$path"]="$value"
            all_paths+=("$path")
        fi
    done < <(jq -r "$flatten_script" "$file_a" 2>/dev/null)

    # Lire les valeurs de B
    while IFS='|' read -r path value; do
        if [[ -n "$path" ]]; then
            values_b["$path"]="$value"
            # Ajouter au tableau si pas déjà présent
            if [[ -z "${values_a[$path]+x}" ]]; then
                all_paths+=("$path")
            fi
        fi
    done < <(jq -r "$flatten_script" "$file_b" 2>/dev/null)

    # Trier et dédupliquer les chemins
    local sorted_paths
    sorted_paths=$(printf '%s\n' "${all_paths[@]}" | sort -u)

    local has_diff=false

    # Comparer chaque chemin
    while IFS= read -r path; do
        if [[ -n "$path" ]]; then
            local val_a="${values_a[$path]:-}"
            local val_b="${values_b[$path]:-}"

            if [[ -z "$val_a" && -n "$val_b" ]]; then
                # Présent seulement dans B (ajouté)
                echo -e "${RED}A${NC} ${CYAN}$path${NC} = ${DIM}(absent)${NC}"
                echo -e "${GREEN}B${NC} ${CYAN}$path${NC} = $val_b"
                echo ""
                has_diff=true
            elif [[ -n "$val_a" && -z "$val_b" ]]; then
                # Présent seulement dans A (supprimé)
                echo -e "${RED}A${NC} ${CYAN}$path${NC} = $val_a"
                echo -e "${GREEN}B${NC} ${CYAN}$path${NC} = ${DIM}(absent)${NC}"
                echo ""
                has_diff=true
            elif [[ "$val_a" != "$val_b" ]]; then
                # Valeurs différentes
                echo -e "${RED}A${NC} ${CYAN}$path${NC} = $val_a"
                echo -e "${GREEN}B${NC} ${CYAN}$path${NC} = $val_b"
                echo ""
                has_diff=true
            fi
        fi
    done <<< "$sorted_paths"

    if [[ "$has_diff" == "false" ]]; then
        echo -e "${GREEN}✓ Résultats identiques${NC}"
    fi
}

##
# Évalue une assertion jq sur la réponse
# Retourne 0 si l'assertion est vraie, 1 sinon
#
# @param $1 - Réponse JSON
# @param $2 - Expression jq à évaluer (doit retourner true/false)
##
evaluate_assert() {
    local response="$1"
    local expr="$2"

    # Évaluer l'expression jq
    local result
    result=$(echo "$response" | jq -e "$expr" 2>&1)
    local jq_exit=$?

    # jq -e retourne 1 si le résultat est false ou null
    if [[ $jq_exit -ne 0 ]]; then
        # Vérifier si c'est une erreur de syntaxe ou juste false
        if echo "$result" | grep -q "error\|Error"; then
            log_error "Expression assertion invalide: $expr"
            log_error "$result"
        else
            log_error "Assertion échouée: $expr"
            log_verbose "Résultat: $result"
        fi
        return 1
    fi

    # Vérifier que le résultat est bien "true"
    if [[ "$result" != "true" ]]; then
        log_error "Assertion échouée: $expr"
        log_verbose "Résultat: $result (attendu: true)"
        return 1
    fi

    log_verbose "Assertion validée: $expr"
    return 0
}

##
# Affiche les détails d'une requête sans l'exécuter (--dry-run)
#
# @param $1 - Query à afficher
##
show_dry_run() {
    local query="$1"

    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2
    echo -e "${BOLD}🔍 DRY RUN${NC}" >&2
    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2
    echo "" >&2

    # Query
    echo -e "${CYAN}📝 Query:${NC}" >&2
    echo -e "${DIM}$query${NC}" >&2
    echo "" >&2

    # Variables
    echo -e "${CYAN}📦 Variables:${NC}" >&2
    if [[ "$VARIABLES" == "{}" ]]; then
        echo -e "${DIM}(aucune)${NC}" >&2
    else
        echo "$VARIABLES" | jq -C '.' >&2
    fi
    echo "" >&2

    # Auth
    local auth_type="vendor"
    [[ "$USE_SUPERADMIN" == "true" ]] && auth_type="superadmin"
    echo -e "${CYAN}🔑 Auth:${NC} $auth_type" >&2

    # Endpoint
    local endpoint="admin-api"
    [[ "$USE_SHOP_API" == "true" ]] && endpoint="shop-api"
    echo -e "${CYAN}🌐 Endpoint:${NC} ${API_URL}/$endpoint" >&2

    echo "" >&2
    echo -e "${YELLOW}(non exécuté)${NC}" >&2
    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2
}

##
# Génère la commande curl équivalente à la requête
#
# @param $1 - Query à convertir en curl
##
generate_curl_command() {
    local query="$1"

    # Déterminer l'endpoint API
    local api_endpoint="${API_URL}/admin-api"
    if [[ "$USE_SHOP_API" == "true" ]]; then
        api_endpoint="${API_URL}/shop-api"
    fi

    # Construire le payload JSON (échapper les guillemets pour shell)
    local payload
    payload=$(jq -c -n \
        --arg q "$query" \
        --argjson v "$VARIABLES" \
        '{query: $q, variables: $v}')

    # Échapper les guillemets simples dans le payload pour le shell
    local escaped_payload
    escaped_payload=$(echo "$payload" | sed "s/'/'\\\\''/g")

    # Construire la commande curl
    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2
    echo -e "${BOLD}🔧 CURL COMMAND${NC}" >&2
    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2
    echo "" >&2

    # Afficher la commande curl formatée
    echo "curl -X POST '${api_endpoint}' \\"
    echo "  -H 'Content-Type: application/json' \\"
    echo "  -H 'Authorization: Bearer ${AUTH_TOKEN}' \\"

    if [[ -n "$CHANNEL_TOKEN" ]]; then
        echo "  -H 'vendure-token: ${CHANNEL_TOKEN}' \\"
    fi

    echo "  -d '${escaped_payload}'"

    echo "" >&2
    echo -e "${BOLD}───────────────────────────────────────────────────────────${NC}" >&2
    echo -e "${DIM}Copier-coller cette commande pour exécuter la requête${NC}" >&2
    echo -e "${YELLOW}⚠ Le token expire après ~30 minutes${NC}" >&2
    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2
}

##
# Exécute une requête en mode diff (compare deux exécutions)
#
# @param $1 - Query à exécuter
##
execute_with_diff() {
    local query="$1"
    local script_path="${BASH_SOURCE[0]}"

    # Construire les options de base (sans --diff)
    local base_opts=()
    [[ "$USE_SUPERADMIN" == "true" ]] && base_opts+=("--superadmin")
    [[ -n "$CUSTOM_ENV_PATH" ]] && base_opts+=("--env" "$CUSTOM_ENV_PATH")
    [[ "$USE_SHOP_API" == "true" ]] && base_opts+=("--shop")
    [[ "$RAW_OUTPUT" == "true" ]] && base_opts+=("--raw")
    base_opts+=("--vars" "$VARIABLES")

    # Description des modes
    local mode_a_desc="Variables: $VARIABLES"
    [[ "$USE_SUPERADMIN" == "true" ]] && mode_a_desc="superadmin, $mode_a_desc" || mode_a_desc="vendor, $mode_a_desc"
    [[ "$USE_SHOP_API" == "true" ]] && mode_a_desc="shop-api, $mode_a_desc" || mode_a_desc="admin-api, $mode_a_desc"

    # Exécution A (options de base)
    log_info "Exécution A: $mode_a_desc"
    "$script_path" "$query" "${base_opts[@]}" --raw 2>/dev/null > "$DIFF_FILE_A"

    if [[ $? -ne 0 ]]; then
        log_error "Échec de l'exécution A"
        rm -f "$DIFF_FILE_A" "$DIFF_FILE_B"
        exit 1
    fi

    # Construire les options pour B (base + diff options)
    local diff_opts=("${base_opts[@]}")

    # Parser DIFF_OPTIONS et ajouter les options
    # Utiliser eval pour parser correctement les guillemets
    eval "diff_opts+=($DIFF_OPTIONS)"

    # Description du mode B
    local mode_b_desc="$mode_a_desc + $DIFF_OPTIONS"

    # Exécution B (avec options diff)
    log_info "Exécution B: $mode_b_desc"
    "$script_path" "$query" "${diff_opts[@]}" --raw 2>/dev/null > "$DIFF_FILE_B"

    if [[ $? -ne 0 ]]; then
        log_error "Échec de l'exécution B"
        rm -f "$DIFF_FILE_A" "$DIFF_FILE_B"
        exit 1
    fi

    # Formater les JSON pour un meilleur diff
    local formatted_a formatted_b
    formatted_a=$(jq '.' "$DIFF_FILE_A" 2>/dev/null)
    formatted_b=$(jq '.' "$DIFF_FILE_B" 2>/dev/null)

    echo "$formatted_a" > "$DIFF_FILE_A"
    echo "$formatted_b" > "$DIFF_FILE_B"

    # Afficher l'en-tête
    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2
    echo -e "${BOLD}DIFF${NC}" >&2
    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2
    echo -e "${CYAN}A:${NC} $mode_a_desc" >&2
    echo -e "${MAGENTA}B:${NC} $mode_b_desc" >&2
    echo -e "${BOLD}───────────────────────────────────────────────────────────${NC}" >&2
    echo "" >&2

    # Vérifier si les fichiers sont identiques
    if diff -q "$DIFF_FILE_A" "$DIFF_FILE_B" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Résultats identiques${NC}" >&2
    elif [[ "$DIFF_ONLY" == "true" ]]; then
        # Mode compact: afficher uniquement les valeurs différentes
        show_json_diff "$DIFF_FILE_A" "$DIFF_FILE_B"
    else
        # Mode standard: afficher le diff unifié coloré
        diff -u "$DIFF_FILE_A" "$DIFF_FILE_B" 2>/dev/null | tail -n +3 | while IFS= read -r line; do
            if [[ "$line" == -* ]]; then
                echo -e "${RED}$line${NC}"
            elif [[ "$line" == +* ]]; then
                echo -e "${GREEN}$line${NC}"
            elif [[ "$line" == @@* ]]; then
                echo -e "${CYAN}$line${NC}"
            else
                echo "$line"
            fi
        done || true  # Ignorer le code de sortie de diff

        echo "" >&2
        echo -e "${BOLD}───────────────────────────────────────────────────────────${NC}" >&2
        # Compter les différences
        local diff_output added removed
        diff_output=$(diff -u "$DIFF_FILE_A" "$DIFF_FILE_B" 2>/dev/null || true)
        added=$(echo "$diff_output" | grep -c "^+" || true)
        removed=$(echo "$diff_output" | grep -c "^-" || true)
        # Soustraire les lignes d'en-tête (+++ et ---)
        added=$((added > 1 ? added - 1 : 0))
        removed=$((removed > 1 ? removed - 1 : 0))
        echo -e "${GREEN}+$added${NC} ${RED}-$removed${NC} lignes" >&2
    fi

    echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}" >&2

    # Nettoyer les fichiers temporaires
    rm -f "$DIFF_FILE_A" "$DIFF_FILE_B"
}

##
# Sauvegarde une requête dans un fichier
#
# @param $1 - Nom du fichier (sans extension)
# @param $2 - Query
##
save_query() {
    local name="$1"
    local query="$2"

    # Créer le dossier queries si nécessaire
    if [[ ! -d "$QUERIES_DIR" ]]; then
        mkdir -p "$QUERIES_DIR"
        log_verbose "Dossier $QUERIES_DIR créé"
    fi

    local filepath="$QUERIES_DIR/${name}.graphql"

    # Vérifier si le fichier existe déjà
    if [[ -f "$filepath" ]]; then
        log_warning "Fichier $filepath existe déjà - écrasement"
    fi

    echo "$query" > "$filepath"
    log_success "Requête sauvegardée: $filepath"
}

# ═══════════════════════════════════════════════════════════════════════════════
# AUTHENTIFICATION
# ═══════════════════════════════════════════════════════════════════════════════

##
# Vérifie si le cache de tokens est valide (moins de 30 min)
##
is_cache_valid() {
    local cache_type="$1"
    local cache_file="${TOKEN_CACHE}.${cache_type}"

    if [[ ! -f "$cache_file" ]]; then
        return 1
    fi

    # Vérifier l'âge du cache (30 minutes max)
    local cache_age
    if [[ "$(uname)" == "Darwin" ]]; then
        cache_age=$(( $(date +%s) - $(stat -f %m "$cache_file") ))
    else
        cache_age=$(( $(date +%s) - $(stat -c %Y "$cache_file") ))
    fi

    if [[ $cache_age -gt 1800 ]]; then
        log_verbose "Cache expiré (${cache_age}s > 1800s)"
        return 1
    fi

    log_verbose "Cache valide (${cache_age}s)"
    return 0
}

##
# Charge les tokens depuis le cache
##
load_from_cache() {
    local cache_type="$1"
    local cache_file="${TOKEN_CACHE}.${cache_type}"

    if [[ -f "$cache_file" ]]; then
        source "$cache_file"
        log_verbose "Tokens chargés depuis cache"
        return 0
    fi
    return 1
}

##
# Sauvegarde les tokens dans le cache
##
save_to_cache() {
    local cache_type="$1"
    local cache_file="${TOKEN_CACHE}.${cache_type}"

    cat > "$cache_file" << EOF
AUTH_TOKEN="$AUTH_TOKEN"
CHANNEL_TOKEN="$CHANNEL_TOKEN"
API_URL="$API_URL"
EOF
    log_verbose "Tokens sauvegardés dans cache"
}

##
# Supprime les fichiers de cache
##
clear_cache() {
    rm -f "${TOKEN_CACHE}.vendor" "${TOKEN_CACHE}.superadmin" 2>/dev/null
    log_info "Cache supprimé"
}

##
# Obtient les tokens via login.sh
##
get_tokens() {
    local cache_type="vendor"
    local login_args=("--from-last" "-q")

    if [[ "$USE_SUPERADMIN" == "true" ]]; then
        cache_type="superadmin"
        login_args=("--superadmin" "-q")
        if [[ -n "$CUSTOM_ENV_PATH" ]]; then
            login_args+=("--env" "$CUSTOM_ENV_PATH")
        fi
    fi

    # Clear cache si demandé
    if [[ "$CLEAR_CACHE" == "true" ]]; then
        rm -f "${TOKEN_CACHE}.${cache_type}" 2>/dev/null
        log_verbose "Cache $cache_type supprimé"
    fi

    # Vérifier le cache d'abord
    if is_cache_valid "$cache_type" && load_from_cache "$cache_type"; then
        return 0
    fi

    # Sinon, faire un nouveau login
    log_verbose "Authentification en cours..."

    if [[ ! -x "$LOGIN_SCRIPT" ]]; then
        log_error "Script login.sh introuvable ou non exécutable"
        exit 1
    fi

    local login_output
    login_output=$("$LOGIN_SCRIPT" "${login_args[@]}" 2>/dev/null) || {
        log_error "Échec de l'authentification"
        log_error "Vérifiez que le serveur Vendure est accessible"
        exit 1
    }

    # Parser la sortie
    AUTH_TOKEN=$(echo "$login_output" | grep "AUTH_TOKEN=" | cut -d'=' -f2)
    CHANNEL_TOKEN=$(echo "$login_output" | grep "CHANNEL_TOKEN=" | cut -d'=' -f2)

    if [[ -z "$AUTH_TOKEN" ]]; then
        log_error "Token d'authentification non obtenu"
        exit 1
    fi

    # Charger l'API_URL depuis .env si disponible
    load_api_url

    # Sauvegarder dans le cache
    save_to_cache "$cache_type"

    log_verbose "Authentifié"
}

##
# Charge l'URL de l'API
##
load_api_url() {
    local env_file=""
    local search_paths=("$SCRIPT_DIR/.env" "$SCRIPT_DIR/../.env" "$SCRIPT_DIR/../../.env")

    # Ajouter CUSTOM_ENV_PATH seulement s'il est non vide
    if [[ -n "${CUSTOM_ENV_PATH:-}" ]]; then
        search_paths+=("$CUSTOM_ENV_PATH")
    fi

    # Chercher le .env
    for path in "${search_paths[@]}"; do
        if [[ -f "$path" ]]; then
            env_file="$path"
            break
        fi
    done

    if [[ -n "$env_file" ]]; then
        local url
        url=$(grep "^API_URL=" "$env_file" 2>/dev/null | cut -d'=' -f2 | tr -d '"' | tr -d "'" || true)
        if [[ -n "$url" ]]; then
            API_URL="$url"
        fi
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# EXÉCUTION DE LA REQUÊTE
# ═══════════════════════════════════════════════════════════════════════════════

##
# Exécute la requête GraphQL
##
execute_query() {
    local query="$1"

    log_verbose "Exécution de la requête..."
    log_verbose "Variables: $VARIABLES"

    # Déterminer l'endpoint API
    local api_endpoint="${API_URL}/admin-api"
    if [[ "$USE_SHOP_API" == "true" ]]; then
        api_endpoint="${API_URL}/shop-api"
        log_verbose "Utilisation de shop-api"
    fi

    # Construire le payload JSON
    local payload
    payload=$(jq -n \
        --arg q "$query" \
        --argjson v "$VARIABLES" \
        '{query: $q, variables: $v}')

    # Construire les arguments curl
    local curl_args=(-s -X POST "$api_endpoint"
        --max-time "$TIMEOUT"
        --connect-timeout 10
        -H "Content-Type: application/json"
        -H "Authorization: Bearer $AUTH_TOKEN")

    if [[ -n "$CHANNEL_TOKEN" ]]; then
        curl_args+=(-H "vendure-token: $CHANNEL_TOKEN")
    fi

    curl_args+=(-d "$payload")

    log_verbose "Timeout: ${TIMEOUT}s"

    # Exécuter avec mesure du temps
    local response
    local curl_exit_code
    local start_time end_time elapsed_ms

    if [[ "$SHOW_TIME" == "true" ]]; then
        start_time=$(perl -MTime::HiRes=time -e 'printf "%.3f\n", time')
    fi

    response=$(curl "${curl_args[@]}" 2>/dev/null)
    curl_exit_code=$?

    if [[ "$SHOW_TIME" == "true" ]]; then
        end_time=$(perl -MTime::HiRes=time -e 'printf "%.3f\n", time')
        elapsed_ms=$(echo "$end_time - $start_time" | bc | awk '{printf "%.0f", $1 * 1000}')
    fi

    if [[ $curl_exit_code -eq 28 ]]; then
        log_error "Timeout après ${TIMEOUT}s - le serveur ne répond pas"
        exit 1
    elif [[ $curl_exit_code -ne 0 ]]; then
        log_error "Erreur de connexion au serveur (code: $curl_exit_code)"
        exit 1
    fi

    # Évaluer l'assertion si définie
    if [[ -n "$ASSERT_EXPR" ]]; then
        if ! evaluate_assert "$response" "$ASSERT_EXPR"; then
            exit 1
        fi
    fi

    # Traiter la réponse
    format_response "$response"

    # Afficher le temps si demandé
    if [[ "$SHOW_TIME" == "true" ]]; then
        echo "" >&2
        echo -e "${DIM}⏱ ${elapsed_ms}ms${NC}" >&2
    fi
}

##
# Formate et affiche la réponse
##
format_response() {
    local response="$1"

    # Vérifier si c'est du JSON valide
    if ! echo "$response" | jq empty 2>/dev/null; then
        log_error "Réponse invalide du serveur:"
        echo "$response" >&2
        exit 1
    fi

    # Vérifier les erreurs GraphQL
    local errors
    errors=$(echo "$response" | jq -r '.errors // empty')

    if [[ -n "$errors" && "$errors" != "null" ]]; then
        log_error "Erreur GraphQL:"
        echo "$response" | jq -C '.errors' >&2

        # Afficher aussi les données si présentes
        local data
        data=$(echo "$response" | jq -r '.data // empty')
        if [[ -n "$data" && "$data" != "null" ]]; then
            echo ""
            echo "$response" | jq -C '.data'
        fi
        # Avec --no-fail, continuer malgré l'erreur GraphQL
        if [[ "$NO_FAIL" == "false" ]]; then
            exit 1
        fi
        return
    fi

    # Préparer le résultat
    # Désactiver les couleurs si sortie fichier
    local jq_color="-C"
    [[ -n "$OUTPUT_FILE" ]] && jq_color=""

    local output
    if [[ -n "$JQ_FILTER" ]]; then
        # Mode --jq : appliquer le filtre personnalisé
        output=$(echo "$response" | jq -r "$JQ_FILTER" 2>&1) || {
            log_error "Filtre jq invalide: $JQ_FILTER"
            log_error "$output"
            exit 1
        }
    elif [[ "$RAW_OUTPUT" == "true" ]]; then
        output="$response"
    elif [[ "$ONLY_DATA" == "true" ]]; then
        output=$(echo "$response" | jq $jq_color '.data')
    else
        output=$(echo "$response" | jq $jq_color '.')
    fi

    # Écrire le résultat (fichier ou stdout)
    if [[ -n "$OUTPUT_FILE" ]]; then
        echo "$output" > "$OUTPUT_FILE"
        log_success "Résultat écrit dans $OUTPUT_FILE"
    else
        echo "$output"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# AIDE
# ═══════════════════════════════════════════════════════════════════════════════

show_help() {
    cat << 'EOF'
query.sh - Exécution simplifiée de requêtes GraphQL Vendure

USAGE:
    ./query.sh [OPTIONS] 'QUERY'
    ./query.sh [OPTIONS] --file FICHIER.graphql
    echo 'QUERY' | ./query.sh [OPTIONS]

REQUÊTE:
    La requête GraphQL peut être fournie de 3 façons :

    1. Argument inline (guillemets simples recommandés) :
       ./query.sh '{ me { id identifier } }'

    2. Depuis un fichier :
       ./query.sh --file queries/get-products.graphql

    3. Via stdin (pipe ou heredoc) :
       echo '{ me { id } }' | ./query.sh

       ./query.sh <<'EOF'
       query {
         products {
           items { id name }
         }
       }
       EOF

OPTIONS:
    --vars JSON         Variables GraphQL en JSON (remplace tout)
                        Exemple: --vars '{"id": "42"}'

    --set EXPR          Modifier une variable (merge avec jq)
                        Exemple: --set '.take=10'
                        Multiple: --set '.take=10' --set '.skip=20'
                        Imbriqué: --set '.filter.status="active"'

    --file FILE         Lire la requête depuis un fichier .graphql

    --superadmin        Utiliser les credentials super admin
    --env PATH          Chemin vers le fichier .env

    --raw               Sortie JSON brute (sans formatage)
    --data              Afficher uniquement .data (sans wrapper)

    --clear-cache       Forcer une nouvelle authentification
                        (ignore le cache et se reconnecte)

    --timeout N         Timeout en secondes (défaut: 30)
                        Exemple: --timeout 60

    --history, -H       Afficher les 10 dernières requêtes
    --last, -L          Ré-exécuter la dernière requête
    --replay N, -R      Ré-exécuter la requête #N de l'historique
    --inspect N, -I     Afficher query #N + variables (sans exécuter)
    --save NAME, -S     Sauvegarder la requête dans queries/NAME.graphql

    --shop, -p          Utiliser shop-api au lieu de admin-api
    --time, -T          Afficher le temps d'exécution

    --diff "OPTIONS"    Comparer 2 exécutions: avant/après les OPTIONS
                        Exemple: --diff "--superadmin"
                        Exemple: --diff "--set '.take=20'"
    --diff-only         Avec --diff: affiche uniquement les valeurs changées
                        (format compact: chemin = valeur)

    --no-fail           Ne pas exit 1 sur erreur GraphQL
                        Utile pour enchaîner plusieurs requêtes

    --dry-run           Voir la requête sans l'exécuter
                        Affiche: query, variables, auth, endpoint
                        Pas d'authentification (rapide)

    --curl              Générer la commande curl équivalente
                        Affiche une commande curl copier-coller
                        Inclut: headers, auth token, payload JSON

    --jq FILTER, -j     Appliquer un filtre jq sur le résultat
                        Exemple: --jq '.data.products.items[].name'
                        Exemple: --jq '.data.products.totalItems'

    --assert EXPR, -a   Valider une condition jq (exit 1 si fausse)
                        Exemple: --assert '.data.products.totalItems > 0'
                        Exemple: --assert '.data.product != null'
                        Utilisable avec && / || pour workflows conditionnels

    --quiet, -q         Mode silencieux (supprime tous les logs stderr)
                        Idéal pour capturer uniquement le résultat

    --output FILE, -o   Écrire le résultat dans un fichier
                        Exemple: --output /tmp/result.json

    --verbose, -v       Mode verbeux
    --help, -h          Afficher cette aide

EXEMPLES:
    # Requête simple
    ./query.sh '{ me { id identifier } }'

    # Requête avec variables
    ./query.sh 'query GetProduct($id: ID!) {
      product(id: $id) { name slug }
    }' --vars '{"id": "42"}'

    # Liste des produits
    ./query.sh 'query {
      products {
        totalItems
        items { id name slug }
      }
    }'

    # En tant que superadmin
    ./query.sh --superadmin '{ administrators { items { id } } }'

    # Depuis un fichier
    ./query.sh --file mutations/create-product.graphql --vars '{"name": "Test"}'

    # Juste les données
    ./query.sh '{ me { id } }' --data

    # Historique et ré-exécution
    ./query.sh --history              # Voir les 10 dernières requêtes
    ./query.sh --inspect 3            # Voir query #3 + variables (sans exécuter)
    ./query.sh --last                 # Ré-exécuter la dernière
    ./query.sh -L -s                  # Dernière requête en superadmin
    ./query.sh --replay 3             # Ré-exécuter la requête #3
    ./query.sh -R 3 -s                # Requête #3 en superadmin
    ./query.sh -R 3 --vars '{"id":"5"}'  # Requête #3 avec variables remplacées

    # Modifier des variables avec --set (merge)
    ./query.sh -R 3 --set '.take=10'              # Modifier une variable
    ./query.sh -R 3 --set '.take=10 | .skip=20'   # Modifier plusieurs
    ./query.sh -R 3 --set '.filter.status="active"'  # Objet imbriqué
    ./query.sh -R 3 --set '.take=10' --set '.id="99"'  # Multiples --set

    # Comparer deux exécutions avec --diff
    ./query.sh '{ me { id } }' --diff "--superadmin"  # vendor vs superadmin
    ./query.sh -R 3 --diff "--set '.take=20'"         # take=10 vs take=20
    ./query.sh '{ products { totalItems } }' --diff "--shop"  # admin vs shop

    # Mode compact avec --diff-only (affiche uniquement les valeurs changées)
    ./query.sh -R 3 --diff "--set '.take=1'" --diff-only

    # Prévisualiser sans exécuter avec --dry-run
    ./query.sh '{ products { items { id } } }' --dry-run
    ./query.sh -R 3 --set '.take=10' --superadmin --dry-run
    ./query.sh --file queries/get-product.graphql --vars '{"id":"42"}' --shop --dry-run

    # Générer une commande curl avec --curl
    ./query.sh '{ me { id } }' --curl
    ./query.sh '{ products { items { id } } }' --superadmin --curl
    ./query.sh -R 3 --vars '{"take": 5}' --shop --curl

    # Filtrer avec --jq
    ./query.sh '{ products { totalItems } }' --jq '.data.products.totalItems'
    ./query.sh '{ products { items { id name } } }' --jq '.data.products.items[].name'
    ./query.sh '{ products { items { id name enabled } } }' \
      --jq '.data.products.items[] | select(.enabled == true) | .name'
    ./query.sh '{ products { items { id } } }' --jq '.data.products.items | length'

    # Valider avec --assert (exit 1 si faux)
    ./query.sh '{ products { totalItems } }' --assert '.data.products.totalItems > 0'
    ./query.sh '{ product(id: "1") { id } }' --assert '.data.product != null'

    # Workflows conditionnels avec && / ||
    ./query.sh '{ products { totalItems } }' --assert '.data.products.totalItems > 0' \
      && echo "Catalogue OK" || echo "Catalogue vide!"

    # Combiner --assert et --jq
    ./query.sh '{ products { totalItems } }' \
      --assert '.data.products.totalItems > 0' \
      --jq '.data.products.totalItems'

    # Mode silencieux avec --quiet (capture propre)
    TOTAL=$(./query.sh -q '{ products { totalItems } }' -j '.data.products.totalItems')
    echo "Total: $TOTAL"

    # Écrire dans un fichier avec --output
    ./query.sh '{ products { items { id name } } }' --output /tmp/products.json
    ./query.sh '{ orders { items { id } } }' -o /tmp/orders.json

    # Combiner --quiet et --output (automatisation totale)
    ./query.sh -q '{ products { items { id } } }' -o /tmp/data.json

    # Sauvegarder une requête
    ./query.sh --save get-me '{ me { id } }'
    ./query.sh -f queries/get-me.graphql   # La réutiliser

CACHE:
    Les tokens sont mis en cache pendant 30 minutes pour éviter
    de se ré-authentifier à chaque requête.

    Fichiers de cache : .token-cache.vendor, .token-cache.superadmin
EOF
}

# ═══════════════════════════════════════════════════════════════════════════════
# PARSING DES ARGUMENTS
# ═══════════════════════════════════════════════════════════════════════════════

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --vars|-V)
                VARIABLES="$2"
                shift 2
                ;;
            --set)
                SET_EXPRESSIONS+=("$2")
                shift 2
                ;;
            --diff)
                DIFF_OPTIONS="$2"
                shift 2
                ;;
            --diff-only)
                DIFF_ONLY=true
                shift
                ;;
            --no-fail)
                NO_FAIL=true
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --curl)
                GENERATE_CURL=true
                shift
                ;;
            --jq|-j)
                JQ_FILTER="$2"
                shift 2
                ;;
            --assert|-a)
                ASSERT_EXPR="$2"
                shift 2
                ;;
            --quiet|-q)
                QUIET_MODE=true
                shift
                ;;
            --output|-o)
                OUTPUT_FILE="$2"
                shift 2
                ;;
            --file|-f)
                QUERY_FILE="$2"
                shift 2
                ;;
            --superadmin|-s)
                USE_SUPERADMIN=true
                shift
                ;;
            --env|-e)
                CUSTOM_ENV_PATH="$2"
                shift 2
                ;;
            --raw|-r)
                RAW_OUTPUT=true
                shift
                ;;
            --data|-d)
                ONLY_DATA=true
                shift
                ;;
            --clear-cache|-c)
                CLEAR_CACHE=true
                shift
                ;;
            --timeout|-t)
                TIMEOUT="$2"
                shift 2
                ;;
            --history|-H)
                SHOW_HISTORY=true
                shift
                ;;
            --last|-L)
                RUN_LAST=true
                shift
                ;;
            --replay|-R)
                REPLAY_INDEX="$2"
                shift 2
                ;;
            --inspect|-I)
                INSPECT_INDEX="$2"
                shift 2
                ;;
            --save|-S)
                SAVE_NAME="$2"
                shift 2
                ;;
            --shop|-p)
                USE_SHOP_API=true
                shift
                ;;
            --time|-T)
                SHOW_TIME=true
                shift
                ;;
            --verbose|-v)
                VERBOSE=true
                shift
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            -*)
                log_error "Option inconnue: $1"
                echo "Utilisez --help pour l'aide" >&2
                exit 1
                ;;
            *)
                # C'est la requête
                if [[ -z "$QUERY_ARG" ]]; then
                    QUERY_ARG="$1"
                else
                    log_error "Requête déjà spécifiée"
                    exit 1
                fi
                shift
                ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════════════════════════

main() {
    local query=""

    # Parser les arguments
    parse_args "$@"

    # Commandes spéciales (sans exécution de requête)
    if [[ "$SHOW_HISTORY" == "true" ]]; then
        show_history
        exit 0
    fi

    # Inspecter une requête (affiche sans exécuter)
    if [[ -n "$INSPECT_INDEX" ]]; then
        inspect_query "$INSPECT_INDEX"
        exit 0
    fi

    # Ré-exécuter la dernière requête
    if [[ "$RUN_LAST" == "true" ]]; then
        get_last_query
    fi

    # Ré-exécuter une requête par son index
    if [[ -n "$REPLAY_INDEX" ]]; then
        get_query_by_index "$REPLAY_INDEX"
    fi

    # Déterminer la source de la requête
    if [[ -n "$QUERY_FILE" ]]; then
        # Depuis un fichier
        if [[ ! -f "$QUERY_FILE" ]]; then
            log_error "Fichier introuvable: $QUERY_FILE"
            exit 1
        fi
        query=$(cat "$QUERY_FILE")
        log_verbose "Requête chargée depuis $QUERY_FILE"

    elif [[ -n "$QUERY_ARG" ]]; then
        # Depuis l'argument
        query="$QUERY_ARG"
        log_verbose "Requête depuis argument"

    elif [[ ! -t 0 ]]; then
        # Depuis stdin (pipe ou heredoc)
        query=$(cat)
        log_verbose "Requête lue depuis stdin"

    else
        # Pas de requête fournie
        log_error "Requête requise"
        echo "" >&2
        echo "Usage: ./query.sh 'QUERY'" >&2
        echo "       ./query.sh --file FICHIER.graphql" >&2
        echo "       echo 'QUERY' | ./query.sh" >&2
        echo "" >&2
        echo "Utilisez --help pour plus d'informations" >&2
        exit 1
    fi

    # Vérifier que la requête n'est pas vide
    if [[ -z "$query" || "$query" =~ ^[[:space:]]*$ ]]; then
        log_error "Requête vide"
        exit 1
    fi

    log_verbose "Requête: ${query:0:50}..."

    # Sauvegarder si demandé
    if [[ -n "$SAVE_NAME" ]]; then
        save_query "$SAVE_NAME" "$query"
    fi

    # Mode dry-run : afficher sans exécuter (pas d'authentification)
    if [[ "$DRY_RUN" == "true" ]]; then
        load_api_url
        apply_set_expressions
        show_dry_run "$query"
        exit 0
    fi

    # Obtenir les tokens
    get_tokens

    # Appliquer les expressions --set (merge avec variables existantes)
    apply_set_expressions

    # Mode curl : générer la commande curl équivalente
    if [[ "$GENERATE_CURL" == "true" ]]; then
        generate_curl_command "$query"
        exit 0
    fi

    # Mode diff : comparer deux exécutions
    if [[ -n "$DIFF_OPTIONS" ]]; then
        execute_with_diff "$query"
        exit 0
    fi

    # Ajouter à l'historique
    add_to_history "$query" "$VARIABLES"

    # Exécuter la requête
    execute_query "$query"
}

main "$@"
