# INSTALL — Installing & testing the Creation Forge mods

Getting the mods from this repo into Dwarf Fortress, enabling them, verifying they loaded
clean, and recovering when something breaks.

## Prerequisites

- Dwarf Fortress **v52.01+** (Lua raw generation shipped in v52.01; added experimentally v51.06).
- Write access to DF's mod folder (paths below).

## 1. Install (manual, for local testing)

DF loads loose mods from its **`mods/`** directory. Copy each mod folder there:

| Platform | Mods directory |
|---|---|
| Steam | `…\steamapps\common\Dwarf Fortress\mods\` |
| Itch / classic | `<DF install>\mods\` |
| User mods (all) | `%APPDATA%\Bay 12 Games\Dwarf Fortress\mods\` |

Copy the folders you want — e.g. `creationforge\` (base) plus any `creationforge_*` pack.
Each folder must keep its `info.txt` at the top level (DF reads `info.txt` to list the mod).

> Published alternative: subscribe on the Steam Workshop (base item `2898393468`,
> collection `3758458696`). Workshop and manual copies of the same `[ID]` conflict — use one.

## 2. Load order & dependencies

Order is enforced by `info.txt` tokens — respect them or the mod won't apply:

- **Base** `creationforge` requires `vanilla_entities` / `vanilla_reactions` /
  `vanilla_buildings` before it (declares the `CREATION_FORGE` / `TRAINING_FORGE` buildings).
- **Every pack** declares `[REQUIRES_ID:creationforge]` + `[REQUIRES_ID_BEFORE_ME:creationforge]`,
  so it loads *after* the base and reuses the base building ids.

In the mod-selection screen, add **base first, then packs**. A pack alone (no base) has no
building to attach its reactions to.

## 3. Enable in a world

Mods are chosen **per world at worldgen** — they are baked in at generation:

1. Start DF → **Create New World** (or **Adventure/Fortress → new**).
2. On the mod screen, enable `The Creation Forge` + any packs (base above packs).
3. Generate the world. Enabling/disabling a mod requires a **new world** — existing saves
   keep the mod set they were made with.

In fortress mode, build the **Creation Forge** / **Training Forge** workshops; pack reactions
appear under the shared submenus (`TOOLS`, `BLOCKS`, `WEAPON`, …). Reactions are stamped
`[FORTRESS_MODE_ENABLED]`, so no entity permit is needed.

## 4. Verify it loaded clean

| Check | Where | Clean state |
|---|---|---|
| Raw-token errors (bad material/reaction/item) | `errorlog.txt` in DF root | empty file |
| Lua errors + generation log | `lualog.txt` (`%APPDATA%\…\Dwarf Fortress\` on Steam) | no `error`/`traceback` |
| Reactions present | in-game workshop menu | expected reactions listed |

`raws.register_*` is **silent** — Lua-generated raw errors surface **only** in `errorlog.txt`.
Set global `debug_level > 0` to run the script unit tests; `>= 0.5` logs each generation step
to `lualog.txt`.

## 5. Troubleshooting

**Mod not updating, or stopped working after an update** — DF caches an installed copy.
Close DF, then delete whichever of these exist and re-subscribe / re-copy:

```
%APPDATA%\Bay 12 Games\Dwarf Fortress\data\installed_mods\creationforge (xxxx)
%APPDATA%\Bay 12 Games\Dwarf Fortress\mods\creationforge (xxxx)
```

(`xxxx` = version suffix; delete the matching pack folders too.)

**Reactions missing from the workshop** — base not enabled, or pack loaded before base.
Regenerate the world with base above the pack.

**`errorlog.txt` has token errors** — a raw is malformed. Fix the script, regenerate the
world (raws are emitted at worldgen). Empty `errorlog.txt` = clean.

**Nothing generated / Lua traceback in `lualog.txt`** — script error. Confirm the mod's
`scripts/init.lua` `require()`s each script; inspect available data with
`print_table(world)` / `print_table(random_object_parameters)`.

## 6. Rollback

- **Remove a pack:** disable it on the mod screen and generate a new world (or delete its
  folder from `mods/`). Base + other packs are unaffected — packs are additive and namespaced.
- **Revert to a prior version:** unsubscribe/delete the installed copy (§5) and reinstall the
  older folder. Existing worlds are unchanged; only new worlds pick up the swap.
