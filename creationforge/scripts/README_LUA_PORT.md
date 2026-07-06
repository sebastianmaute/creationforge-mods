# Creation Forge — Lua raw-gen port

Converts the mod's hand-written reaction raws to DF v52 Lua generation.

## Why

| File | Static mod | After Lua port |
|---|---|---|
| Reactions | `objects/reaction_custom_creationforge.txt` — 6,979 lines / 910 reactions | `scripts/creationforge.lua` — compact data tables + loops |
| Entity permits | `objects/entity_patch_creationforge.txt` — **1 MB / 22,510** `PERMITTED_REACTION` + commented per-mod compat blocks | `objects/entity_patch_creationforge_SLIM.txt` — **~10 lines** (2 `PERMITTED_BUILDING` only) |

The key lever is the reaction token **`[FORTRESS_MODE_ENABLED]`**: a reaction with it is usable by
any fortress civ **without** `[PERMITTED_REACTION]`. The generator stamps it on every reaction, so:

- the entire reaction-permit half of the entity patch disappears;
- the per-mod uncommenting chore (Aeramore, Dark Ages V, New Genesis) disappears — reactions work
  for **every** civ/mod automatically;
- adding an item = one data-table row, not edits across two files kept in lockstep.

## Stays static (buildings can't be Lua-generated)

`building_custom_creationforge.txt`, `graphics/*`, `material_template_patch_creationforge.txt`,
and the slim entity patch (workshop `PERMITTED_BUILDING`).

## Status — COMPLETE + EXTENDED (1104 reactions + 2 custom items, single file)

Everything lives in one file: `scripts/creationforge.lua` (engine + loops + an inlined `DATA`
table). No `require`, no separate data files.

- **910** = the original static mod, ported 1:1. 239 via loops (Wood 84, Cloth/Thread/Leather 18,
  Training 137); 671 as inlined `DATA` records. Verified vs `reaction_custom_creationforge.txt`:
  **0 semantic differences** (id, name, building, skill, reagents, products, category). Only token
  deltas: the added `[FORTRESS_MODE_ENABLED]`, and `PRODUCT` modifier token order (DF treats it
  identically). 3 duplicate-id bugs in the original were fixed (flask, adamantine blocks, leather set).
- **+112 gap-fill**: copper / bronze / bismuth bronze full gear (weapons, armor, ammo, shields,
  sets) + silver blunt weapons (mace, warhammer) — all weapon/armor-grade. New submenus in `CATS`.
- **+10 soft-tier**: leather & dragon-scale socks; dragon-scale hood, helm, leggings.
- **+24 drinking vessels**: mugs / cups / goblets (`ITEM_TOOL_MUG`) — 8 metals, 3 glass, feather wood.
- **+48 tableware**: bowls & plates, 12 materials each. DF has neither, so `ITEM_TOOL_BOWL` /
  `ITEM_TOOL_PLATE` are defined in-script and registered via `raws.register_items` (items are in
  Lua-gen scope; buildings are not).
- **Not added**: gloves/gauntlets (custom reactions can't make equippable gloves — original bug);
  18 non-grade metals (lead, tin, gold, …) left bar-only.

To add an item: append a record to the `DATA` table (or a loop). The `emit{}` helper supports
multi-product, ordered `prods[].mods` (`PRODUCT_DIMENSION`/`PRODUCT_TO_CONTAINER`/`PRODUCT_PRESSED`),
and empty-container `REAGENT`s (e.g.
`reagents = { "A:1:BARREL:NONE:NONE:NONE|EMPTY|PRESERVE_REAGENT|DOES_NOT_DETERMINE_PRODUCT_AMOUNT" }`).

## How to cut over (only when the port is 100% complete)

Do **not** load the Lua script and the static reaction file at the same time — duplicate
`[REACTION]` ids error at worldgen. When every category is ported:

1. delete `objects/reaction_custom_creationforge.txt`;
2. delete `objects/entity_patch_creationforge.txt`, rename `_SLIM` → that name;
3. keep `scripts/init.lua` + `scripts/creationforge.lua`.

## Testing — validated in-game (2026-06)

Confirmed on Steam DF: the mod generates a world with no Lua errors (all unit tests `SUCCEEDED` in
`lualog.txt`), and `FORTRESS_MODE_ENABLED` exposes every reaction in the Creation Forge / Training
Forge menus **without** reaction permits. Custom items (bowls, plates, etc.) are craftable.

To re-test after changes: set `debug_level > 0` in `scripts/init.lua`, generate a new world, read
`Dwarf Fortress/lualog.txt` (Steam: `…\steamapps\common\Dwarf Fortress\lualog.txt`). Strip the
debug line before publishing.
