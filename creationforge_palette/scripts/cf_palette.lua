-- cf_palette.lua — Creation Forge add-on: Construction Palette.
--
-- Quality-of-life pack for builders: 100-stacks of stone blocks in a wide colored palette, for
-- decorative megaconstructions and mosaics. Pure reactions, no custom items. All stones are vanilla
-- (verified present), so no new materials. Reuses the base BLOCKS submenu.
--
-- Add-on pattern: base building CREATION_FORGE, [FORTRESS_MODE_ENABLED], ids namespaced CFCP_.
-- Requires the base mod.

do_once.cf_palette = function()
	local out = {}
	local function blocks(stone, disp)
		out[#out+1] = "[REACTION:CFCP_BLOCK_" .. stone .. "]"
		add_generated_info(out)
		out[#out+1] = "[NAME:make 100 " .. disp .. " blocks]"
		out[#out+1] = "[BUILDING:CREATION_FORGE:NONE]"
		out[#out+1] = "[FORTRESS_MODE_ENABLED]"
		out[#out+1] = "[PRODUCT:100:100:BLOCKS:NONE:INORGANIC:" .. stone .. "]"
		out[#out+1] = "[SKILL:MASONRY]"
		out[#out+1] = "[CATEGORY:BLOCKS]"
	end
	-- { stone_id, display } — a colored palette (all vanilla stones)
	local STONES = {
		{ "MARBLE", "marble" }, { "CHALK", "chalk" }, { "ALABASTER", "alabaster" },
		{ "OBSIDIAN", "obsidian" }, { "JET", "jet" }, { "GABBRO", "gabbro" }, { "BASALT", "basalt" },
		{ "BAUXITE", "bauxite" }, { "HEMATITE", "hematite" }, { "CINNABAR", "cinnabar" },
		{ "REALGAR", "realgar" }, { "MALACHITE", "malachite" }, { "OLIVINE", "olivine" },
		{ "MICROCLINE", "microcline" }, { "COBALTITE", "cobaltite" }, { "ORPIMENT", "orpiment" },
		{ "ORTHOCLASE", "orthoclase" }, { "GRANITE", "granite" }, { "DIORITE", "diorite" },
		{ "SLATE", "slate" },
	}
	for _, s in ipairs(STONES) do blocks(s[1], s[2]) end
	raws.register_reactions(out)
end
