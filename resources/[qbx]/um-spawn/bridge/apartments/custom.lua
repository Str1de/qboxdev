lib.callback.register('um-spawn:server:createNolagApartment', function(source)
    local citizenid = GetCitizenID(GetPlayer(source))
    Debug('nolag_properties createNolagApartment for ' .. citizenid, 'debug')
    local newApartment, message = exports.nolag_properties:AddStarterApartment(citizenid)
    if not newApartment then
        Debug('Failed to create Nolag Apartment: ' .. message, 'error')
        return false
    end
    Debug('Nolag Apartment created successfully for ' .. citizenid, 'info')
    return newApartment
end)
