The Creation Forge - Toys & Trinkets (add-on)
=============================================

Add-on pack for The Creation Forge (Lua version). Requires the base mod; enable BOTH at world
generation, base first (REQUIRES_ID_BEFORE_ME).

Adds custom toys DF vanilla lacks, craftable at the Creation Forge under a new "Toys" submenu, in
feather wood, copper and silver (single item or stack of 10):
  spinning top, kaleidoscope, doll, rocking horse, marbles, yo-yo, toy soldier, toy sword.
8 custom items, 48 reactions. Toys make dwarven children happy and are valuable trade/masterwork
goods.

Add-on pattern
--------------
Ships only scripts. Reactions use [BUILDING:CREATION_FORGE:NONE] + [FORTRESS_MODE_ENABLED]; items via
raws.register_items. Ids namespaced CFY_. Declares its own "Toys" submenu. Toy raw is just
NAME + HARD_MAT (any hard material: wood, metal, stone, bone, shell, glass - not cloth/leather).

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: base + all 10 packs generate a world with zero Lua and raw errors (empty errorlog).
Still to confirm in actual play: the Toys submenu lists the reactions and toys are craftable.

Public domain.
