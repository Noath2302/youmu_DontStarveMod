PrefabFiles = {
	"youmu",
	"youmu_none",
	"roukanken",
	"dumpling",
	"phantomfire",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/youmu.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/youmu.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/youmu.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/youmu.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/youmu_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/youmu_silho.xml" ),

    Asset( "IMAGE", "bigportraits/youmu.tex" ),
    Asset( "ATLAS", "bigportraits/youmu.xml" ),
	
	Asset( "IMAGE", "images/map_icons/youmu.tex" ),
	Asset( "ATLAS", "images/map_icons/youmu.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_youmu.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_youmu.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_youmu.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_youmu.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_youmu.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_youmu.xml" ),
	
    Asset( "IMAGE", "images/names_youmu.tex" ),
    Asset( "ATLAS", "images/names_youmu.xml" ),
	
	Asset( "IMAGE", "images/names_gold_youmu.tex" ),
    Asset( "ATLAS", "images/names_gold_youmu.xml" ),
	
    Asset( "IMAGE", "bigportraits/youmu_none.tex" ),
    Asset( "ATLAS", "bigportraits/youmu_none.xml" ),
	
	-- Roukanken
	Asset("IMAGE", "images/map_icons/roukanken.tex"),
	Asset("ATLAS", "images/map_icons/roukanken.xml"),

}

AddMinimapAtlas("images/map_icons/youmu.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.youmu = "The Ghostly Gardener"
STRINGS.CHARACTER_NAMES.youmu = "Youmu"
STRINGS.CHARACTER_DESCRIPTIONS.youmu = "*Is half-ghost half-human \n*Roukanken\n*can cook yummy dumplings\n*Hakurouken"
STRINGS.CHARACTER_QUOTES.youmu = "\"Sorry, but I'm afraid that I'm already half-dead.\""


-- Custom speech strings
STRINGS.CHARACTERS.YOUMU = require "speech_youmu"

-- The character's name as appears in-game 
STRINGS.NAMES.YOUMU = "youmu"
-- Roukanken
STRINGS.NAMES.ROUKANKEN = "Roukanken"
STRINGS.CHARACTERS.YOUMU.DESCRIBE.ROUKANKEN = "The things that cannot be cut are next to none!"
-- Dumpling
STRINGS.NAMES.DUMPLING = "Dumpling"
STRINGS.RECIPE_DESC.DUMPLING = "a good way to lighten up your day"
STRINGS.CHARACTERS.YOUMU.DESCRIBE.DUMPLING = "Eating is a necessity but cooking is an art"

-- PREFABS 'FUNCTION
--===============================================================================================================================
GLOBAL.mod_protect_Recipe = false
local dumplingrecipe = GLOBAL.Recipe("dumpling", {Ingredient("cutgrass", 2),Ingredient("petals", 2),Ingredient("seeds", 2),}, GLOBAL.RECIPETABS.SURVIVAL, GLOBAL.TECH.NONE)
GLOBAL.mod_protect_Recipe = true
dumplingrecipe.atlas = "images/inventoryimages/dumpling.xml"

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("youmu", "FEMALE")


