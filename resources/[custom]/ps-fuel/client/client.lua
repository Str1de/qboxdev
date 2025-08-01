-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local fuelSynced = false
local inBlacklisted = false
local inGasStation = false
local isFueling = false
local Stations = {}
local props = {
	'prop_gas_pump_1d',
	'prop_gas_pump_1a',
	'prop_gas_pump_1b',
	'prop_gas_pump_1c',
	'prop_vintage_pump',
	'prop_gas_pump_old2',
	'prop_gas_pump_old3',
}
local CurrentWeaponData = {}
local hasNozzle = false
local gasNozzle = nil
local refueling = false

-- Functions

local function isHoldingWeapon(weaponHash)
	return GetSelectedPedWeapon(PlayerPedId()) == weaponHash
end

local function ManageFuelUsage(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))
		fuelSynced = true
	end
	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
		SetVehicleEngineOn(veh, true, true, true)
	else
		SetVehicleEngineOn(veh, true, true, true)
	end
end

-- Threads

    
CreateThread(function()
		if Config.interact then
        exports.interact:AddGlobalVehicleInteraction({
            id = 'refuel_vehicle',
            offset = vec3(0.0, 0.0, 0.0),
            distance = 7.0,
            interactDst = 5.0,
            -- bone = 'boot', -- optional
            -- ignoreLos = true,
            options = {
                {
                    canInteract = function()
                        return inGasStation and hasNozzle or HasPedGotWeapon(PlayerPedId(), 883325847) 
                    end,
                    label = Lang:t('info.refuel_vehicle'),
                    action = function()
                        TriggerEvent('ps-fuel:client:SendMenuToServer')
                    end
                },
            }
        })

        for _, model in ipairs(props) do
            -- Target Export
            exports.interact:AddModelInteraction({
                model = model,  -- Replace 'props' with the specific model(s) if needed
                offset = vec3(0.0, 0.0, 1.0),  -- Optional offset
                name = 'fuelInteraction',  -- Optional interaction name
                id = 'fuelPumpInteraction',  -- Unique ID for the interaction
                distance = 8.0,  -- Interaction distance
                interactDst = 2.0,  -- Distance within which interaction options are available
                options = {
                    {
                        event = "ps-fuel:client:takenozzle",
                        label = Lang:t('info.take_nozzle'),
                        canInteract = function()
                            return not IsPedInAnyVehicle(PlayerPedId()) and not hasNozzle
                        end,
                    },
                    {
                        event = "ps-fuel:client:returnnozzle",
                        label = Lang:t('info.return_nozzle'),
                        canInteract = function()
                            return hasNozzle and not refueling
                        end,
                    },
                    {
                        event = "ps-fuel:client:buyCanMenu",
                        label = Lang:t('info.buy_jerry_can'),
                        canInteract = function(entity)
                            return not HasPedGotWeapon(PlayerPedId(), 883325847)
                        end,
                    },
                    {
                        event = "ps-fuel:client:refuelCanMenu",
                        label = Lang:t('info.refuel_jerry_can'),
                        canInteract = function(entity)
                            return isHoldingWeapon(GetHashKey("weapon_petrolcan"))
                        end,
                    },
                },
            })
        end
	elseif Config.oxtarget then
		local options = {
			[1] = {
				name = 'cdn-fuel:options:1',
				icon = "fas fa-gas-pump",
				canInteract = function()
					return inGasStation and hasNozzle or HasPedGotWeapon(PlayerPedId(), 883325847) 
				end,
				label = Lang:t('info.refuel_vehicle'),
				onSelect = function()
					TriggerEvent('ps-fuel:client:SendMenuToServer')
				end
			},
		}

		exports.ox_target:addGlobalVehicle(options)
		
		local modelOptions = {
			[1] = {
				name = "cdn-fuel:modelOptions:option_1",
				event = "ps-fuel:client:takenozzle",
				icon = "fas fa-gas-pump",
				label = Lang:t('info.take_nozzle'),
				canInteract = function(entity)
					return not IsPedInAnyVehicle(PlayerPedId()) and not hasNozzle
				end,
			},
			[2] = {
				name = "cdn-fuel:modelOptions:option_2",
				event = "ps-fuel:client:returnnozzle",
				icon = "fas fa-gas-pump",
				label = Lang:t('info.return_nozzle'),
				canInteract = function(entity)
					return hasNozzle and not refueling
				end,
			},
			[3] = {
				name = "cdn-fuel:modelOptions:option_3",
				event = "ps-fuel:client:buyCanMenu",
				icon = "fas fa-burn",
				label = Lang:t('info.buy_jerry_can'),
				canInteract = function(entity)
					return not HasPedGotWeapon(PlayerPedId(), 883325847)
				end,
			},
			[4] = {
				name = "cdn-fuel:modelOptions:option_4",
				event = "ps-fuel:client:refuelCanMenu",
				icon = "fas fa-gas-pump",
				label = Lang:t('info.refuel_jerry_can'),
				canInteract = function(entity)
					return isHoldingWeapon(GetHashKey("weapon_petrolcan"))
				end,
			},
			
		}

		exports.ox_target:addModel(props, modelOptions)
	else
		local bones = {
            "petroltank",
            "petroltank_l",
            "petroltank_r",
            "wheel_rf",
            "wheel_rr",
            "petrolcap ",
            "seat_dside_r",
            "engine",
        }
        exports['qb-target']:AddTargetBone(bones, {
            options = {
                {
                    type = "client",
                    event = "ps-fuel:client:SendMenuToServer",
                    icon = "fas fa-gas-pump",
                    label = Lang:t('info.refuel_vehicle'),
                    canInteract = function()
                        return inGasStation and hasNozzle or HasPedGotWeapon(PlayerPedId(), 883325847) 
                    end
                }
            },
            distance = 1.5,
        })
        -- Target Export
        exports['qb-target']:AddTargetModel(props, {
            options = {
                {
                    type = "client",
                    event = "ps-fuel:client:takenozzle",
                    icon = "fas fa-gas-pump",
                    label = Lang:t('info.take_nozzle'),
                    canInteract = function(entity)
                        return not IsPedInAnyVehicle(PlayerPedId()) and not hasNozzle
                    end,
                },
                {
                    type = "client",
                    event = "ps-fuel:client:returnnozzle",
                    icon = "fas fa-gas-pump",
                    label = Lang:t('info.return_nozzle'),
                    canInteract = function(entity)
                        return hasNozzle and not refueling
                    end,
                },
                {
                    type = "client",
                    event = "ps-fuel:client:buyCanMenu",
                    icon = "fas fa-burn",
                    label = Lang:t('info.buy_jerry_can'),
                    canInteract = function(entity)
                        return not HasPedGotWeapon(PlayerPedId(), 883325847)
                    end,
                },
                {
                    type = "client",
                    event = "ps-fuel:client:refuelCanMenu",
                    icon = "fas fa-gas-pump",
                    label = Lang:t('info.refuel_jerry_can'),
                    canInteract = function(entity)
                        return isHoldingWeapon(GetHashKey("weapon_petrolcan"))
                    end,
                },
            },
            distance = 2.0
        })
    end
end)

