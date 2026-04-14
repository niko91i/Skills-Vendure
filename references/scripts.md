# Scripts utilitaires Vendure

Scripts pour interagir avec les APIs GraphQL de Vendure.

## Prérequis

- `curl` - Requêtes HTTP
- `jq` - Manipulation JSON
- `bash` 5+ - Requis pour tableaux associatifs (macOS: `brew install bash`)

## Scripts disponibles

| Script     | Description                                |
| ---------- | ------------------------------------------ |
| `login.sh` | Authentification et aide aux requêtes curl |
| `query.sh` | Exécution simplifiée de requêtes GraphQL   |

## `login.sh` - Authentification et aide curl

Script d'authentification pour obtenir un token JWT et faciliter les requêtes curl.

| Option           | Alias | Description               |
| ---------------- | ----- | ------------------------- |
| `--from-last`    | `-l`  | Utilise last-account.json |
| `--superadmin`   | `-s`  | Mode superadmin           |
| `--email`        | `-e`  | Email de connexion        |
| `--password`     | `-p`  | Mot de passe              |
| `--env`          | `-E`  | Chemin .env               |
| `--export`       | `-x`  | Affiche exports shell     |
| `--curl-example` | `-c`  | Exemple curl complet      |
| `--quiet`        | `-q`  | Mode silencieux           |
| `--verbose`      | `-v`  | Mode verbeux              |

```bash
./login.sh -l                 # Login avec last-account.json
./login.sh -l -c              # Affiche exemple curl complet
./login.sh -l -x              # Affiche exports shell
./login.sh -s -E /path/.env   # Login superadmin
./login.sh -e x@y.com -p z    # Login manuel
./login.sh -l -q              # Mode silencieux (scripts)
```

## `query.sh` - Requêtes GraphQL simplifiées

| Option          | Alias | Description                                                     |
| --------------- | ----- | --------------------------------------------------------------- |
| `--vars`        | `-V`  | Variables GraphQL JSON (remplace tout)                          |
| `--set`         | -     | Modifier une variable (merge jq)                                |
| `--file`        | `-f`  | Fichier .graphql                                                |
| `--superadmin`  | `-s`  | Mode superadmin                                                 |
| `--env`         | `-e`  | Chemin .env                                                     |
| `--raw`         | `-r`  | Sortie JSON brute                                               |
| `--data`        | `-d`  | Affiche seulement .data                                         |
| `--clear-cache` | `-c`  | Force reconnexion                                               |
| `--timeout`     | `-t`  | Timeout en secondes                                             |
| `--history`     | `-H`  | Affiche les 10 dernières requêtes                               |
| `--last`        | `-L`  | Ré-exécute la dernière requête                                  |
| `--replay N`    | `-R`  | Ré-exécute la requête #N de l'historique                        |
| `--inspect N`   | `-I`  | Affiche query #N + variables (sans exécuter)                    |
| `--save NAME`   | `-S`  | Sauvegarde dans `queries/NAME.graphql`                          |
| `--shop`        | `-p`  | Utilise `/shop-api` au lieu de `/admin-api`                     |
| `--time`        | `-T`  | Affiche le temps d'exécution                                    |
| `--diff "OPTS"` | -     | Compare 2 exécutions (avant/après OPTS)                         |
| `--diff-only`   | -     | Avec --diff: affiche uniquement les valeurs changées            |
| `--no-fail`     | -     | Ne pas exit 1 sur erreur GraphQL (continuer malgré les erreurs) |
| `--dry-run`     | -     | Affiche la requête sans l'exécuter (pas d'auth)                 |
| `--curl`        | -     | Génère la commande curl équivalente (copier-coller)             |
| `--jq FILTER`   | `-j`  | Appliquer un filtre jq sur le résultat                          |
| `--assert EXPR` | `-a`  | Valider une condition jq (exit 1 si fausse)                     |
| `--quiet`       | `-q`  | Mode silencieux (supprime tous les logs stderr)                 |
| `--output FILE` | `-o`  | Écrire le résultat dans un fichier                              |
| `--verbose`     | `-v`  | Mode verbeux                                                    |

### Exemples d'utilisation

