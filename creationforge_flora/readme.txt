The Creation Forge - Fantasy Flora (add-on)
===========================================

Add-on pack for The Creation Forge (Lua version). Requires the base mod; enable BOTH at world
generation, base first (REQUIRES_ID_BEFORE_ME).

Adds 3 custom subterranean crops DF lacks (own "Fantasy flora" submenu), each edible, brewable, and
- being modeled on the plump helmet - also plantable in underground farm plots:
- goldcap      - brews goldmead   (gold)
- dreamshroom  - brews dreamwine  (violet)
- ember cap    - brews fire brandy (scarlet)
Reactions: make 60 of each plant (into a barrel), make 25 seeds of each (into a bag).
3 custom plants, 6 reactions.

How it works
------------
Each plant is registered via raws.register_plants, cloned from the vanilla plump helmet structure
(STRUCTURAL + PLANT_ALCOHOL drink + SEED materials, subterranean biome, GROWDUR, seeds). Add-on
pattern: base workshop + FORTRESS_MODE_ENABLED, ids namespaced CFF_.

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: loads with zero Lua and raw errors (empty errorlog) - the plant raws registered fine
(no material/token complaints). Still to confirm in actual play: the Fantasy flora submenu lists the
crops; plants + seeds are produced; the crops are plantable and brew into their drinks.

Public domain.