if Config.LeaveEngineRunning then
	CreateThread(function()
		while true do
			Wait(100)
			local ped = GetPlayerPed(-1)
			if DoesEntityExist(ped) and IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and not IsPauseMenuActive() then
				local engineWasRunning = GetIsVehicleEngineRunning(GetVehiclePedIsIn(ped, true))
				Wait(1000)
				if DoesEntityExist(ped) and not IsPedInAnyVehicle(ped, false) and not IsEntityDead(ped) and not IsPauseMenuActive() then
					local veh = GetVehiclePedIsIn(ped, true)
					if engineWasRunning then
						SetVehicleEngineOn(veh, true, true, true)
					end
				end
			end
		end
	end)
end

if Config.ShowNearestGasStationOnly then
	CreateThread(function()
		local currentGasBlip = 0
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords
			
			for _, gasStationCoords in pairs(Config.GasStationsBlips) do
				local dstcheck = #(coords - gasStationCoords)
				if dstcheck < closest then
					closest = dstcheck
					closestCoords = gasStationCoords
				end
			end
			if DoesBlipExist(currentGasBlip) then
				RemoveBlip(currentGasBlip)
			end
			currentGasBlip = CreateBlip(closestCoords)
			Wait(10000)
		end
	end)
	
else
	CreateThread(function()
		for _, gasStationCoords in pairs(Config.GasStationsBlips) do
			CreateBlip(gasStationCoords)
		end
	end)
