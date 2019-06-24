local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

-- Custom starting items
local start_inv = {
	"roukanken","seeds","seeds","seeds","seeds","seeds","seeds","seeds","seeds"
}

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when reviving from ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "youmu_speed_mod", 1)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "youmu_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "youmu.tex" )
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "wendy"
--	inst.AddTag("youmu")
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(200)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(200)
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	-- Movement speed (optional)
	inst.components.locomotor.walkspeed = 5
	inst.components.locomotor.runspeed = 7
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

return MakePlayerCharacter("youmu", prefabs, assets, common_postinit, master_postinit, start_inv)
