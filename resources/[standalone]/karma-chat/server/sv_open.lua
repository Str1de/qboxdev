-- Command to clear the CHAT Messages EXAMPLES
 
RegisterCommand("clear", function(source)
    TriggerClientEvent("chat:clear", source)
end)

-- Command to talk /ooc (General) with players EXAMPLES

RegisterCommand('ooc', function(source, args)
    if not args[1] then return end
    local src = source
    local msg = ""
    for i = 1, #args do
        msg = msg .. " " .. args[i]
    end
    local name = GetPlayerName(source)
    TriggerClientEvent( "chatMessage",-1 , "OOC | " .. name ,2 , msg, 'ooc')
end)


-- 911 Command EXAMPLES

RegisterCommand('911', function(source, args, rawCommand)
    if not args[1] then return end
    local src = source
    local msg = ""
    local sourcePed = GetPlayerPed(src)
    local sourceCoords = GetEntityCoords(sourcePed)
    for i = 1, #args do
        msg = msg .. " " .. args[i]
    end
    local name = GetPlayerName(source)
    TriggerClientEvent("chatMessage", -1, "911 | " .. name ,{ 238, 230, 0 } , msg, sourceCoords, 'dispatch')
end)


-- 311 Command EXAMPLES


RegisterCommand('311', function(source, args, rawCommand)
    if not args[1] then return end
    local src = source
    local msg = ""
    local sourcePed = GetPlayerPed(src)
    local sourceCoords = GetEntityCoords(sourcePed)
    for i = 1, #args do
        msg = msg .. " " .. args[i]
    end
    local name = GetPlayerName(source)
    TriggerClientEvent("chatMessage", -1, "311 | " .. name ,{ 238, 230, 0 } , msg, sourceCoords, 'dispatch')
end)


-- end of the code :)
-- made by Karma Developments <3