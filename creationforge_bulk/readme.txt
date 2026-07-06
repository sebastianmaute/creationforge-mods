The Creation Forge - Bulk Everything (add-on)
=============================================

Add-on pack for The Creation Forge (Lua version). Requires the base mod; enable BOTH at world
generation, base first (REQUIRES_ID_BEFORE_ME).

Quality-of-life pack: one-click 500-stacks of common goods, in the base mod's existing menus:
- Metals: 500 bars of iron / steel / copper / bronze / silver / gold / adamantine; 500 coke.
- Blocks: 500 microcline blocks.   Wood: 500 feather wood logs.
- Cloth/thread/leather: 500 silk cloth, 500 plant thread, 500 cow leather.
- Food/ammo: 500 plump helmets; 500 iron bolts; 500 iron arrows.
16 reactions, no custom items.

Add-on pattern
--------------
Pure reactions (no items/materials). [BUILDING:CREATION_FORGE:NONE] + [FORTRESS_MODE_ENABLED], ids
namespaced CFB_. Reuses base submenus (METAL_BARS, BLOCKS, WOOD, CLOTH, LEATHER, RAW_PLANTS,
AMMUNITION) - no re-declaration.

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: base + all 10 packs generate a world with zero Lua and raw errors (empty errorlog).
Still to confirm in actual play: the reactions appear in the right base submenus and produce 500-stacks.

Public domain.
