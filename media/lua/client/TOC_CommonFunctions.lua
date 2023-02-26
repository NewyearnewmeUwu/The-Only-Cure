------------------------------------------
------------- JUST CUT IT OFF ------------
------------------------------------------
------------ COMMON FUNCTIONS ------------



if JCIO_Common == nil then
    JCIO_Common = {}
end


JCIO_Common.partNames = {}

JCIO_Common.GeneratePartNames = function()

    local partNamesTable = {}
    for _, side in ipairs(JCIO.sideNames) do
        for _, limb in ipairs(JCIO.limbNames) do
            local tempPartName = side .. "_" .. limb
            table.insert(partNamesTable, tempPartName)
        end
    end

    JCIO_Common.partNames = partNamesTable

end



JCIO_Common.GetPartNames = function()
    if JCIO_Common.partNames.size() == nil then
        JCIO_Common.GeneratePartNames()
    end

    return JCIO_Common.partNames
end

JCIO_Common.GetAcceptableBodyPartTypes = function()

    -- TODO Add Foot_L and Foot_R
    return {
        BodyPartType.Hand_R, BodyPartType.ForeArm_R, BodyPartType.UpperArm_R,
        BodyPartType.Hand_L, BodyPartType.ForeArm_L, BodyPartType.UpperArm_L
    }

end

JCIO_Common.GetOtherBodyPartTypes = function()

    return {
        BodyPartType.Torso_Upper, BodyPartType.Torso_Lower, BodyPartType.Head,
        BodyPartType.Neck, BodyPartType.Groin, BodyPartType.UpperLeg_L,
        BodyPartType.UpperLeg_R, BodyPartType.LowerLeg_L,
        BodyPartType.LowerLeg_R, BodyPartType.Foot_L, BodyPartType.Foot_R,
        BodyPartType.Back
    }

end


function GetProsthesisList()
    -- TODO Not gonna work anymore
    return {"WoodenHook", "MetalHook", "MetalHand"}

end

function JCIO_Common.FindAmputatedClothingName(partName)
    return "TOC.Amputation_" .. partName
end

function JCIO_Common.GetPartNameFromBodyPartType(bodyPartType)

    if bodyPartType == BodyPartType.Hand_R then
        return "Right_Hand"
    elseif bodyPartType == BodyPartType.ForeArm_R then
        return "Right_LowerArm"
    elseif bodyPartType == BodyPartType.UpperArm_R then
        return "Right_UpperArm"
    elseif bodyPartType == BodyPartType.Hand_L then
        return "Left_Hand"
    elseif bodyPartType == BodyPartType.ForeArm_L then
        return "Left_LowerArm"
    elseif bodyPartType == BodyPartType.UpperArm_L then
        return "Left_UpperArm"
    else
        return nil
    end

end


-- 1:1 map of part_name to BodyPartType
function JCIO_Common.GetBodyPartFromPartName(partName)
    if partName == "Right_Hand" then return BodyPartType.Hand_R end
    if partName == "Right_LowerArm" then return BodyPartType.ForeArm_R end
    if partName == "Right_UpperArm" then return BodyPartType.UpperArm_R end
    if partName == "Left_Hand" then return BodyPartType.Hand_L end
    if partName == "Left_LowerArm" then return BodyPartType.ForeArm_L end
    if partName == "Left_UpperArm" then return BodyPartType.UpperArm_L end

    -- New Legs stuff
    if partName == "Right_Foot" then return BodyPartType.Foot_R end
    if partName == "Left_Foot" then return BodyPartType.Foot_L end

end

-- Custom mapping to make more sense when cutting a limb
function JCIO_Common.GetAdjacentBodyPartFromPartName(partName)

    if partName == "Right_Hand" then return BodyPartType.ForeArm_R end
    if partName == "Right_LowerArm" then return BodyPartType.UpperArm_R end
    if partName == "Right_UpperArm" then return BodyPartType.Torso_Upper end
    if partName == "Left_Hand" then return BodyPartType.ForeArm_L end
    if partName == "Left_LowerArm" then return BodyPartType.UpperArm_L end
    if partName == "Left_UpperArm" then return BodyPartType.Torso_Upper end
    if partName == "Right_Foot" then return BodyPartType.LowerLeg_R end
    if partName == "Left_Foot" then return BodyPartType.LowerLeg_L end


end

function TocFindCorrectClothingProsthesis(itemName, partName)

    -- TODO This is not gonna work soon, so don't use this
    local correctName = "TOC.Prost_" .. partName .. "_" .. itemName
    return correctName

end

JCIO_Common.GetAmputationItemInInventory = function(player, partName)

    local playerInv = player:getInventory()
    local amputationItemName = TocFindAmputationOrProsthesisName(partName, player, "Amputation")
    local amputationItem = playerInv:FindAndReturn(amputationItemName)
    return amputationItem
end

function JCIO_Common.GetSawInInventory(surgeon)

    local playerInv = surgeon:getInventory()
    local item = playerInv:getItemFromType("Saw") or playerInv:getItemFromType("GardenSaw") or
        playerInv:getItemFromType("Chainsaw")
    return item
end




function JCIO_Common.GetSideFromPartName(partName)

    if string.find(partName, "Left") then
        return "Left"
    else
        return "Right"
    end

end