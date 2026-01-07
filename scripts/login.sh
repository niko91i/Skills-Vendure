#!/usr/bin/env bash
##
# login.sh - Authentification Vendure et aide aux requêtes curl
#
# Script utilitaire pour obtenir un token d'authentification Vendure
# et afficher les informations nécessaires pour les requêtes curl.
#
# Usage:
#   ./login.sh --email vendor@test.com --password test123
#   ./login.sh --from-last
#   ./login.sh --superadmin
#   ./login.sh --from-last --curl-example
#   ./login.sh --from-last --export
#
# Prérequis:
#   - curl, jq installés
#   - Serveur Vendure accessible
#   - Fichier .env configuré (pour --superadmin)
##

set -euo pipefail

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAST_ACCOUNT_FILE="$SCRIPT_DIR/last-account.json"

# Chercher le fichier .env dans plusieurs emplacements
find_env_file() {
    local search_paths=(
        "$SCRIPT_DIR/.env"
        "$SCRIPT_DIR/../.env"
        "$SCRIPT_DIR/../../.env"
        "${VENDURE_ENV_FILE:-}"
    )

    for path in "${search_paths[@]}"; do
        if [[ -n "$path" && -f "$path" ]]; then
            echo "$path"
            return 0
        fi
    done

    # Non trouvé
    return 1
}

ENV_FILE=""

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
SHOW_EXPORT=false
SHOW_CURL_EXAMPLE=false
FROM_LAST=false
USE_SUPERADMIN=false
QUIET=false
CUSTOM_ENV_PATH=""

# Credentials
USER_EMAIL=""
USER_PASSWORD=""

# Résultats
AUTH_TOKEN=""
CHANNEL_TOKEN=""
USER_ID=""
USER_IDENTIFIER=""

# ═══════════════════════════════════════════════════════════════════════════════
# FONCTIONS UTILITAIRES
# ═══════════════════════════════════════════════════════════════════════════════

log_error() {
    echo -e "${RED}✗ ERREUR: $1${NC}" >&2
}

log_success() {
    if [[ "$QUIET" != "true" ]]; then
        echo -e "${GREEN}✓ $1${NC}" >&2
    fi
}

log_info() {
    if [[ "$QUIET" != "true" ]]; then
        echo -e "${BLUE}ℹ $1${NC}" >&2
    fi
}

log_verbose() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${DIM}  → $1${NC}" >&2
    fi
}

log_warning() {
    echo -e "${YELLOW}⚠ $1${NC}" >&2
}

# ═══════════════════════════════════════════════════════════════════════════════
# CHARGEMENT DES CREDENTIALS
# ═══════════════════════════════════════════════════════════════════════════════

##
# Charge les credentials depuis last-account.json
##
load_from_last_account() {
    if [[ ! -f "$LAST_ACCOUNT_FILE" ]]; then
        log_error "Fichier $LAST_ACCOUNT_FILE introuvable"
        log_info "Créez d'abord un compte avec: ./create-vendor-account.sh"
        exit 1
    fi

    log_verbose "Chargement depuis $LAST_ACCOUNT_FILE"

    USER_EMAIL=$(jq -r '.email // empty' "$LAST_ACCOUNT_FILE")
    USER_PASSWORD=$(jq -r '.password // empty' "$LAST_ACCOUNT_FILE")

    if [[ -z "$USER_EMAIL" || -z "$USER_PASSWORD" ]]; then
        log_error "Credentials invalides dans $LAST_ACCOUNT_FILE"
        exit 1
    fi

    log_verbose "Email: $USER_EMAIL"
}

