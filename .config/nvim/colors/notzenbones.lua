local colors_name = "notzenbones"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"

local bg = vim.o.background

-- Define a palette. Use `palette_extend` to fill unspecified colors
-- Based on https://github.com/gruvbox-community/gruvbox#palette
local palette
if bg == "light" then
	palette = util.palette_extend({
		bg = hsluv "#fbf1c7",
		fg = hsluv "#3c3836",
		rose = hsluv "#9d0006",
		leaf = hsluv "#79740e",
		wood = hsluv "#b57614",
		water = hsluv "#076678",
		blossom = hsluv "#8f3f71",
		sky = hsluv "#427b58",
	}, bg)
else
	palette = util.palette_extend({
		-- bg = hsluv "#1C1917",
		bg = hsluv "#1b1b1b",
		fg = hsluv "#bebebe",
		sand = hsluv "#cfcfcf",
		rose = hsluv "#fb4934",
		leaf = hsluv "#b8bb26",
		wood = hsluv "#fabd2f",
		-- water = hsluv "#83a598",
		water = hsluv "#b8dcfc",
		blossom = hsluv "#d3869b",
		sky = hsluv "#add5a8",
	}, bg)
end

-- Generate the lush specs using the generator util
local generator = require "zenbones.specs"
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
	return {
		Statement { fg = palette.water },
		PreProc { gui = "NONE" },
		-- Repeat { fg = palette.fg, gui = "bold" },
		Special { fg = palette.fg },
		Type { fg = palette.water },
		Constant { fg = palette.sky, gui = "NONE" },
		Number { gui = "NONE" },
		Function { fg = palette.fg , gui = "bold" },
		Identifier { fg = palette.fg , gui = "NONE"},
		Keyword { fg = palette.water , gui = "bold" },
		Operator { fg = palette.fg, gui = "NONE" },
		GitSignsAdd { fg = palette.sky },
		Typedef { fg = palette.water },
		Structure { fg = palette.water },
	}
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