```bash
./query.sh '{ me { id } }'            # Requête simple
./query.sh -d '{ me { id } }'         # Affiche seulement .data
./query.sh -s -e /path/.env '{ administrators { totalItems } }'
./query.sh -c '{ me { id } }'         # Force reconnexion
./query.sh -t 60 '{ me { id } }'      # Timeout 60s (défaut: 30s)
./query.sh -s -c -d '{ me { id } }'   # Combinaison d'alias

# Historique et Replay (50 requêtes max, style Burp Repeater)
./query.sh -H                         # Affiche les 10 dernières
./query.sh -I 3                       # Inspecte query #3 + variables (sans exécuter)
./query.sh -L                         # Ré-exécute la dernière
./query.sh -L -s                      # Dernière requête en superadmin
./query.sh -R 3                       # Ré-exécute la requête #3
./query.sh -R 3 -s                    # Requête #3 en superadmin
./query.sh -R 3 --vars '{"take": 5}'  # Requête #3 avec variables remplacées
./query.sh -R 3 --shop                # Requête #3 sur shop-api
./query.sh -R 3 -T                    # Requête #3 avec timing

# Modifier des variables avec --set (merge intelligent)
./query.sh -R 3 --set '.take=10'                    # Modifier une variable
./query.sh -R 3 --set '.take=10 | .skip=20'         # Modifier plusieurs (pipe jq)
./query.sh -R 3 --set '.filter.status="active"'     # Objet imbriqué
./query.sh -R 3 --set '.take=10' --set '.id="99"'   # Multiples --set

# Comparer deux exécutions avec --diff
./query.sh '{ me { id } }' --diff "--superadmin"    # vendor vs superadmin
./query.sh -R 3 --diff "--set '.take=20'"           # take=10 vs take=20
./query.sh '{ products { totalItems } }' --diff "--shop"  # admin vs shop

# Mode compact avec --diff-only (affiche uniquement les chemins JSON modifiés)
./query.sh -R 3 --diff "--set '.take=1'" --diff-only

# Prévisualiser sans exécuter avec --dry-run (pas d'authentification)
./query.sh '{ products { items { id } } }' --dry-run
./query.sh -R 3 --set '.take=10' --superadmin --dry-run
./query.sh --file queries/get-product.graphql --vars '{"id":"42"}' --shop --dry-run

# Générer une commande curl équivalente (copier-coller)
./query.sh '{ me { id } }' --curl
./query.sh '{ products { items { id } } }' --superadmin --curl
./query.sh -R 3 --vars '{"take": 5}' --shop --curl

# Filtrer les résultats avec --jq
./query.sh '{ products { totalItems } }' --jq '.data.products.totalItems'
./query.sh '{ products { items { name } } }' --jq '.data.products.items[].name'
./query.sh '{ products { items { id name enabled } } }' \
  --jq '.data.products.items[] | select(.enabled == true) | .name'
./query.sh '{ products { items { id } } }' -j '.data.products.items | length'

# Valider avec --assert (exit 1 si condition fausse)
./query.sh '{ products { totalItems } }' --assert '.data.products.totalItems > 0'
./query.sh '{ product(id: "1") { id } }' -a '.data.product | type == "object"'

# Workflows conditionnels avec && / ||
./query.sh '{ products { totalItems } }' --assert '.data.products.totalItems > 0' \
  && echo "Catalogue OK" || echo "Catalogue vide!"

# Combiner --assert et --jq (valider puis extraire)
./query.sh '{ products { totalItems } }' \
  --assert '.data.products.totalItems > 0' \
  --jq '.data.products.totalItems'

# Mode silencieux avec --quiet (capture propre)
TOTAL=$(./query.sh -q '{ products { totalItems } }' -j '.data.products.totalItems')
echo "Total: $TOTAL"

# Écrire dans un fichier avec --output
./query.sh '{ products { items { id name } } }' --output /tmp/products.json
./query.sh '{ orders { items { id } } }' -o /tmp/orders.json

# Automatisation totale : --quiet + --output + --assert + --jq
./query.sh -q '{ products { totalItems } }' \
  --assert '.data.products.totalItems > 0' \
  --jq '.data.products.totalItems' \
  -o /tmp/count.txt

# Sauvegarde
./query.sh -S get-me '{ me { id } }'  # Sauvegarde dans queries/get-me.graphql
./query.sh -f queries/get-me.graphql  # Charge et exécute

# Requête multi-lignes (guillemets simples)
./query.sh '
query {
  products(options: { take: 5 }) {
    items { id name }
  }
}
'

# Avec variables (utiliser heredoc si la requête contient !)
./query.sh --vars '{"id": "42"}' <<'EOF'
query GetProduct($id: ID!) {
  product(id: $id) { name }
}
EOF

# Depuis stdin
echo '{ me { id } }' | ./query.sh

# Shop API (storefront)
./query.sh --shop '{ products { items { id name } } }'
./query.sh --shop '{ activeCustomer { id emailAddress } }'

# Mesure du temps d'exécution
./query.sh -T '{ me { id } }'             # Affiche "⏱ 74ms"
./query.sh -s -T '{ administrators { totalItems } }'
./query.sh --shop -T '{ products { items { id } } }'
```