##
# Charge les credentials super admin depuis .env
##
load_superadmin_credentials() {
    # Utiliser le chemin personnalisé ou chercher automatiquement
    if [[ -n "$CUSTOM_ENV_PATH" ]]; then
        ENV_FILE="$CUSTOM_ENV_PATH"
    else
        ENV_FILE=$(find_env_file) || true
    fi

    if [[ -z "$ENV_FILE" || ! -f "$ENV_FILE" ]]; then
        log_error "Fichier .env introuvable"
        echo "" >&2
        echo "Recherché dans:" >&2
        echo "  - $SCRIPT_DIR/.env" >&2
        echo "  - $SCRIPT_DIR/../.env" >&2
        echo "  - $SCRIPT_DIR/../../.env" >&2
        echo "" >&2
        echo "Options:" >&2
        echo "  --env /chemin/vers/.env    Spécifier le chemin" >&2
        echo "  export VENDURE_ENV_FILE=/chemin/vers/.env" >&2
        exit 1
    fi

    log_verbose "Chargement superadmin depuis $ENV_FILE"

    # Source le fichier .env
    set -a
    # shellcheck source=/dev/null
    source "$ENV_FILE"
    set +a

    # Support pour SUPERADMIN_USERNAME ou SUPERADMIN_IDENTIFIER
    USER_EMAIL="${SUPERADMIN_USERNAME:-${SUPERADMIN_IDENTIFIER:-}}"
    USER_PASSWORD="${SUPERADMIN_PASSWORD:-}"

    if [[ -z "$USER_EMAIL" || -z "$USER_PASSWORD" ]]; then
        log_error "Variables SUPERADMIN_USERNAME et SUPERADMIN_PASSWORD requises dans .env"
        exit 1
    fi

    log_verbose "Superadmin: $USER_EMAIL"
}

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION API
# ═══════════════════════════════════════════════════════════════════════════════

##
# Charge la configuration API depuis .env
##
load_api_config() {
    # Chercher le .env si pas déjà défini
    if [[ -z "$ENV_FILE" ]]; then
        if [[ -n "$CUSTOM_ENV_PATH" ]]; then
            ENV_FILE="$CUSTOM_ENV_PATH"
        else
            ENV_FILE=$(find_env_file) || true
        fi
    fi

    if [[ -n "$ENV_FILE" && -f "$ENV_FILE" ]]; then
        log_verbose "Configuration depuis $ENV_FILE"
        set -a
        # shellcheck source=/dev/null
        source "$ENV_FILE"
        set +a
    fi

    API_URL="${API_URL:-http://localhost:3000}"
    CHANNEL_TOKEN="${VENDURE_CHANNEL_TOKEN:-${CHANNEL_TOKEN:-}}"

    log_verbose "API URL: $API_URL"
    log_verbose "Channel Token: ${CHANNEL_TOKEN:-<non défini>}"
}

# ═══════════════════════════════════════════════════════════════════════════════
# AUTHENTIFICATION
# ═══════════════════════════════════════════════════════════════════════════════

##
# Effectue le login et récupère le token
##
do_login() {
    log_info "Connexion en cours..."
    log_verbose "Email: $USER_EMAIL"

    local mutation='
    mutation Login($username: String!, $password: String!) {
        login(username: $username, password: $password) {
            __typename
            ... on CurrentUser {
                id
                identifier
                channels {
                    id
                    code
                    token
                }
            }
            ... on InvalidCredentialsError {
                message
                authenticationError
            }
            ... on NativeAuthStrategyError {
                message
            }
        }
    }'

    local variables
    variables=$(jq -n \
        --arg username "$USER_EMAIL" \
        --arg password "$USER_PASSWORD" \
        '{username: $username, password: $password}')

    local curl_args=(-s -i -X POST "${API_URL}/admin-api"
        -H "Content-Type: application/json")

    # Ajouter le channel token si disponible
    if [[ -n "${CHANNEL_TOKEN:-}" ]]; then
        curl_args+=(-H "vendure-token: $CHANNEL_TOKEN")
    fi

    curl_args+=(-d "$(jq -n --arg q "$mutation" --argjson v "$variables" '{query: $q, variables: $v}')")

    local response
    response=$(curl "${curl_args[@]}" 2>/dev/null)

    # Extraire le token d'authentification des headers
    AUTH_TOKEN=$(echo "$response" | grep -i "vendure-auth-token:" | sed 's/.*: *//' | tr -d '\r\n')

    # Extraire le body JSON
    local body
    body=$(echo "$response" | sed -n '/^{/,/}$/p' | tail -1)

    if [[ -z "$body" ]]; then
        # Essayer de trouver le JSON après les headers
        body=$(echo "$response" | awk '/^\r?$/,0' | grep -v '^$' | head -1)
    fi

    log_verbose "Response body: $body"

    # Vérifier le résultat
    local typename
    typename=$(echo "$body" | jq -r '.data.login.__typename // empty')

    case "$typename" in
        "CurrentUser")
            USER_ID=$(echo "$body" | jq -r '.data.login.id')
            USER_IDENTIFIER=$(echo "$body" | jq -r '.data.login.identifier')

            # Récupérer le channel token si pas déjà défini
            if [[ -z "${CHANNEL_TOKEN:-}" ]]; then
                CHANNEL_TOKEN=$(echo "$body" | jq -r '.data.login.channels[0].token // empty')
            fi

            log_success "Authentifié: $USER_IDENTIFIER"
            ;;
        "InvalidCredentialsError")
            local msg
            msg=$(echo "$body" | jq -r '.data.login.message')
            log_error "Credentials invalides: $msg"
            exit 1
            ;;
        "NativeAuthStrategyError")
            local msg
            msg=$(echo "$body" | jq -r '.data.login.message')
            log_error "Erreur d'authentification: $msg"
            exit 1
            ;;
        *)
            log_error "Réponse inattendue: $typename"
            log_verbose "Body: $body"

            # Vérifier si erreur GraphQL
            local errors
            errors=$(echo "$body" | jq -r '.errors[0].message // empty')
            if [[ -n "$errors" ]]; then
                log_error "GraphQL: $errors"
            fi
            exit 1
            ;;
    esac

    if [[ -z "$AUTH_TOKEN" ]]; then
        log_error "Token d'authentification non reçu"
        exit 1
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# AFFICHAGE DES RÉSULTATS
# ═══════════════════════════════════════════════════════════════════════════════

