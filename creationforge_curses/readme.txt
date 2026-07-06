The Creation Forge - Curses & Poisons (add-on) [EXPERIMENTAL]
============================================================

Add-on pack for The Creation Forge (Lua version). Requires the base mod; enable BOTH at world
generation, base first (REQUIRES_ID_BEFORE_ME).

Adds craftable poisons (own "Poisons" submenu), via custom syndrome-bearing materials:
- rotgut               - ingested: nausea + fever
- sleeping draught     - ingested: drowsiness + unconsciousness
- draught of paralysis - ingested: paralysis
- contact venom        - a powder contaminant: pain + swelling + blisters (SYN_CONTACT)
4 custom materials, 4 reactions.

Delivery (read this)
--------------------
Vanilla fortress mode has NO way to coat weapons or apply passive item-curses, so:
- The 3 brews are booze - whoever DRINKS them is afflicted. Dwarves drink booze at will, so a
  poison barrel can take out a target (or backfire on the fort). Use deliberately.
- The contact venom is a POWDER contaminant - a creature that touches it is afflicted. Placing it
  where enemies path is up to you; there's no auto-delivery.
CE effect syntax is derived from vanilla venoms.

How it works
------------
Brews: custom INORGANIC on PLANT_ALCOHOL_TEMPLATE + [SYNDROME][SYN_INGESTED]. Venom: custom
INORGANIC on STONE_TEMPLATE (a powder) + [SYNDROME][SYN_CONTACT]. register_inorganics +
register_reactions. Add-on pattern: base workshop + FORTRESS_MODE_ENABLED, ids namespaced CFX_.

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: loads with zero Lua and raw errors (empty errorlog) - the CE effect tokens and the
DRINK/POWDER_MISC products registered fine. Still to confirm in actual play: the Poisons submenu
lists the reactions; brews are drinkable and afflict the drinker; the venom powder is made. Tune
severity to taste.

Public domain.
