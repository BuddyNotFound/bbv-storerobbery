Main = {}
picked = 0

Wrapper.CreateCallback('bbv-storerobberyaddmoney', function(source, cb, args)
    if Config.Settings.Framework == "QB" then 
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        Player.Functions.AddMoney('cash', Config.Settings.Reward)
    end
    if Config.Settings.Framework == "ESX" then 
        local src = source
        local Player = ESX.GetPlayerFromId(src)
        Player.addMoney(Config.Settings.Reward)
    end
end)

Wrapper.CreateCallback('bbv-storerobbery:cooldown', function(source, cb, args)
    if not cooldown then 
        cb(false)
    else
        cb(true)
    end
    Main:Cooldown()
end)

Wrapper.CreateCallback('shoprobbery:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end

    cb(policeCount)
end)

function Main:Cooldown()
    if cooldown then return end 
    cooldown = true
    Wait(Config.Settings.Cooldown * 60000)
    cooldown = false
    picked = 0
end