##
# Affiche les informations d'authentification
##
show_auth_info() {
    echo ""
    echo -e "${BOLD}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}${BOLD}🔐 AUTHENTIFICATION RÉUSSIE${NC}"
    echo -e "${BOLD}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "  ${DIM}Utilisateur:${NC}  ${CYAN}$USER_IDENTIFIER${NC}"
    echo -e "  ${DIM}User ID:${NC}      ${CYAN}$USER_ID${NC}"
    echo ""
    echo -e "  ${BOLD}AUTH_TOKEN:${NC}"
    echo -e "  ${YELLOW}$AUTH_TOKEN${NC}"
    echo ""
    if [[ -n "${CHANNEL_TOKEN:-}" ]]; then
        echo -e "  ${BOLD}CHANNEL_TOKEN:${NC}"
        echo -e "  ${YELLOW}$CHANNEL_TOKEN${NC}"
        echo ""
    fi
    echo -e "${BOLD}═══════════════════════════════════════════════════════════════${NC}"
}

##
# Affiche les commandes export
##
show_export_commands() {
    echo ""
    echo -e "${MAGENTA}${BOLD}# Variables d'environnement:${NC}"
    echo ""
    echo "export VENDURE_AUTH_TOKEN=\"$AUTH_TOKEN\""
    if [[ -n "${CHANNEL_TOKEN:-}" ]]; then
        echo "export VENDURE_CHANNEL_TOKEN=\"$CHANNEL_TOKEN\""
    fi
    echo "export VENDURE_API_URL=\"$API_URL\""
    echo ""
    echo -e "${DIM}# Copier-coller ces lignes dans votre terminal${NC}"
}

##
# Affiche un exemple de requête curl
##
show_curl_example() {
    echo ""
    echo -e "${MAGENTA}${BOLD}# Exemple de requête curl:${NC}"
    echo ""

    local channel_header=""
    if [[ -n "${CHANNEL_TOKEN:-}" ]]; then
        channel_header="  -H \"vendure-token: $CHANNEL_TOKEN\" \\"$'\n'
    fi

    cat << EOF
curl -X POST "${API_URL}/admin-api" \\
  -H "Content-Type: application/json" \\
  -H "Authorization: Bearer $AUTH_TOKEN" \\
${channel_header}  -d '{
    "query": "{ me { id identifier } }"
  }'
EOF

    echo ""
    echo -e "${DIM}# Headers requis:${NC}"
    echo -e "${DIM}#   - Content-Type: application/json${NC}"
    echo -e "${DIM}#   - Authorization: Bearer <AUTH_TOKEN>${NC}"
    if [[ -n "${CHANNEL_TOKEN:-}" ]]; then
        echo -e "${DIM}#   - vendure-token: <CHANNEL_TOKEN> (pour le canal spécifique)${NC}"
    fi
}

