local assets=
{ 
    Asset("ANIM", "anim/roukanken.zip"),
    Asset("ANIM", "anim/swap_roukanken.zip"), 

    Asset("ATLAS", "images/inventoryimages/roukanken.xml"),
    Asset("IMAGE", "images/inventoryimages/roukanken.tex"),
}
local function spawning(target)
	local x, y, z = target.Transform:GetWorldPosition()
	local flowering = SpawnPrefab("phantomfire")
	flowering.Transform:SetPosition(x,y,z)
	flowering.components.disappears:PrepareDisappear()
end

local prefabs = 
{
}
local mode_bef
local function flicker_stop(inst)
    if inst.flickertask then
		inst.flickertask:Cancel()
		inst.flickertask = nil
	end
end
local function flicker_update(inst,mode)
    local time = GetTime()%3.14
	local flicker = ( math.sin( time )) -- range = [0 , 1]
	if mode_bef~=nil then
		if mode ~= mode_bef then
		
			if mode == "dusk" then
				inst.Light:SetRadius( 1.5 + 0.5 * flicker)
			elseif mode == "night" then
				inst.Light:SetRadius( 5 + 0 * flicker)
			end
			
		end
	end
	mode_bef = mode
    inst.flickertask = inst:DoTaskInTime(0.1, function() flicker_update(inst,mode) end)
end
local function onattack(weapon,attacker,target)
	if target~=nil and target.components.health:IsDead() then
		spawning(target)
	end
end
local function updatelight(inst)

	if ( not inst.components.equippable:IsEquipped() or TheWorld.state.isday) then 
	inst.Light:Enable(false)
    inst.AnimState:PlayAnimation("idle",true)
    inst.lighton = false
	flicker_stop(inst)
	
	elseif TheWorld.state.isdusk then
    inst.Light:Enable(true)
	flicker_update(inst,"dusk")
    inst.Light:SetFalloff(0.5)
    inst.Light:SetIntensity(.8)
    inst.Light:SetColour(100/255,100/255,100/255)
	inst.AnimState:PushAnimation("idle",true)
    inst.lighton = true
	
	elseif TheWorld.state.isnight then
	inst.Light:Enable(true)
	flicker_update(inst,"night")
    inst.Light:SetFalloff(0.5)
    inst.Light:SetIntensity(.8)
    inst.Light:SetColour(100/255,255/255,100/255)
	inst.AnimState:PushAnimation("idle",true)
    
	
	end
    end
-- On Wearout or out of power still working on it	
local function onfinished(inst)
    inst:Remove()
	end
-------------------------------------------------
local function OnEquip(inst, owner) 
        --owner.AnimState:OverrideSymbol("swap_object", "swap_roukankens", "purplestaff")
        owner.AnimState:OverrideSymbol("swap_object", "swap_roukanken", "roukanken")
        owner.AnimState:Show("ARM_carry") 
        owner.AnimState:Hide("ARM_normal") 
    end
local function OnUnequip(inst, owner) 
        owner.AnimState:Hide("ARM_carry") 
        owner.AnimState:Show("ARM_normal") 
    end
local function onfinished(inst)
    inst:Remove()
end
local function fn(Sim)
	
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
	local light = inst.entity:AddLight()
    MakeInventoryPhysics(inst)
	
	
	inst:AddTag("irreplaceable")
    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "roukanken.tex")
	
    anim:SetBank("roukanken")
    anim:SetBuild("roukanken")
    anim:PlayAnimation("idle")
	
--	inst:AddComponent("characterspecific")
--  inst.components.characterspecific:SetOwner("youmu")
	
	inst:AddTag("roukanken")
	inst:AddTag("sharp")
	
	inst:AddComponent("weapon")
	inst:AddComponent("combat")
	inst.components.weapon:SetDamage(TUNING.AXE_DAMAGE*5)
	inst.components.weapon:SetOnAttack(onattack)
	--Roukanken as axe ::
	-----
    --inst:AddComponent("tool")
    --inst.components.tool:SetAction(ACTIONS.CHOP,5)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "roukanken"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/roukanken.xml"
    
	inst:AddComponent("inspectable")
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )

    --inst.components.inventoryitem:SetOnDroppedFn(function() inst.lighton = true anim:PlayAnimation("idle",true) end)
    --inst.components.inventoryitem:SetOnPickupFn(function() inst.Light:Enable(false) end)
	--inst:DoPeriodicTask(2, function() updatelight(inst) end)
	
    return inst
end

return  Prefab("common/inventory/roukanken", fn, assets, prefabs)