The Creation Forge - Sandbox Tools (add-on)
===========================================

Add-on pack for The Creation Forge (the Lua version). Requires the base mod; enable BOTH at world
generation, base first (enforced by REQUIRES_ID_BEFORE_ME).

Adds two oversized custom storage tools, craftable at the Creation Forge (Tools submenu):
- grand vault   - huge food/item container (steel, adamantine)
- great cistern - huge liquid container   (steel, adamantine)

How it works (the add-on pattern)
---------------------------------
- info.txt declares [REQUIRES_ID:creationforge] + [REQUIRES_ID_BEFORE_ME:creationforge], so it only
  loads when the base is present and after it.
- scripts/cf_sandbox.lua registers 2 custom ITEM_TOOLs (raws.register_items) and 4 reactions
  (raws.register_reactions) that use the BASE workshop [BUILDING:CREATION_FORGE:NONE] and drop into
  the base [CATEGORY:TOOLS] submenu. Each reaction has [FORTRESS_MODE_ENABLED], so no entity permit
  is needed.
- No building, graphics, or entity files - the base provides those.

Testing - validated in-game (2026-06)
-------------------------------------
Confirmed on Steam DF: base + this pack generate a world with no Lua errors; the Creation Forge
Tools submenu lists the vault/cistern reactions and the crafted items work. The add-on mechanism
holds - [CATEGORY:TOOLS] groups correctly under the base's Tools menu with NO re-declaration of the
category name/parent needed, and REQUIRES_ID_BEFORE_ME load order works.
To re-test after changes: set debug_level > 0 in scripts/init.lua, generate a new world, read
Dwarf Fortress/lualog.txt. Strip the debug line before publishing.

Public domain.
