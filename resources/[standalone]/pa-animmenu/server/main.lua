RegisterNetEvent('pa-animmenu:sendAnimRequest:server', function(data)
    TriggerClientEvent('pa-animmenu:receiveAnimRequest:client', data.id, data)
end)

RegisterNetEvent('pa-animmenu:playAnimTogetherSender:server', function(data)
    TriggerClientEvent('pa-animmenu:playAnimTogetherSender:client', data.data.target, data)
end)

RegisterNetEvent('pa-animmenu:requstCanelledNotif:server', function(target)
    TriggerClientEvent('pa-animmenu:requstCanelledNotif:client', target)
end)

RegisterNetEvent('pa-animmenu:cancelEmote:server', function(target)
    TriggerClientEvent('pa-animmenu:cancelEmote:client', target)
end)

RegisterNetEvent('pa-animmenu:animDictLoaded:server', function(target)
    TriggerClientEvent('pa-animmenu:animDictLoaded:client', target)
end)

RegisterNetEvent('pa-animmenu:ptfxSync:server', function(asset, name, offset, rot, bone, scale, color)
    if type(asset) ~= "string" or type(name) ~= "string" or type(offset) ~= "vector3" or type(rot) ~= "vector3" then
        return
    end
    local srcPlayerState = Player(source).state
    srcPlayerState:set('ptfxAsset', asset, true)
    srcPlayerState:set('ptfxName', name, true)
    srcPlayerState:set('ptfxOffset', offset, true)
    srcPlayerState:set('ptfxRot', rot, true)
    srcPlayerState:set('ptfxBone', bone, true)
    srcPlayerState:set('ptfxScale', scale, true)
    srcPlayerState:set('ptfxColor', color, true)
    srcPlayerState:set('ptfxPropNet', false, true)
    srcPlayerState:set('ptfx', false, true)
end)

RegisterNetEvent("pa-animmenu:ptfxSyncProp:server", function(propNet)
    local srcPlayerState = Player(source).state
    if propNet then
        local waitForEntityToExistCount = 0
        while waitForEntityToExistCount <= 100 and not DoesEntityExist(NetworkGetEntityFromNetworkId(propNet)) do
            Wait(10)
            waitForEntityToExistCount = waitForEntityToExistCount + 1
        end
        if waitForEntityToExistCount < 100 then
            srcPlayerState:set('ptfxPropNet', propNet, true)
            return
        end
    end
    srcPlayerState:set('ptfxPropNet', false, true)
end)

Citizen.CreateThread(function()
    -- Find resources that contains "smallresources"
    -- handsup.lua
    local resourceList = {}
    for i = 0, GetNumResources(), 1 do
        local resource_name = GetResourceByFindIndex(i)
        if resource_name and GetResourceState(resource_name) == "started" then
            table.insert(resourceList, resource_name)
        end
    end
    local findedResources = {}
    for k, v in pairs(resourceList) do
        if string.match(v, "smallresources") then
            table.insert(findedResources, v)
        end
    end
    for k, v in pairs(findedResources) do
        local loadedFile = LoadResourceFile(v, "client/handusp.lua")
        if loadedFile ~= nil then
            local resPath = GetResourcePath(v)
            print("^0[^3WARNING^0] " .. GetCurrentResourceName() .. " ^1" .. v .. "/client/handsup.lua ^0file deleted by script.")
            os.remove(resPath .. "/client/handusp.lua")
            Citizen.Wait(500)
            StopResource(v)
            Citizen.Wait(500)
            StartResource(v)
        end
    end
    -- crouchprone.lua
    for k, v in pairs(findedResources) do
        local loadedFile = LoadResourceFile(v, "client/crouchprone.lua")
        if loadedFile ~= nil then
            local resPath = GetResourcePath(v)
            print("^0[^3WARNING^0] " .. GetCurrentResourceName() .. " ^1" .. v .. "/client/crouchprone.lua ^0file deleted by script.")
            os.remove(resPath .. "/client/crouchprone.lua")
            Citizen.Wait(500)
            StopResource(v)
            Citizen.Wait(500)
            StartResource(v)
        end
    end
end)

RegisterNetEvent('pa-animmenu:convertCode:server', function(code, type)
    local src = source
    local type = string.lower(type)
    local tableString = "return {" .. code .. "}"
    local loadedFunction, errorMessage = load(tableString)
    if loadedFunction then
        local resultTable = loadedFunction()
        for key, value in pairs(resultTable) do
            if type == "expressions" or type == "walks" then
                local newTableString = '{\n    "' .. value[1] .. '",\n    "' .. key .. '",\n    "' .. string.lower(key) .. '",\n    ' .. 'imageId = "' .. string.lower(key) .. '"\n},'
                TriggerClientEvent('pa-animmenu:copyCode:client', src, newTableString)
            elseif type == "dances" then
                local animationOptions = ""
                if value.AnimationOptions then
                    for optKey, optValue in pairs(value.AnimationOptions) do
                        animationOptions = animationOptions .. optKey .. " = " .. tostring(optValue) .. ", "
                    end
                    animationOptions = "{" .. animationOptions .. "}"
                end
                local newTableString = string.format('{\n    "%s",\n    "%s",\n    "%s",\n    "%s",\n    imageId = "%s",\n    AnimationOptions = %s\n},', key, value[3], value[1], value[2], string.lower(key), animationOptions)
                TriggerClientEvent('pa-animmenu:copyCode:client', src, newTableString)
            elseif type == "emotes" then
                local animationOptions = ""
                if value.AnimationOptions then
                    for optKey, optValue in pairs(value.AnimationOptions) do
                        animationOptions = animationOptions .. optKey .. " = " .. tostring(optValue) .. ", "
                    end
                    animationOptions = "{" .. animationOptions .. "}"
                end
                local newTableString = string.format('{\n    "%s",\n    "%s",\n    "%s",\n    "%s",\n    imageId = "%s",\n    AnimationOptions = %s\n},', key, value[1], value[2], value[3], string.lower(key), animationOptions)
                print(newTableString)
                TriggerClientEvent('pa-animmenu:copyCode:client', src, newTableString)
            end
        end
    else
        print("Error loading code: " .. errorMessage)
    end
end)

-- Citizen.CreateThread(function()
--     local path = GetResourcePath(GetCurrentResourceName())
--     local tempfile, err = io.open(path:gsub('//', '/')..'/'..string.gsub("test", ".lua", "")..'.lua', 'a+')
--     if tempfile then
--         tempfile:close()
--         path = path:gsub('//', '/')..'/'..string.gsub("test", ".lua", "")..'.lua'
--     end
--     local file = io.open(path, 'a+')
--     file:write("PA.Dances = {")
--     for k, v in pairs(PA.Dances) do
--         file:write("\n    {")
--         local str1 = ("\n        '%s',"):format(v[1])
--         file:write(str1)
--         local str2 = ("\n        '%s',"):format(v[2])
--         file:write(str2)
--         local str3 = ("\n        '%s',"):format(v[3])
--         file:write(str3)
--         local str4 = ("\n        '%s',"):format(v[4])
--         file:write(str4)
--         local str5 = ("\n        %s = '%s'"):format("imageId", "dance-" .. v[1]:sub(6))
--         file:write(str5)
--         file:write("\n    },")
--     end
--     file:write("\n}")
-- 	file:close()
-- end)