##
# Affiche l'aide
##
show_help() {
    cat << 'EOF'
login.sh - Authentification Vendure et aide aux requêtes curl

USAGE:
    ./login.sh [OPTIONS]

OPTIONS:
    --email EMAIL       Email de connexion
    --password PASS     Mot de passe

    --from-last         Utiliser les credentials du dernier compte créé
                        (depuis last-account.json)

    --superadmin        Se connecter en tant que super admin
                        (credentials depuis .env)

    --env PATH          Chemin vers le fichier .env
                        (cherche automatiquement si non spécifié)

    --export            Afficher les commandes export pour le shell
    --curl-example      Afficher un exemple de requête curl complet

    --quiet, -q         Mode silencieux (seulement les tokens)
    --verbose, -v       Mode verbeux (debug)
    --help, -h          Afficher cette aide

EXEMPLES:
    # Login avec email/password
    ./login.sh --email vendor@test.com --password test123

    # Login avec le dernier compte créé
    ./login.sh --from-last

    # Login superadmin avec exemple curl
    ./login.sh --superadmin --curl-example

    # Login superadmin avec .env personnalisé
    ./login.sh --superadmin --env /path/to/project/.env

    # Obtenir les exports pour le shell
    ./login.sh --from-last --export

    # Mode silencieux (pour scripts)
    ./login.sh --from-last -q

FICHIERS:
    .env                Configuration API et credentials superadmin
                        (cherché dans: ./  ../  ../../)
    last-account.json   Dernier compte vendor créé

VARIABLES D'ENVIRONNEMENT:
    VENDURE_ENV_FILE    Chemin alternatif vers .env

VARIABLES .env:
    API_URL                 URL de l'API Vendure (défaut: http://localhost:3000)
    VENDURE_CHANNEL_TOKEN   Token du canal (optionnel)
    SUPERADMIN_USERNAME     Email du super admin
    SUPERADMIN_PASSWORD     Mot de passe du super admin
EOF
}

# ═══════════════════════════════════════════════════════════════════════════════
# PARSING DES ARGUMENTS
# ═══════════════════════════════════════════════════════════════════════════════

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --email|-e)
                USER_EMAIL="$2"
                shift 2
                ;;
            --password|-p)
                USER_PASSWORD="$2"
                shift 2
                ;;
            --from-last|-l)
                FROM_LAST=true
                shift
                ;;
            --superadmin|-s)
                USE_SUPERADMIN=true
                shift
                ;;
            --env|-E)
                CUSTOM_ENV_PATH="$2"
                shift 2
                ;;
            --export|-x)
                SHOW_EXPORT=true
                shift
                ;;
            --curl-example|-c)
                SHOW_CURL_EXAMPLE=true
                shift
                ;;
            --quiet|-q)
                QUIET=true
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
            *)
                log_error "Option inconnue: $1"
                echo "Utilisez --help pour l'aide"
                exit 1
                ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════════════════════════

main() {
    parse_args "$@"

    # Charger la config API
    load_api_config

    # Déterminer la source des credentials
    if [[ "$USE_SUPERADMIN" == "true" ]]; then
        load_superadmin_credentials
    elif [[ "$FROM_LAST" == "true" ]]; then
        load_from_last_account
    elif [[ -z "$USER_EMAIL" || -z "$USER_PASSWORD" ]]; then
        log_error "Credentials requis"
        echo ""
        echo "Utilisez l'une de ces options:"
        echo "  --email EMAIL --password PASS"
        echo "  --from-last"
        echo "  --superadmin"
        echo ""
        echo "Ou --help pour plus d'informations"
        exit 1
    fi

    # Effectuer le login
    do_login

    # Affichage selon les options
    if [[ "$QUIET" == "true" ]]; then
        # Mode silencieux: juste les tokens
        echo "AUTH_TOKEN=$AUTH_TOKEN"
        if [[ -n "${CHANNEL_TOKEN:-}" ]]; then
            echo "CHANNEL_TOKEN=$CHANNEL_TOKEN"
        fi
    else
        # Affichage standard
        show_auth_info

        if [[ "$SHOW_EXPORT" == "true" ]]; then
            show_export_commands
        fi

        if [[ "$SHOW_CURL_EXAMPLE" == "true" ]]; then
            show_curl_example
        fi

        # Si aucune option d'affichage supplémentaire, suggérer
        if [[ "$SHOW_EXPORT" != "true" && "$SHOW_CURL_EXAMPLE" != "true" ]]; then
            echo ""
            echo -e "${DIM}Astuce: Utilisez --export ou --curl-example pour plus d'options${NC}"
        fi
    fi
}

main "$@"
