local animDict = 'mini@repair'
local Anim = 'fixing_a_player'
local time = Config.Settings.RobTime
local CurrentCops = 0

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    for k,v in pairs(Config.Safes) do
        Wrapper:Target('safe'..v,'Rob',v,'bbv-robstore')
        if Config.Settings.Blips then 
            Wrapper:Blip('safe'..v,'Store Robbery',v,110,40,0.6)
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)
    for k,v in pairs(Config.Safes) do
        Wrapper:Target('safe'..v,'Rob',v,'bbv-robstore')
        if Config.Settings.Blips then 
            Wrapper:Blip('safe'..v,'Store Robbery',v,110,40,0.6)
        end
    end
end)

RegisterNetEvent('bbv-robstore',function()
    if not HasCops() then 
        Wrapper:Notify("Not enough  police.")
        return 
    end
    if Config.Settings.Framework == "QB" then 
        local hasitem = QBCore.Functions.HasItem(Config.Settings.ItemNeeded)
        if not hasitem then
            Wrapper:Notify("You are missing something.")
            return
        end
    end
    if Config.Settings.Framework == "ESX" then
        local Inventory = exports.ox_inventory
        local hasitem = Inventory:Search('count', Config.Settings.ItemNeeded)
        if not hasitem then
            Wrapper:Notify("You are missing something.")
            return
        end
    end
    if Cooldown() then
        Wrapper:Notify("Robbery is on cooldown")
        return 
    end
    AlertPolice()
    Wrapper:RemoveItem(Config.Settings.ItemNeeded, 1)
    Wrapper:Log('STORE ROBBERY')
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(100)
    end
    robbing = true
    TaskPlayAnim(PlayerPedId(), animDict, Anim, 8.0, 8.0, -1, 1, 1, false, false, false)
    FreezeEntityPosition(PlayerPedId(),true)
    TriggerEvent('bbv-robstore:cd')
    TriggerEvent('bbv-robstore:countdown')
end)

RegisterNetEvent('bbv-robstore:cd',function()
    for i = Config.Settings.RobTime, 1, -1 do
        if robbing then 
            Wait(1000)
            time = i
            if time == 1 then 
                Wrapper.TriggerCallback('bbv-storerobberyaddmoney', function(data)
                end)
                robbing,time = false,Config.Settings.RobTime
                ClearPedTasks(PlayerPedId())
                FreezeEntityPosition(PlayerPedId(),false)
                Wrapper:Notify("You stole ".. Config.Settings.Reward .. ' $')
            end
        else
            return
        end
    end
end)

RegisterNetEvent('bbv-robstore:countdown',function()
    while robbing do 
        Wait(0)
        if IsControlJustReleased(1, 47) then 
            robbing,time = false,Config.Settings.RobTime
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(),false)
        end
        Wrapper:Drawtxt(0.43, 0.93,"Seconds left : " .. time)
        Wrapper:Drawtxt(0.43, 0.95,"Press [G] to cancel ")
    end
end)

function Cooldown()
    Wrapper.TriggerCallback('bbv-storerobbery:cooldown', function(data)
        _result = data
        return
    end)
    Wait(500)
    return _result
end

function AlertPolice()
     -- Put your alert here
end

function HasCops()
    if Config.Settings.Framework == "QB" then 
        if CurrentCops >= Config.Settings.CopsNeeded then 
            return true 
        end
    end
    if Config.Settings.Framework == "ESX" then 
        Wrapper.TriggerCallback('shoprobbery:server:checkPoliceCount', function(data)
            CurrentCops = data
            return
        end)
        Wait(500)
        if CurrentCops >= Config.Settings.CopsNeeded then 
            return true 
        end
    end
end
