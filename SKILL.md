---
name: vendure
description: "Assiste au développement avec le framework e-commerce Vendure pour Node.js. Gère le commerce headless, les APIs GraphQL, la gestion des commandes, les catalogues produits, l'intégration des paiements et le développement TypeScript e-commerce. Utiliser lors du travail sur des projets Vendure, la création de plugins, ou l'intégration de storefronts."
---

# Vendure E-Commerce Framework Skill

Assistance complète pour le développement Vendure, générée à partir de la documentation officielle (docs.vendure.io).

## Quand utiliser ce Skill

- Travail avec les APIs GraphQL Vendure, plugins ou configuration
- Construction ou intégration de storefronts headless (Next.js, Remix)
- Implémentation de handlers de paiement/livraison ou custom fields
- Extension du Dashboard Vendure avec des composants React

## Concepts Clés

- **Order State Machine** — Workflow personnalisable (AddingItems → Delivered) via OrderProcess avec interceptors
- **Custom Fields** — Ajouter des propriétés aux entités via VendureConfig, extension automatique du schema GraphQL, support des relations et 10+ types de champs
- **Plugins** — Extensibilité via décorateur `@VendurePlugin`, hooks de cycle de vie, pattern InjectableStrategy pour comportement pluggable

## Exemples Rapides

### Créer un Plugin

```typescript
import { VendurePlugin, PluginCommonModule } from '@vendure/core';

@VendurePlugin({
  imports: [PluginCommonModule],
  configuration: config => {
    // Modifier VendureConfig ici
    return config;
  },
})
export class MyPlugin {}
// Ajouter dans vendure-config.ts: plugins: [MyPlugin]
// Vérifier: yarn dev → le serveur démarre sans erreur
```

### Ajouter des Custom Fields

```typescript
// vendure-config.ts
customFields: {
  Product: [
    { name: 'internalNote', type: 'string' },
    { name: 'weight', type: 'float', defaultValue: 0 },
  ],
}
// Vérifier: lancer une migration, puis tester:
// query { product(id: "1") { customFields { internalNote weight } } }
```

### Handler de Paiement

```typescript
import { PaymentMethodHandler, LanguageCode } from '@vendure/core';

export const myPaymentHandler = new PaymentMethodHandler({
  code: 'my-payment',
  description: [{ languageCode: LanguageCode.en, value: 'My Payment' }],
  args: { apiKey: { type: 'string' } },
  createPayment: async (ctx, order, amount, args) => {
    // Appeler l'API de paiement externe avec args.apiKey
    return { amount, state: 'Settled', transactionId: 'txn_123' };
  },
  settlePayment: async () => ({ success: true }),
});
// Enregistrer: paymentOptions: { paymentMethodHandlers: [myPaymentHandler] }
// Vérifier: Admin → Settings → Payment Methods → ajouter la méthode
```

## Guide de Navigation

### 📚 references/Guides/ — Guides Pratiques (~16,000 lignes)

| Fichier                      | Contenu                                        | Quand consulter               |
| ---------------------------- | ---------------------------------------------- | ----------------------------- |
| `getting-started.md`         | Installation, création projet, premiers pas    | **Démarrer un projet**        |
| `developer-guide.md`         | Architecture, API Layer, Middleware, NestJS     | **Comprendre l'architecture** |
| `core-concepts.md`           | Collections, Money, Assets, Taxes, Payment     | **Concepts fondamentaux**     |
| `how-to.md`                  | Custom fields, paiements, shipping calculators  | **Tutoriels spécifiques**     |
| `extending-the-dashboard.md` | Extensions React, routes, pages personnalisées | **Personnaliser l'admin**     |
| `storefront.md`              | Next.js, Remix, connexion API, starters        | **Créer un storefront**       |
| `deployment.md`              | Docker, production, sécurité, HardenPlugin     | **Déployer en production**    |
| `user-guide.md`              | Utilisation Dashboard pour administrateurs     | **Former les utilisateurs**   |
| `migrating-from-v1.md`       | Breaking changes, guide de migration v1→v2     | **Migration de version**      |

### 📖 references/reference/ — Documentation API (~39,000 lignes)

| Fichier             | Contenu                                              | Quand consulter                  |
| ------------------- | ---------------------------------------------------- | -------------------------------- |
| `typescript-api.md` | **TOUT** : Classes, interfaces, strategies, services | **Recherche API TypeScript**     |
| `graphql-api.md`    | Shop API, Admin API, queries, mutations              | **Requêtes GraphQL**             |
| `core-plugins.md`   | EmailPlugin, AssetServerPlugin, HardenPlugin, etc.   | **Configurer plugins officiels** |
| `dashboard.md`      | React hooks, composants Dashboard, extensions        | **Développer extensions React**  |
| `admin-ui-api.md`   | API Angular (deprecated), composants legacy          | **Maintenir code Angular**       |