> **Limitation** : Le caractère `!` (ex: `ID!`) pose problème en inline à cause
> du history expansion bash. Si erreur "Unexpected character", utiliser **heredoc**
> (`<<'EOF'`) ou **fichier** (`--file query.graphql`) à la place des guillemets simples.

## Workflow de débogage (style Burp Repeater)

Le système d'historique et replay permet de déboguer efficacement les requêtes GraphQL :

```bash
# 1. Exécuter une requête qui échoue ou retourne des résultats inattendus
./query.sh '{ products(options: { take: 5 }) { items { id name } } }'

# 2. Consulter l'historique pour voir les requêtes récentes
./query.sh -H

# 3. Inspecter une requête AVANT de la rejouer (voir query + variables)
./query.sh -I 2

# 4. Rejouer une requête avec modifications
./query.sh -R 2                       # Identique
./query.sh -R 2 -s                    # En superadmin (voir plus de données)
./query.sh -R 2 --vars '{"take": 10}' # Remplacer toutes les variables
./query.sh -R 2 --shop                # Sur shop-api au lieu d'admin-api

# 5. Modifier des variables spécifiques avec --set (merge)
./query.sh -R 2 --set '.take=10'                  # Modifier une seule variable
./query.sh -R 2 --set '.filter.status="pending"'  # Modifier un objet imbriqué
./query.sh -R 2 --set '.take=10' --set '.skip=5'  # Modifier plusieurs variables

# 6. Comparer les résultats avec --diff
./query.sh -R 2 --diff "--superadmin"             # vendor vs superadmin (diff coloré)
./query.sh -R 2 --diff "--set '.take=10'"         # take=5 vs take=10
./query.sh -R 2 --diff "--shop"                   # admin-api vs shop-api
./query.sh -R 2 --diff "--set '.take=1'" --diff-only  # Mode compact (chemins JSON)
```

**Cas d'usage typiques :**

- **Inspecter avant de rejouer** : voir la query complète et ses variables avec `-I`
- **Prévisualiser sans exécuter** : utiliser `--dry-run` pour voir query/variables/auth/endpoint sans connexion
- **Générer curl** : utiliser `--curl` pour obtenir une commande curl copier-coller (Postman, CI/CD, partage)
- **Modifier chirurgicalement** : utiliser `--set` pour changer une variable sans tout retaper
- **Comparer rapidement** : utiliser `--diff` pour voir les différences, `--diff-only` pour le format compact
- **Valider avant d'agir** : utiliser `--assert` pour vérifier des conditions (workflows conditionnels)
- **Continuer malgré les erreurs** : utiliser `--no-fail` pour enchaîner plusieurs requêtes sans interruption
- **Extraire et filtrer** : utiliser `--jq` pour extraire des valeurs spécifiques
- **Capturer proprement** : utiliser `--quiet` pour supprimer les logs et capturer uniquement le résultat
- **Sauvegarder les résultats** : utiliser `--output` pour écrire dans un fichier (JSON propre sans couleurs)

## Fichiers générés

- `last-account.json` : Credentials du dernier compte créé (email, password, vendorId)
- `.token-cache.vendor` : Cache des tokens vendeur (30 min)
- `.token-cache.superadmin` : Cache des tokens superadmin (30 min)
- `.query-history` : Historique des 50 dernières requêtes GraphQL
- `queries/` : Requêtes GraphQL sauvegardées avec `--save`
