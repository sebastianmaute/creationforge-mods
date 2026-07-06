The Creation Forge - Trap & Ammo (add-on)
=========================================

Add-on pack for The Creation Forge (Lua version). Requires the base mod; enable BOTH at world
generation, base first (REQUIRES_ID_BEFORE_ME).

Adds custom items, craftable at the Creation Forge in steel and adamantine:
- Trap components (Traps submenu): giant scythe blade, whirling sawblade (10 hits), spiked flail
  head. Install in weapon traps. Single item or stack of 10.
- Ammo (Ammunition submenu): heavy bolts (CLASS BOLT), broadhead arrows (CLASS ARROW) - fired by
  vanilla crossbows / bows. Stacks of 100.
5 custom items, 16 reactions.

Add-on pattern
--------------
Ships only scripts. Reactions use [BUILDING:CREATION_FORGE:NONE] + [FORTRESS_MODE_ENABLED]; items via
raws.register_items. Ids namespaced CFT_. REUSES the base TRAPS and AMMUNITION submenus (no
re-declaration). Stats derived from vanilla (giant axe blade, menacing spike, bolts, arrows).

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: base + this pack generate a world with no Lua errors (all unit tests SUCCEEDED in
lualog.txt) and worldgen completes. The debug_level line has been removed from init.lua.
Still to confirm in actual play: trap components appear in the Traps submenu and install in weapon
traps; ammo appears in Ammunition and is fired by crossbows / bows.

Public domain.