**Fichier clé : `typescript-api.md`** — Contient TOUTES les interfaces et classes Vendure.

### 🎨 references/UI/ — Composants Dashboard React (~4,500 lignes)

| Fichier                         | Contenu                                            | Quand consulter          |
| ------------------------------- | -------------------------------------------------- | ------------------------ |
| `ui.md`                         | 42 composants : Button, Dialog, Card, Badge, etc.  | **Éléments UI de base**  |
| `form-inputs.md`                | 11 composants : TextInput, SelectInput, DatePicker | **Formulaires**          |
| `layout.md`                     | DetailPage, ListPage, PageLayout, TabsLayout       | **Structure de pages**   |
| `framework.md`                  | DataTable, AssetGallery, PaginationControls        | **Affichage de données** |
| `VENDURE_UI_COMPONENTS_BASE.md` | Documentation de base des composants               | **Référence rapide**     |

```tsx
// Import standard
import { Button, Card, Dialog, Badge } from '@vendure/dashboard';
import { TextInput, SelectInput } from '@vendure/dashboard';
import { DetailPage, ListPage } from '@vendure/dashboard';
```

## Workflows par Niveau

### 🟢 Débutant — Premier projet

1. **Démarrer** → `references/Guides/getting-started.md` → vérifier avec `yarn dev`. Si le serveur ne démarre pas, vérifier les versions Node.js (>=18) et les dépendances (`yarn install`).
2. **Comprendre** → `references/Guides/core-concepts.md` (Money, Collections)
3. **Construire** → `references/Guides/how-to.md`
4. **Tester** → GraphQL Playground à `/shop-api` → exécuter `{ products { items { id name } } }` pour valider la connexion API

### 🟡 Intermédiaire — Fonctionnalités personnalisées

1. **Rechercher API** → grep `references/reference/typescript-api.md` pour le service/interface
2. **Créer plugins** → `references/Guides/developer-guide.md` → vérifier que le plugin charge au démarrage. Si erreur, exécuter `yarn build` pour voir les erreurs TypeScript.
3. **Paiements** → `references/reference/core-plugins.md` (StripePlugin) → tester avec un checkout de test. Vérifier les logs serveur pour les erreurs webhook.
4. **Emails** → `references/reference/core-plugins.md` (EmailPlugin) → vérifier le rendu avec le devMode mailbox à `/mailbox`

### 🔴 Avancé — Architecture & Production

1. **Architecture** → `references/Guides/developer-guide.md` (API Layer, Middleware)
2. **Dashboard custom** → `references/UI/` + `references/Guides/extending-the-dashboard.md` → vérifier que le composant s'affiche dans l'admin. Si erreur de rendu, vérifier les imports depuis `@vendure/dashboard`.
3. **Sécurité** → `references/Guides/deployment.md` (HardenPlugin, OWASP) → exécuter la checklist de sécurité
4. **Performance** → State machines, caching → profiler avec le flag `--time` de query.sh

## Rechercher dans les fichiers

```bash
grep -rn "PaymentMethodHandler" references/           # Trouver une classe/interface
grep -rn "useDetailPage" references/reference/         # Trouver un hook React
grep -n "^## " references/reference/typescript-api.md | head -30  # Lister les sections
```

## Scripts

Scripts utilitaires pour interagir avec les APIs GraphQL de Vendure. Requiert `curl`, `jq`, `bash 5+`.

| Script     | Description                                           |
| ---------- | ----------------------------------------------------- |
| `login.sh` | Authentification JWT et aide aux requêtes curl         |
| `query.sh` | Exécuteur de requêtes GraphQL avec historique, replay, diff, assertions |

```bash
./login.sh -l                    # Login avec last-account.json
./query.sh '{ me { id } }'      # Requête simple
./query.sh -R 3 --diff "--shop"  # Comparer résultats admin vs shop API
```

Voir `references/scripts.md` pour la documentation complète des 25+ options, workflows et exemples.

## Notes

- Toutes les valeurs monétaires sont des entiers (diviser par 100 pour l'affichage)
- GraphQL : Shop API pour storefront, Admin API pour gestion
- Le Dashboard utilise React + TailwindCSS — toujours importer depuis `@vendure/dashboard`
