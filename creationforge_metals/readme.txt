The Creation Forge - Fantasy Metals (add-on)
============================================

Add-on pack for The Creation Forge (Lua version). Requires the base mod; enable BOTH at world
generation, base first (REQUIRES_ID_BEFORE_ME).

Adds 5 custom weapon/armor-grade metals DF lacks:
- mithril       - light (density ~1500) but adamantine-strong, keen edge. High value.
- orichalcum    - golden, steel-tier, high value.
- dragonsteel   - red, steel-tier with a high melting point.
- meteoric iron - steel-tier, dark.
- cold iron     - iron-tier flavor metal.
Reactions:
- Bars (base Metals submenu): make a bar / 10 bars of each metal.
- Mythic gear (own submenu): short sword, battle axe, breastplate, helm, shield in each metal.
5 custom materials, 35 reactions. Pairs with the Weapons & Armor pack (those exotic weapons can be
forged in these metals too, if you extend that pack's material list).

How it works
------------
Each metal is a custom INORGANIC on METAL_TEMPLATE with vanilla-derived mechanical properties
(strength blocks copied from steel/adamantine; density/edge/value/color tuned). register_inorganics
for the metals, register_reactions for bars + gear. Gear uses vanilla item subtypes with the custom
material. Add-on pattern: base workshop + FORTRESS_MODE_ENABLED, ids namespaced CFMET_.

Testing - loads clean in-game (2026-06)
---------------------------------------
Validated: loads with zero Lua and raw errors (empty errorlog) - all 5 inorganics registered.
Still to confirm in actual play: crafted bars/gear have the right names/colors and sane combat
stats. Tune material properties to taste.

Public domain.
