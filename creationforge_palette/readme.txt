The Creation Forge - Construction Palette (add-on)
==================================================

Add-on pack for The Creation Forge (Lua version). Requires the base mod; enable BOTH at world
generation, base first (REQUIRES_ID_BEFORE_ME).

Builder QoL: one-click 100-stacks of stone blocks in a 20-color palette, for mosaics and decorative
megaconstructions. All stones are vanilla (verified present) - no custom materials. Reactions go in
the base Blocks submenu.

Palette: marble, chalk, alabaster (white) . obsidian, jet (black) . gabbro, basalt (dark) .
bauxite, hematite, cinnabar, realgar (red/orange) . malachite, olivine (green) . microcline,
cobaltite (blue) . orpiment (yellow) . orthoclase (pink) . granite, diorite, slate (gray).
20 reactions, no custom items.

Add-on pattern
--------------
Pure reactions (no items/materials). [BUILDING:CREATION_FORGE:NONE] + [FORTRESS_MODE_ENABLED], ids
namespaced CFCP_. Reuses the base BLOCKS submenu (no re-declaration). Note: the base mod also makes
some blocks; this pack's namespaced ids never collide, though a stone may appear twice in the menu.

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: base + all 10 packs generate a world with zero Lua and raw errors (empty errorlog).
Still to confirm in actual play: the Blocks submenu lists the palette and produces 100-stacks of the
right colored blocks.

Public domain.