end

CreateThread(function()
	for k=1, #Config.GasStations do
		Stations[k] = PolyZone:Create(Config.GasStations[k].zones, {
			name="GasStation"..k,
			minZ = 	Config.GasStations[k].minz,
			maxZ = Config.GasStations[k].maxz,
			debugPoly = false
		})
		Stations[k]:onPlayerInOut(function(isPointInside)
			if isPointInside then
				inGasStation = true
			else
				inGasStation = false
			end
		end)
	end
end)

CreateThread(function()
	DecorRegister(Config.FuelDecor, 1)
	for index = 1, #Config.Blacklist do
		if type(Config.Blacklist[index]) == 'string' then
			Config.Blacklist[GetHashKey(Config.Blacklist[index])] = true
		else
			Config.Blacklist[Config.Blacklist[index]] = true
		end
	end
	for index = #Config.Blacklist, 1, -1 do
		Config.Blacklist[index] = nil
	end
	while true do
		Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if Config.Blacklist[GetEntityModel(vehicle)] then
				inBlacklisted = true
			else
				inBlacklisted = false
			end
			if not inBlacklisted and GetPedInVehicleSeat(vehicle, -1) == ped then
				ManageFuelUsage(vehicle)
			end
		else
			if fuelSynced then
				fuelSynced = false
			end
			if inBlacklisted then
				inBlacklisted = false
			end
		end
	end
end)

-- Client Events

RegisterNetEvent('ps-fuel:client:buyCanMenu', function()
	lib.registerContext({
		id = 'fuel_buy_can_menu',
		title = Lang:t('info.gas_station'),
		options = {
			{
				title = Lang:t('info.total_can_cost', {value = Config.canCost}),
				description = 'Purchase a Jerry Can',
				icon = 'shopping-cart',
				onSelect = function()
					TriggerEvent('ps-fuel:client:ShowCanInput')
				end
			}
		}
	})
	lib.showContext('fuel_buy_can_menu')
end)

RegisterNetEvent('ps-fuel:client:ShowCanInput', function ()
	local playerMoney = QBCore.Functions.GetPlayerData().money
	local input = lib.inputDialog('Gas Station', {
		{
			type = 'select',
			label = 'Payment Method',
			description = 'Jerry Can Cost: $'..Config.canCost,
			icon = 'fas fa-credit-card',
			required = true,
			options = {
				{ value = 'cash', label = 'Cash - $'..Config.canCost },
				{ value = 'bank', label = 'Card - $'..Config.canCost }
			}
		}
	})

	if not input then return end
	
	local paymentMethod = input[1]
	if playerMoney[paymentMethod] >= Config.canCost then
		TriggerServerEvent('ps-fuel:server:BuyCan', paymentMethod)
	else
		QBCore.Functions.Notify(Lang:t("notify.no_money"), "error")
	end
end)

