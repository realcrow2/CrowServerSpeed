-- Server-side permission checking and speed limit assignment

local speedLimits = {}

-- Function to get player's speed limit based on ACE permissions
local function GetPlayerSpeedLimit(source)
    -- Check for owner permission first (highest priority)
    if IsPlayerAceAllowed(source, "serverspeed.owner") then
        return 700.0 -- mph
    end
    
    -- Check for Discord permission
    if IsPlayerAceAllowed(source, "serverspeed.discord") then
        return 250.0 -- mph
    end
    
    -- Default speed for everyone
    return 180.0 -- mph
end

-- Send speed limit to client when player connects
AddEventHandler('playerConnecting', function()
    local source = source
    Wait(1000) -- Wait a bit for player to fully connect
    local speedLimit = GetPlayerSpeedLimit(source)
    speedLimits[source] = speedLimit
    TriggerClientEvent('serverspeed:setSpeedLimit', source, speedLimit)
end)

-- Update speed limit when player's permissions might change
RegisterNetEvent('serverspeed:requestSpeedLimit')
AddEventHandler('serverspeed:requestSpeedLimit', function()
    local source = source
    local speedLimit = GetPlayerSpeedLimit(source)
    speedLimits[source] = speedLimit
    TriggerClientEvent('serverspeed:setSpeedLimit', source, speedLimit)
end)

-- Clean up when player disconnects
AddEventHandler('playerDropped', function()
    local source = source
    speedLimits[source] = nil
end)

