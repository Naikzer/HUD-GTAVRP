------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

local showMenu = false
local toggleCoffre = 0
local toggleCapot = 0
local toggleLocked = 0
local playing_emote = false

------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------

-- Show crosshair (circle) when player targets entities (vehicle, pedestrian…)
function Crosshair(enable)
    SendNUIMessage({
        crosshair = enable
    })
end

-- Toggle focus (Example of Vehcile's menu)
RegisterNUICallback('disablenuifocus', function(data)
    showMenu = data.nuifocus
    SetNuiFocus(data.nuifocus, data.nuifocus)
end)

-- Toggle car trunk (Example of Vehcile's menu)
RegisterNUICallback('togglecoffre', function(data)
    if(toggleCoffre == 0)then
        SetVehicleDoorOpen(data.id, 5, false)
        toggleCoffre = 1
    else
        SetVehicleDoorShut(data.id, 5, false)
        toggleCoffre = 0
    end
end)

-- Toggle car hood (Example of Vehcile's menu)
RegisterNUICallback('togglecapot', function(data)
    if(toggleCapot == 0)then
        SetVehicleDoorOpen(data.id, 4, false)
        toggleCapot = 1
    else
        SetVehicleDoorShut(data.id, 4, false)
        toggleCapot = 0
    end
end)

-- Toggle car lock (Example of Vehcile's menu)
RegisterNUICallback('togglelock', function(data)
    if(toggleLocked == 0)then
        SetVehicleDoorsLocked(data.id, 2)
        TriggerEvent('InteractSound_CL:PlayOnOne', 'lock', 1.0)
        Citizen.Trace("Doors Locked")
        toggleLocked = 1
    else
        SetVehicleDoorsLocked(data.id, 1)
        Citizen.Trace("Doors Unlocked")
        TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 1.0)
        toggleLocked = 0
    end
end)

-- Example of animation (Ped's menu)
RegisterNUICallback('cheer', function(data)
    playerPed = GetPlayerPed(-1);
    if(not IsPedInAnyVehicle(playerPed)) then
        if playerPed then
            if playing_emote == false then
                TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_CHEERING', 0, true);
                playing_emote = true
            end
        end
    end
end)

------------------------------------------------------------------
--                          Citizen
------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        local Ped = GetPlayerPed(-1)

        -- Get informations about what user is targeting
        -- /!\ If not working, check that you have added "target" folder to resources and server.cfg
        local Entity, farCoordsX, farCoordsY, farCoordsZ = exports.target:Target(6.0, Ped)
        local EntityType = GetEntityType(Entity)

        -- If EntityType is Vehicle
        if(EntityType == 2) then
            if showMenu == false then
                SetNuiFocus(false, false)
            end
            Crosshair(true)

            if IsControlJustReleased(1, 38) then -- E is pressed
                showMenu = true
                SetNuiFocus(true, true)
                SendNUIMessage({
                    menu = 'vehicle',
                    idEntity = Entity
                })
            end
        -- If EntityType = User
        elseif(EntityType == 1) then
            if showMenu == false then
                SetNuiFocus(false, false)
            end
            Crosshair(true)

            if IsControlJustReleased(1, 38) then -- E is pressed
                showMenu = true
                SetNuiFocus(true, true)
                SendNUIMessage({
                    menu = 'user',
                    idEntity = Entity
                })
            end
        else
            SendNUIMessage({
                menu = false
            })
            SetNuiFocus(false, false)
            Crosshair(false)
        end


        -- Stop emotes if user press E
        -- TODO: Stop emotes if user move
        if playing_emote == true then
            if IsControlPressed(1, 38) then
                ClearPedTasks(Ped)
                playing_emote = false
            end
        end

        Citizen.Wait(1)
    end
end)
