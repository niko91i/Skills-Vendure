# Vendure Skill for Claude Code

A comprehensive skill providing specialized knowledge for Vendure e-commerce development, extracted from official documentation.

## What is This?

This skill transforms Claude Code into a Vendure development expert by providing:

- Quick Reference patterns for common Vendure tasks
- Comprehensive API documentation (800 pages)
- Core concepts (Money, Orders, Payments, Plugins)
- Developer guides and best practices
- Dashboard and Admin UI development patterns

## Structure

```
Skills-Vendure/
├── SKILL.md                    # Main skill file with Quick Reference patterns
├── references/                 # Detailed documentation
│   ├── api.md                  # TypeScript API reference
│   ├── core_concepts.md        # Foundational architecture
│   ├── developer_guide.md      # Plugin development, strategies
│   ├── getting_started.md      # Setup and configuration
│   ├── how_to.md               # Task-specific tutorials
│   ├── other.md                # Dashboard widgets, deployment
│   └── user_guide.md           # Admin UI usage
├── scripts/                    # Utility scripts
└── assets/                     # Templates and resources
```

## What This Skill Covers

- Headless e-commerce with Node.js/TypeScript and GraphQL
- Custom plugin development with @VendurePlugin decorator
- Payment integration (Stripe, custom handlers)
- Dashboard extensions with React components
- Order workflows and state machines
- Multi-currency and multi-channel configuration
- Custom fields and entity extensions

## Usage

This skill is designed for use with Claude Code. It activates automatically when working with Vendure projects or discussing Vendure-related topics.

The skill follows progressive disclosure:

- **SKILL.md**: Quick Reference with 10 common patterns (~1,846 words)
- **references/**: Detailed documentation loaded as needed

## Documentation Source

All content extracted from official Vendure documentation (https://docs.vendure.io) as of October 2025.

## Quality

- ✅ Zero code duplication between SKILL.md and references
- ✅ 100% imperative/infinitive writing style
- ✅ Skill-creator framework compliant

## Notes

- Compatible with Vendure v3.5.0+
- Reference files contain complete code examples from official docs
- No invented code - all examples verified against official documentation
