local assets =
{
	Asset( "ANIM", "anim/youmu.zip" ),
	Asset( "ANIM", "anim/ghost_youmu_build.zip" ),
}

local skins =
{
	normal_skin = "youmu",
	ghost_skin = "ghost_youmu_build",
}

return CreatePrefabSkin("youmu_none",
{
	base_prefab = "youmu",
	type = "base",
	assets = assets,
	skins = skins,
	skin_tags = {"YOUMU", "CHARACTER", "BASE"},
	build_name = "youmu",
	rarity = "Common",
	-- skip_item_gen = true,
	-- skip_giftable_gen = true,
})