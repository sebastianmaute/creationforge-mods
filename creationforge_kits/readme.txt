The Creation Forge - Starter Kits (add-on)
==========================================

Add-on pack for The Creation Forge (Lua version). Requires the base mod; enable BOTH at world
generation, base first (REQUIRES_ID_BEFORE_ME).

One-click bundle reactions (own "Starter kits" submenu) - each conjures a whole kit of vanilla items
in a single job:
- basic starter kit   - 2 iron picks, iron axe, iron anvil, 50 plump helmets, 25 seeds, 20 logs,
                        20 copper bars, 10 cow leather, 10 silk cloth.
- military kit (steel)- 5x breastplate/helm/boots/leggings/shield, 5x short sword/axe/crossbow,
                        100 bolts.
- craft kit           - 10 copper/silver/gold bars, 20 rough rock crystals, 10 logs, 20 microcline
                        blocks, 20 silk cloth, 20 plant thread.
3 reactions, no custom items.

Add-on pattern
--------------
Pure multi-product reactions (no items/materials). [BUILDING:CREATION_FORGE:NONE] +
[FORTRESS_MODE_ENABLED], ids namespaced CFK_, own submenu.

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: base + this pack generate a world with zero Lua and raw errors (empty errorlog).
Still to confirm in actual play: the Starter kits submenu lists the 3 kits and each yields the full
bundle of items.

Public domain.
