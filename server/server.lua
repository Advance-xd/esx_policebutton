ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_policebutton:updatebutton")
AddEventHandler("esx_policebutton:updatebutton", function(button)
    TriggerClientEvent('esx_policebutton:updatebuttonC', -1, button)
    if button == true then
        starttimer()
    end
end)

function starttimer()
    Citizen.Wait(Config.cooldowntime * 1000)
    TriggerEvent('esx_policebutton:updatebutton', false)
end