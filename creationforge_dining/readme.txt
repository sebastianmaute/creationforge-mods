The Creation Forge - Dining Set (add-on)
========================================

Add-on pack for The Creation Forge (the Lua version). Requires the base mod; enable BOTH at world
generation, base first (enforced by REQUIRES_ID_BEFORE_ME).

Adds a dining set under a new "Dining" submenu at the Creation Forge:
- Cutlery (cosmetic): fork, spoon, table knife, chopsticks, ladle - in copper, silver, gold.
- Serving vessels (functional containers): teapot & ewer (liquid), tureen (food+liquid), platter
  (food) - in silver, gold, crystal glass.
Each as a single item or a stack of 10. 9 custom items, 54 reactions.

How it works (add-on pattern, "own submenu" variant)
----------------------------------------------------
- info.txt REQUIRES the base and forces load order (REQUIRES_ID_BEFORE_ME).
- scripts/cf_dining.lua registers 9 custom ITEM_TOOLs and 54 reactions on the base workshop
  [BUILDING:CREATION_FORGE:NONE], each [FORTRESS_MODE_ENABLED] (no entity permit needed).
- Unlike the Sandbox Tools pack (which reused the base TOOLS submenu), this pack declares its OWN
  top-level submenu CFD_DINING (name emitted once on the first reaction).

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: base + all 10 packs generate a world with zero Lua and raw errors (empty errorlog).
Still to confirm in actual play: DF accepts the no-TOOL_USE cutlery and the reactions produce them
(if not, give a benign use or switch to ITEM_TOY); the CFD_DINING submenu shows all 9 item groups.

Public domain.