RegisterNetEvent('ps-fuel:client:refuelCanMenu', function()
	local ped = PlayerPedId()
	local price = 0
	local weapon = GetSelectedPedWeapon(ped)
	local ammo = GetAmmoInPedWeapon(ped, weapon)
	local ammotoAdd = 4500 - ammo
	
	local fuelToAdd = tonumber(ammotoAdd/45)
	if fuelToAdd ~= 0 then
		price = math.floor(fuelToAdd * Config.fuelPrice)
		local playerMoney = QBCore.Functions.GetPlayerData().money
		
		local input = lib.inputDialog('Gas Station', {
			{
				type = 'select',
				label = 'Payment Method',
				description = 'Jerry Can Refuel Cost: $'..Config.refuelCost,
				icon = 'fas fa-credit-card',
				required = true,
				options = {
					{ value = 'cash', label = 'Cash - $'..Config.refuelCost },
					{ value = 'bank', label = 'Card - $'..Config.refuelCost }
				}
			}
		})

		if not input then return end
		
		local paymentMethod = input[1]
		if playerMoney[paymentMethod] >= Config.refuelCost then
			lib.registerContext({
				id = 'fuel_refuel_can_menu',
				title = Lang:t('info.gas_station'),
				options = {
					{
						title = Lang:t("info.total_refuel_cost", {value = Config.refuelCost}),
						description = 'Refuel your Jerry Can',
						icon = 'gas-pump',
						onSelect = function()
							TriggerEvent('ps-fuel:client:refuelCan', paymentMethod)
						end
					}
				}
			})
			lib.showContext('fuel_refuel_can_menu')
		else
			QBCore.Functions.Notify(Lang:t("notify.no_money"), "error")
		end
	else
		QBCore.Functions.Notify(Lang:t("already_full"), "error")
	end
end)

