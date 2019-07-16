------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

local showHud = true                          -- Boolean to show / hide HUD
local hunger                                  -- Init hunger's variable. Set to 100 for development. 
local thirst                                  -- Init thirst's variable. Set to 100 for development. 

------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------

function updateHungerThirstHUD(hunger, thirst)
  SendNUIMessage({
    update = true,
    hunger = hunger,
    thirst = thirst
  })
end

------------------------------------------------------------------
--                          Citizen
------------------------------------------------------------------

-- Show HUD
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if showHud then
			TriggerEvent('esx_status:getStatus', 'hunger', function(hungerStatus)
				TriggerEvent('esx_status:getStatus', 'thirst', function(thirstStatus)
					updateHungerThirstHUD(hungerStatus.val / 10000, thirstStatus.val / 10000)
				end)
			end)
		end
    end
end)

-- Update hunger and thirst
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
      updateHungerThirst()
    end
end)