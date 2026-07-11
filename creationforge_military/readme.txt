The Creation Forge - Weapons & Armor (add-on)
=============================================

Add-on pack for The Creation Forge (Lua version). Requires the base mod; enable BOTH at world
generation, base first (REQUIRES_ID_BEFORE_ME).

Adds custom item types DF vanilla lacks, craftable at the Creation Forge in steel and adamantine
(single item or stack of 10), under two new submenus:
- Exotic weapons: longsword, greatsword, katana, rapier, halberd, glaive, war scythe, flail.
- Exotic armor:   full plate, brigandine, gambeson, sallet, great helm, tower shield.
14 custom items, 54 reactions. (Metal gear in steel/adamantine; the gambeson, being padded
soft armor, is made in leather instead.)

Design notes
------------
- Weapons map to existing skills (SWORD / AXE / MACE) so dwarves can train and use them.
- Stats (SIZE, ATTACK, MATERIAL_SIZE, coverage/layer) are derived from the vanilla item raws
  (short sword, two-handed sword, battle axe, pike, mace; breastplate, mail shirt, helm, shield)
  and are sane approximations - tune to taste.
- No gloves/gauntlets: custom reactions cannot make equippable hand armor (vanilla limitation).

Add-on pattern
--------------
Ships scripts plus an item-graphics pack. Reactions use [BUILDING:CREATION_FORGE:NONE] +
[FORTRESS_MODE_ENABLED]; items registered via raws.register_items. Ids namespaced CFM_. Declares its
own submenus (Exotic weapons / Exotic armor) rather than reusing the base WEAPONS/ARMOR menus.

Item graphics (v1.1): custom item subtypes need WEAPON_GRAPHICS / ARMOR_GRAPHICS / HELM_GRAPHICS /
SHIELD_GRAPHICS entries or DF renders them with no sprite - that is exactly what looked like a "graphic
bug" when forging at the Creation Forge (the vanilla forge produces vanilla subtypes, which already have
sprites). graphics/ ships a 4x4 tile page (images/cfm_items.png, 32x32, greyscale so DF tints by material
- adamantine reads pale, steel grey) and graphics_creationforge_military.txt maps every CFM_ subtype to a
tile. Item graphics can't be Lua-generated (like buildings), so they ship as static raws.

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: base + this pack generate a world with no Lua errors (all unit tests SUCCEEDED in
lualog.txt) and worldgen completes. The debug_level line has been removed from init.lua.
Still to confirm in actual play: the Exotic weapons / Exotic armor submenus list the reactions;
crafted weapons are equippable and usable in the military; armor is wearable; big weapons
(greatsword, halberd) are wieldable by dwarves (else lower MINIMUM_SIZE).

Public domain.
