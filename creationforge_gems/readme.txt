The Creation Forge - Fantasy Gems (add-on)
==========================================

Add-on pack for The Creation Forge (Lua version). Requires the base mod; enable BOTH at world
generation, base first (REQUIRES_ID_BEFORE_ME).

Adds 6 custom gemstones DF lacks, as high-value forge-only exclusives (NO ENVIRONMENT_SPEC, so they
never spawn in worldgen). Make rough or cut gems (base Rough/Cut gemstone menus), x10 and x100:
  starstone, soulgem, dragon-eye, void crystal, phoenix tear, frostgem.
6 custom materials, 24 reactions. Use them to encrust furniture/items or as valuable trade goods.

How it works
------------
Each gem is a custom INORGANIC on STONE_TEMPLATE with [IS_GEM] + color/value (token set derived from
vanilla ruby/emerald), and deliberately no environment so it is craft-only. register_inorganics for
the gems, register_reactions for rough (item ROUGH) and cut (item SMALLGEM) with skill CUTGEM.
Add-on pattern: base workshop + FORTRESS_MODE_ENABLED, ids namespaced CFG_, reuses base RGEMS/CGEMS.

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: loads with zero Lua and raw errors (empty errorlog) - all 6 gem materials registered
(frostgem color fixed CYAN -> AZURE). Still to confirm in actual play: the Rough/Cut gemstone menus
list the new gems, and crafted gems have the right colors and can encrust.

Public domain.
