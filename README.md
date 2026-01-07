# Vendure Skill for Claude Code

A comprehensive skill for [Claude Code](https://claude.ai/claude-code) to assist with [Vendure](https://www.vendure.io/) e-commerce development.

## What's Included

### Documentation (`references/`)

Curated documentation from the official Vendure docs, organized for optimal AI assistance:

- **Guides/** - Getting started, developer guide, core concepts, deployment
- **reference/** - TypeScript API, GraphQL API, core plugins
- **UI/** - Dashboard components, form inputs, layouts

### Scripts (`scripts/`)

Utility scripts for interacting with Vendure's GraphQL APIs.

#### `login.sh`

Authentication helper that obtains JWT tokens and provides curl examples.

```bash
./login.sh -e user@example.com -p password    # Login with credentials
./login.sh -s -E /path/.env                   # Superadmin login from .env
./login.sh -e user@example.com -p password -x # Export shell variables
./login.sh -e user@example.com -p password -c # Show curl example
```

#### `query.sh`

Powerful GraphQL query executor with history, replay, diff, assertions, and filtering capabilities.

```bash
./query.sh '{ me { id } }'                    # Simple query
./query.sh -s '{ administrators { items { id } } }'  # As superadmin
./query.sh -f queries/get-products.graphql    # From file
./query.sh -H                                 # Show history
./query.sh -R 3                               # Replay query #3
./query.sh -R 3 --diff "--superadmin"         # Compare results
./query.sh --shop '{ products { items { name } } }'  # Shop API
```

**Why `query.sh` is powerful for AI-assisted development:**

This script is designed to be used iteratively by an LLM (like Claude) to build complex workflows. Key features:

- **`--assert`** - Validate conditions before proceeding (e.g., check if product exists)
- **`--jq`** - Extract specific values from responses for use in next queries
- **`--quiet`** - Clean output for variable capture
- **`--no-fail`** - Continue workflow even if a query fails

**Example: AI-driven conditional workflow**

```bash
# 1. Check if products exist
./query.sh '{ products { totalItems } }' --assert '.data.products.totalItems > 0'

# 2. Get first product ID
PRODUCT_ID=$(./query.sh -q '{ products { items { id } } }' --jq '.data.products.items[0].id')

# 3. Use the ID in next query
./query.sh --vars "{\"id\": $PRODUCT_ID}" '
  query($id: ID!) {
    product(id: $id) { name variants { sku } }
  }
'

# 4. Conditional logic based on results
./query.sh '{ orders { totalItems } }' --assert '.data.orders.totalItems > 0' \
  && echo "Orders found, processing..." \
  || echo "No orders, skipping..."
```

An LLM can chain multiple `query.sh` calls to:
- Explore the data model dynamically
- Make decisions based on query results
- Build complex multi-step operations
- Validate state before mutations

See `SKILL.md` for complete documentation of all 25+ options.

## Extending the Scripts

The `scripts/` directory is designed to be extended with your own automation scripts. Here are some ideas:

### Example: Vendor Account Setup

```bash
# create-vendor-account.sh
# Automates vendor registration workflow:
# 1. Register new vendor
# 2. Verify email
# 3. Complete profile
# 4. Admin approval
```

### Example: Catalog Seeder

```bash
# seed-catalog.sh
# Bulk create products from a template:
# - Random product generation
# - Category assignment
# - Variant creation
# - Asset upload
```

### Example: Data Generator

```bash
# generate-test-data.sh
# Create test data for development:
# - Sample customers
# - Test orders
# - Demo products
```

### Example: Certification Workflow

```bash
# request-certification.sh
# Handle custom certification processes:
# - Submit certification request
# - Upload documents
# - Admin approval flow
```

## Prerequisites

For the scripts to work, you need:

- `curl` - HTTP requests
- `jq` - JSON manipulation
- `bash` 5+ - Required for associative arrays (macOS: `brew install bash`)

## Installation

1. Copy the skill to your Claude Code skills directory:
   ```bash
   cp -r Skills-Vendure ~/.claude/skills/Vendure
   ```

2. The skill will be automatically available in Claude Code sessions.

## Contributing

Feel free to submit PRs with:
- Documentation improvements
- New utility scripts
- Bug fixes

## License

MIT
