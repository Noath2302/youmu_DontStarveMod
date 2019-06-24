--require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/dumpling.zip"),
	
	Asset("ATLAS", "images/inventoryimages/dumpling.xml"),
    Asset("IMAGE", "images/inventoryimages/dumpling.tex"),
	
}

local function fn()

	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()        
    --inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	
	--MakeObstaclePhysics(inst, 0.1)
	
	inst:AddTag("dumpling")
	
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "cave_fern"
	
    inst.AnimState:SetBank("dumpling")
    inst.AnimState:SetBuild("dumpling")
    inst.AnimState:PlayAnimation("idle")

    inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "dumpling"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dumpling.xml"
--	inst.components.inventoryitem:SetOnDroppedFn(function()  end)
	
	inst:AddComponent("edible")
    inst.components.edible.foodtype = "MEAT"
    inst.components.edible.healthvalue = TUNING.HEALING_SMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_MED
    inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL

    return inst
end

return Prefab("common/dumpling", fn, assets)