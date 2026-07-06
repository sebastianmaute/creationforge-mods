The Creation Forge - Potions & Elixirs (add-on) [EXPERIMENTAL]
=============================================================

Add-on pack for The Creation Forge (Lua version). Requires the base mod; enable BOTH at world
generation, base first (REQUIRES_ID_BEFORE_ME).

Adds magical potions, brewed at the Creation Forge (Potions submenu). Each is a custom drinkable
alcohol carrying an ingested syndrome - a dwarf who drinks it is buffed for a while (~half a season):
- potion of might        - big physical attribute boost (strength/toughness/agility)
- draught of stoneskin   - halves incoming damage (force multiplier)
- elixir of vigor        - no exhaustion / pain / nausea / fear / stun
- elixir of genius       - mental attribute boost (analysis / focus / creativity)
4 custom materials, 4 reactions.

How it works
------------
Each potion is a custom INORGANIC material on PLANT_ALCOHOL_TEMPLATE (drinkable booze) with a
[SYNDROME][SYN_INGESTED] and timed CE_* effects (CE_PHYS_ATT_CHANGE / CE_MENT_ATT_CHANGE /
CE_ADD_TAG). Syntax derived from vanilla (interaction_vampire, gnomeblight). The reaction brews a
barrel of the potion. Add-on pattern: base workshop + FORTRESS_MODE_ENABLED, ids namespaced CFP_.

EXPERIMENTAL - unverified in-game, likely needs iteration
---------------------------------------------------------
Two things are NOT confirmed and must be tested:
1. Whether DF accepts a DRINK item made from an INORGANIC material (the PRODUCT line). If not, the
   fallback is to base the potion on a custom PLANT with a brew, or deliver via a different item.
2. Whether/how dwarves drink it. Booze is generic drink, so the whole fort may drink potions at
   random and get buffed (intended chaotic-cheat flavor) - there is no on-demand "drink this potion"
   command in vanilla.
Also tune effect strength/duration to taste (percent values, START/PEAK/END ticks).

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: loads with zero Lua and raw errors (empty errorlog) - the custom alcohols and their
ingested syndromes registered, and the DRINK-from-inorganic product raised no raw complaint.
Still to confirm in actual play: a brewed barrel exists and is drinkable, dwarves drink it, and the
buffs apply. Tune effect strength/duration to taste.

Public domain.
