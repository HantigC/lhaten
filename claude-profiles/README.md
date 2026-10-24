# claude-profiles

Launch Claude Code with a minimal, isolated config instead of everything in `~/.claude`.

```bash
claude-as builder          # only the builder profile's agents, skills, commands, MCP servers
claude-as dev -p "fix the failing test"   # extra args pass through to claude
```

Each profile runs with its own `CLAUDE_CONFIG_DIR`, so `~/.claude/CLAUDE.md`, agents, skills,
and commands are not loaded. MCP servers are restricted with `--strict-mcp-config`.

## Install

```bash
./install.sh            # links claude-as into ~/.local/bin and builds all profiles
BIN_DIR=~/bin ./install.sh
```

## Layout

```
bin/claude-as            launcher
install.sh               installer
library/                 everything available, shared across profiles
  agents/  skills/  commands/  output-styles/
profiles/<name>/
  manifest               library items this profile loads (one per line)
  settings.json          permissions, env, hooks
  CLAUDE.md              instructions for this profile only
  mcp.json               the only MCP servers loaded (strict)
  flags                  optional extra CLI flags, e.g. --model sonnet
  agents/ skills/ ...    optional items that exist only in this profile
```

At launch, `claude-as` rebuilds `~/.claude-profiles/<name>/` (override with
`CLAUDE_PROFILES_HOME`) as symlinks into this repo, so edits take effect on the next start.
Session history, plugins, and caches stay in that runtime dir, separate per profile.

## Add a profile

```bash
mkdir profiles/review
printf 'agents/reviewer.md\n' > profiles/review/manifest
echo '{}' > profiles/review/settings.json
claude-as review
```

## Commands

| command | does |
|---|---|
| `claude-as <profile> [args]` | sync and launch |
| `claude-as --list` | list profiles |
| `claude-as --sync [name\|--all]` | rebuild runtime dirs without launching |
| `claude-as --path <profile>` | print the runtime config dir |

## Notes

- **Login**: if `~/.claude/.credentials.json` exists (Linux), it is symlinked into each profile.
  On macOS credentials are in the keychain and may need one login per profile.
- **User-scope MCP servers** from `~/.claude.json` are excluded by `--strict-mcp-config`;
  put the ones a profile needs in its `mcp.json`.
- **Repo-level config** (`.claude/`, `CLAUDE.md`, `.mcp.json` in the project) still loads on top.
- Flag and directory behavior can change between Claude Code releases; check `claude --help`.
