[h1]The Creation Forge (Lua) — standalone Lua raw-generation variant[/h1]

Self-contained DF v52+ mod. Drop the whole `creationforge_lua` folder into your DF `mods/` and
enable at world generation (NOT mid-game). Do NOT enable it together with the static
"The Creation Forge" mod — they share object ids (CREATION_FORGE, reactions) and would collide.

How it differs from the static mod
----------------------------------
- Reactions are generated at worldgen by `scripts/creationforge.lua` instead of shipping a
  6,979-line `reaction_custom_*.txt`.
- Every reaction is emitted with [FORTRESS_MODE_ENABLED], so it works for any fortress civ
  without [PERMITTED_REACTION]. The 1 MB / 22,510-line entity permit patch is replaced by a
  ~10-line `objects/entity_patch_creationforge.txt` that only grants the two PERMITTED_BUILDINGs.

Contents
--------
- info.txt
- objects/building_custom_creationforge.txt        (workshops — static)
- objects/material_template_patch_creationforge.txt (dragon scale -> leather — static)
- objects/entity_patch_creationforge.txt            (workshop permits only — static)
- graphics/*                                        (workshop sprites — static)
- scripts/init.lua                                  (entry point)
- scripts/creationforge.lua                         (single file: engine + loops + inlined data)

Port status
-----------
COMPLETE + EXTENDED: 1104 reactions in one file (scripts/creationforge.lua), plus 2 custom item
definitions (ITEM_TOOL_BOWL, ITEM_TOOL_PLATE) registered via raws.register_items.
- 910 = the original static mod, ported 1:1 (239 via loops: wood 84, cloth/thread/leather 18,
  training 137; 671 as an inlined DATA table). Verified vs the static reaction file: 0 semantic
  differences (only deltas: the intended FORTRESS_MODE_ENABLED token, and PRODUCT modifier token
  order which DF treats identically). 3 duplicate-id bugs in the original were also fixed.
- +112 gap-fill: copper / bronze / bismuth bronze full gear (weapons, armor, ammo, shields, sets)
  and silver blunt weapons (mace, warhammer) — all weapon/armor-grade.
- +10 soft-tier fills: leather & dragon-scale socks; dragon-scale hood, helm, leggings.
- +24 drinking vessels: mugs/cups/goblets (ITEM_TOOL_MUG) in 8 metals, 3 glass, feather wood.
- +48 tableware: bowls & plates in 12 materials each (custom ITEM_TOOL_BOWL / ITEM_TOOL_PLATE,
  defined in-script since DF vanilla has neither).
Not added: gloves/gauntlets (custom reactions can't make equippable gloves).

Public domain (same as the original mod).

Old readme below.

[hr][/hr]

[h1]What does it do?[/h1]
The Creation Forge will create out of nothing everything a dwarf could ever desire. Will create food, materials like adamantine or frozen wood, dragon blood, unicorn meat, armor, weapons, clothes, gemstones, glass, food, drink and even magma (cos it's fun).

Inherently DF is fiendishly difficult to learn and even more so to master. Be it your entry card to break into the game or simply your personal creative mode/sandbox to play around, build that cool [url=https://dwarffortresswiki.org/index.php/Mega_construction]mega construction[/url] or check out the [url=https://dwarffortresswiki.org/index.php/Underworld]HFS[/url] this mod will help with it.

By now over 900 reactions grouped into multiple categories. Supports creation of single items, stacks of tens or hundreds at once. Also you can have your dwarves train their skills at a greatly accelerated pace.
The mod now contains prepared code blocks to make it easily compatible with some of the bigger mods out there, ie. Dark Ages V, The Aeramore Expansion and New Genesis (Volume II) (check the file entity_patch_creationforge.txt).

[b]Note:[/b] Adding things like skulls, bones, shell and the like still seems to be not possible as we lack the proper tags to do so. Anybody has other information or figured it out please let me know! Meanwhile create yourself a lobster, a turtle or a crab instead.

[h1]What to keep in mind[/h1]
[b]Important:[/b] Any mod MUST be added to the load list at time of world generation! Cannot be dropped in the middle of a running game / already generated world!

[b]An update [u]requires[/u] a new word to be generated [u]if[/u] you want to make use of the changed/added reactions. Existing worlds will simply not have the new reactions available for use.[/b]
Furthermore the [url=http://www.bay12forums.com/smf/index.php?topic=29157.0]Common Question: When do I need to generate a new world?[/url] is answered on the DF forums.

[h1]List of raws which can be generated[/h1]
See the [url=https://steamcommunity.com/workshop/filedetails/discussion/2898393468/3727323721771887284/]FAQ[/url] cos the list is a bit long by now.

[hr][/hr]

This mod is public domain.

The mod on [url=https://dffd.bay12games.com/file.php?id=16208]DFFD[/url]