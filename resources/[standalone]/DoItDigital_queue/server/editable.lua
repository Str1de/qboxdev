function hasCommandAcess(src,command)
    if src == 0 and EnableConsoleCommands then
        return true
    end
    if DoesPlayerExist(src) then 
        identifier = GetPlayerIdentifierByType(src, 'steam')
        if WhoCanUseCommands[identifier] then
            if WhoCanUseCommands[identifier][command] then
                return true,identifier
            end
        end
    end
    return false
end

RegisterCommand('getMyPriority', function(source, args, rawCommand)
    local type,expireDate = getPlayerPriority(source)
    print("Your Priority Type: " .. type .. " Expire Date: " .. expireDate)
    --Add your own logic here to send the message to the player
end)