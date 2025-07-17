-- Variables

local QBCore = exports['qb-core']:GetCoreObject()

-- Functions

local function GlobalTax(value)
	local tax = (value / 100 * Config.GlobalTax)
	return tax
end

-- Server Events

RegisterNetEvent("ps-fuel:server:OpenMenu", function (amount, inGasStation, hasWeapon)
	local src = source
	if not src then return end
	local player = QBCore.Functions.GetPlayer(src)
	if not player then return end
	local tax = GlobalTax(amount)
	local total = math.ceil(amount + tax)
	
	if inGasStation == true and not hasWeapon then
		TriggerClientEvent('ps-fuel:client:ShowMenu', src, total, inGasStation, hasWeapon, Lang:t('info.total_cost', {value = total}))
	else
		TriggerClientEvent('ps-fuel:client:ShowMenu', src, total, inGasStation, hasWeapon, Lang:t('info.refuel_from_jerry_can'))
	end
end)

QBCore.Functions.CreateCallback('ps-fuel:server:fuelCan', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local itemData = Player.Functions.GetItemByName("weapon_petrolcan")
    cb(itemData)
end)

RegisterNetEvent("ps-fuel:server:PayForFuel", function (amount, paymentMethod)
	local src = source
	if not src then return end
	local player = QBCore.Functions.GetPlayer(src)
	if not player then return end
	player.Functions.RemoveMoney(paymentMethod, amount)
end)

RegisterNetEvent('ps-fuel:server:BuyCan', function (paymentMethod)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not paymentMethod then return end
	if Player.Functions.AddItem("weapon_petrolcan", 1, false) then -- added this before the money removal just incase the player is overweight and cant give item it wont do anything
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weapon_petrolcan"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t('info.purchased_jerry_can', {value = Config.canCost}), "success")
		Player.Functions.RemoveMoney(paymentMethod, Config.canCost)
	end
end)