RegisterNetEvent('ps-fuel:client:refuelCan', function(paymentMethod)
	local vehicle = QBCore.Functions.GetClosestVehicle()
	local ped = PlayerPedId()
	local CurFuel = GetVehicleFuelLevel(vehicle)
	if HasPedGotWeapon(ped, 883325847) then
		if GetAmmoInPedWeapon(ped, 883325847) < 4500 then
			RequestAnimDict("weapon@w_sp_jerrycan")
			while not HasAnimDictLoaded('weapon@w_sp_jerrycan') do Wait(100) end
			TaskPlayAnim(ped, "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
			QBCore.Functions.Progressbar("refuel-car", "Refueling", 10000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('ps-fuel:server:PayForFuel', Config.refuelCost, paymentMethod, GetPlayerServerId(PlayerId()))
				TriggerServerEvent("weapons:server:UpdateWeaponAmmo", CurrentWeaponData, tonumber(4500))
				PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
				StopAnimTask(ped, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
			end, function() -- Cancel
				QBCore.Functions.Notify(Lang:t("notify.refuel_cancel"), "error")
				StopAnimTask(ped, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
			end)
		else
			QBCore.Functions.Notify(Lang:t("notify.jerrycan_full"), "error")
		end
	end
end)

RegisterNetEvent('ps-fuel:client:SendMenuToServer', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	local CurFuel = GetVehicleFuelLevel(vehicle)
	local refillCost = Round(Config.RefillCost - CurFuel) * Config.CostMultiplier
	local ped = PlayerPedId()
	if HasPedGotWeapon(ped, 883325847) then
		if GetAmmoInPedWeapon(ped, 883325847) ~= 0 then
			if CurFuel < 95 then
				TriggerServerEvent('ps-fuel:server:OpenMenu', 0, inGasStation, true)
			else
				QBCore.Functions.Notify(Lang:t("notify.vehicle_full"), "error")
			end
		else
			QBCore.Functions.Notify(Lang:t("notify.jerrycan_empty"), "error")
		end
	else
		if CurFuel < 95 then
			TriggerServerEvent('ps-fuel:server:OpenMenu', refillCost, inGasStation, false)
		else
			QBCore.Functions.Notify(Lang:t("notify.vehicle_full"), "error")
		end
	end
end)

AddEventHandler('weapons:client:SetCurrentWeapon', function(data, bool)
	if bool ~= false then
		CurrentWeaponData = data
	else
		CurrentWeaponData = {}
	end
	CanShoot = bool
end)

RegisterNetEvent('ps-fuel:client:ShowMenu', function(refillCost, inGasStation, hasWeapon, text)
	lib.registerContext({
		id = 'fuel_main_menu',
		title = Lang:t('info.gas_station'),
		options = {
			{
				title = text,
				description = 'Click to proceed with fueling',
				icon = 'gas-pump',
				onSelect = function()
					TriggerEvent('ps-fuel:client:ShowInput', refillCost)
				end
			}
		}
	})
	lib.showContext('fuel_main_menu')
end)

RegisterNetEvent('ps-fuel:client:ShowInput', function (refillCost)
	local ped = PlayerPedId()
	local playerMoney = QBCore.Functions.GetPlayerData().money
	if not HasPedGotWeapon(ped, 883325847) then
		local input = lib.inputDialog('Gas Station', {
			{
				type = 'select',
				label = 'Payment Method',
				description = 'Total Cost: $'..refillCost,
				icon = 'fas fa-credit-card',
				required = true,
				options = {
					{ value = 'cash', label = 'Cash - $'..refillCost },
					{ value = 'bank', label = 'Card - $'..refillCost }
				}
			}
		})

		if not input then return end
		
		local paymentMethod = input[1]
		if playerMoney[paymentMethod] >= refillCost then
			TriggerEvent('ps-fuel:client:RefuelVehicle', refillCost, paymentMethod)
		else
			QBCore.Functions.Notify(Lang:t("notify.no_money"), "error")
		end
	else
		TriggerEvent('ps-fuel:client:RefuelVehicle')
	end
end)

RegisterNetEvent('ps-fuel:client:RefuelVehicle', function(refillCost, paymentMethod)
	local vehicle = QBCore.Functions.GetClosestVehicle()
	local ped = PlayerPedId()
	local CurFuel = GetFuel(vehicle)
	local time = (100 - CurFuel) * 400
	local vehicleCoords = GetEntityCoords(vehicle)
	local playerMoney = QBCore.Functions.GetPlayerData().money
	if inGasStation == false and not HasPedGotWeapon(ped, 883325847) then
	elseif inGasStation == false and GetAmmoInPedWeapon(ped, 883325847) == 0 then
		return
	end
	if HasPedGotWeapon(ped, 883325847) then
		local fuelToAdd = tonumber((100 - CurFuel) * 45)
		local weapon = GetSelectedPedWeapon(ped)
		local ammo = GetAmmoInPedWeapon(ped, weapon)
		if fuelToAdd == 0 then
			QBCore.Functions.Notify(Lang:t('error.vehicle_already_full'), "error")
			return
		end
		if ammo <= 40 then
			QBCore.Functions.Notify(Lang:t('error.no_fuel_gas_can'), "error")
		else
			RequestAnimDict("weapon@w_sp_jerrycan")
			while not HasAnimDictLoaded('weapon@w_sp_jerrycan') do
				Wait(100)
			end
			TaskPlayAnim(ped, "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
			if GetIsVehicleEngineRunning(vehicle) and Config.VehicleBlowUp then
				local Chance = math.random(1, 100)
				if Chance <= Config.BlowUpChance then
					AddExplosion(vehicleCoords, 5, 50.0, true, false, true)
					return
				end
			end
			TriggerEvent("ps-fuel:client:fuelTick", vehicle)
			QBCore.Functions.Progressbar("refuel-car", "Refueling", time, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				SetFuel(vehicle, 100)
				local totalAmmo = math.floor(math.abs(ammo - fuelToAdd))
				if totalAmmo < 0 then
					totalAmmo = 0
				end
				TriggerServerEvent("weapons:server:UpdateWeaponAmmo", CurrentWeaponData, totalAmmo)
				PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
				StopAnimTask(ped, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
				isFueling = false
			end, function() -- Cancel
				QBCore.Functions.Notify(Lang:t("notify.refuel_cancel"), "error")
				StopAnimTask(ped, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
			end)
		end
	else
		if inGasStation then
			if isCloseVeh() then
				if playerMoney[paymentMethod] <= refillCost then
					QBCore.Functions.Notify(Lang:t("notify.no_money"), "error")
				else
					TaskTurnPedToFaceEntity(ped, vehicle, 5000)
					Wait(2000)
					RequestAnimDict("amb@world_human_security_shine_torch@male@base")
					while not HasAnimDictLoaded('amb@world_human_security_shine_torch@male@base') do
						Wait(100)
					end
					TaskPlayAnim(ped, "amb@world_human_security_shine_torch@male@base", "base", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
					refueling = true
					if GetIsVehicleEngineRunning(vehicle) and Config.VehicleBlowUp then
						local Chance = math.random(1, 100)
						if Chance <= Config.BlowUpChance then
							Wait(1000)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "fuelstop", 0.3)
							AddExplosion(vehicleCoords, 5, 50.0, true, false, true)
							DeleteObject(gasNozzle)
							gasNozzle = nil
							refueling = false
							hasNozzle = false
							return
						end
					end
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "putbacknozzle", 0.6)
					Wait(1000)
					TriggerServerEvent("InteractSound_SV:PlayOnSource", "fueling-sound", 0.5)
					QBCore.Functions.Progressbar("refuel-car", "Refueling", time, false, true, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {}, {}, {}, function() -- Done
						refueling = false
						TriggerServerEvent('ps-fuel:server:PayForFuel', refillCost, paymentMethod, GetPlayerServerId(PlayerId()))
						SetFuel(vehicle, 100)
						TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "fuelstop", 0.6)
						PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
						Wait(500)
						StopAnimTask(ped, "amb@world_human_security_shine_torch@male@base", 'base', 3.0, 3.0, -1, 2, 0, 0, 0, 0)
					end, function() -- Cancel
						refueling = false
						TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "fuelstop", 0.6)
						QBCore.Functions.Notify(Lang:t("notify.refuel_cancel"), "error")
						StopAnimTask(ped, "amb@world_human_security_shine_torch@male@base", 'base', 3.0, 3.0, -1, 2, 0, 0, 0, 0)
					end)
				end
			end
		end
	end
end)

RegisterNetEvent('ps-fuel:client:takenozzle', function ()
	if hasNozzle then return end
	local ped = PlayerPedId()
	local nozzleProp = "prop_cs_fuel_nozle"
	RequestAnimDict("anim@am_hold_up@male")
	while not HasAnimDictLoaded('anim@am_hold_up@male') do
		Wait(100)
	end
	TaskPlayAnim(ped, "anim@am_hold_up@male", "shoplift_high", 2.0, 8.0, 1000, 50, 0, 0, 0, 0)
	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "pickupnozzle", 0.6)
	QBCore.Functions.LoadModel(nozzleProp)
	gasNozzle = CreateObject(nozzleProp, 1.0, 1.0, 1.0, 1, 1, 0)
	if DoesEntityExist(gasNozzle) then
		hasNozzle = true
		AttachEntityToEntity(gasNozzle, ped, GetPedBoneIndex(ped, 18905), 0.13, 0.04, 0.01, -42.0, -115.0, -63.42, 0, 1, 0, 1, 0, 1)
	end
end)

RegisterNetEvent('ps-fuel:client:returnnozzle', function ()
	if not hasNozzle then return end
	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "putbacknozzle", 0.6)
	hasNozzle = false
	DeleteObject(gasNozzle)
	gasNozzle = nil
end)