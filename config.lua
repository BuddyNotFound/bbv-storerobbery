Config = {}
Config.Debug = false

QBCore = exports['qb-core']:GetCoreObject()  -- uncomment if you use QBCore
-- ESX = exports["es_extended"]:getSharedObject() -- uncomment if you use ESX


Config.Settings = {
	Framework = 'QB', -- QB/ESX
	Inventory = 'OX', -- QB/OX
	Target = "OX", -- OX/QB
	WebHook = "", -- Discord webhook 
	Reward = 5500, -- Cash Reward per bill.
	Cooldown = 10, -- Cooldwon in minutes.
	RobTime = 300, -- Time it takes to rob the store (in seconds)
	ItemNeeded = 'crowbar', -- Item Requierd for the robbery.
	CopsNeeded = 3,
	Blips = true 
}

Config.Safes = {
	vector3(-43.94, -1747.93, 28.92),
	vector3(28.3, -1338.63, 29.11),
	vector3(1158.89, -314.03, 68.83),
	vector3(378.27, 333.66, 103.16),
	vector3(-1221.4, -916.38, 11.11),
	vector3(1126.74, -979.53, 45.36),
	vector3(1958.9, 3749.5, 31.81),
	vector3(2672.16, 3286.93, 54.7),
	vector3(1708.15, 4920.85, 41.6),
	vector3(1735.1, 6421.52, 34.57)
}