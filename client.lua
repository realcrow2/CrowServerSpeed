local playerSpeedLimit = 180.0 -- Default speed limit in mph (will be updated from server)

-- Convert mph to m/s (GTA uses m/s internally)
local function mphToMs(mph)
    return mph * 0.44704
end

-- Check if vehicle is an aircraft
local function IsAircraft(vehicle)
    local vehicleClass = GetVehicleClass(vehicle)
    -- Vehicle class 15 = Helicopters, 16 = Planes
    return vehicleClass == 15 or vehicleClass == 16
end

-- Receive speed limit from server
RegisterNetEvent('serverspeed:setSpeedLimit')
AddEventHandler('serverspeed:setSpeedLimit', function(speedLimit)
    playerSpeedLimit = speedLimit
end)

-- Request speed limit from server on resource start
CreateThread(function()
    Wait(2000) -- Wait for server to be ready
    TriggerServerEvent('serverspeed:requestSpeedLimit')
end)

-- Main loop to limit vehicle speed
CreateThread(function()
    while true do
        Wait(0)
        
        local ped = PlayerPedId()
        
        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            
            -- Only apply speed limits to ground vehicles
            if not IsAircraft(vehicle) then
                local speedLimitMs = mphToMs(playerSpeedLimit)
                -- Set max speed for ground vehicles
                SetEntityMaxSpeed(vehicle, speedLimitMs)
            else
                -- Remove speed limit for aircraft (set very high limit)
                SetEntityMaxSpeed(vehicle, 1000.0)
            end
        end
    end
end)

