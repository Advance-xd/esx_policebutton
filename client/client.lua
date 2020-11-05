ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(0)
	end
end)

local cooldown = false

Citizen.CreateThread(function()
	Citizen.Wait(1)

	while true do
		local playerCoords = GetEntityCoords(GetPlayerPed(-1))
		local distance = GetDistanceBetweenCoords(playerCoords, Config.coords.x, Config.coords.y, Config.coords.z, true)
		
		if distance < Config.maxdistance then
			if cooldown == false then
				displayText = "Kalla på polis"
			else
				displayText = "Knappen är på cooldown"
			end
			displayText = "[~g~E~s~] " .. displayText
			ESX.Game.Utils.DrawText3D(Config.coords, displayText, 0.4)
			if distance < Config.maxarmdistance then
				if IsControlJustReleased(0, 38) then
					if cooldown == false then
						updatebutton(true)
						notipolice()
					end
				end
			end
		end
	Citizen.Wait(1)
	end
end)

function notipolice()
	TriggerServerEvent('esx_phone:send', 'police', "Någon väntar på assistant i lobbyn", true, false)
end

function updatebutton(button)
	TriggerServerEvent('esx_policebutton:updatebutton', button)
end

RegisterNetEvent("esx_policebutton:updatebuttonC")
AddEventHandler("esx_policebutton:updatebuttonC", function(button)
    cooldown = button
end)

-- av ADVANCE