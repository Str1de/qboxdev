local status = require('config').property?.houses or false

-- House system configurations
local HOUSE_SYSTEMS = {
    ['bcs_housing'] = {
        queryType = 'export',
        exportFunction = function(citizenid)
            return exports.bcs_housing:GetOwnedHomeKeys(citizenid)
        end,
        debug = 'bcs_housing for house'
    },
    ['nolag_properties'] = {
        queryType = 'export',
        exportFunction = function(citizenid)
            return exports.nolag_properties:GetAllProperties(citizenid, 'user', true)
        end,
        debug = 'nolag_properties for house'
    },
    ['ps-housing'] = {
        queryType = 'sql',
        query = 'SELECT * FROM properties WHERE owner_citizenid = ? AND apartment IS NULL',
        debug = 'ps-housing for house'
    },
    ['qb-houses'] = {
        queryType = 'sql',
        query = 'SELECT * FROM player_houses WHERE citizenid = ?',
        debug = 'qb-house ready for house'
    },
    ['qbx_properties'] = {
        queryType = 'sql',
        query = 'SELECT id, property_name, coords FROM properties WHERE owner = ?',
        debug = 'qbx_properties for houses'
    },
    ['qs-housing'] = {
        queryType = 'sql',
        query = 'SELECT * FROM player_houses WHERE citizenid = ?',
        debug = 'qs ready for house'
    }
}

-- Find active house system
local activeSystem = nil

for resource, config in pairs(HOUSE_SYSTEMS) do
    if GetResourceState(resource) == 'started' then
        activeSystem = {
            name = resource,
            config = config
        }
        Debug(config.debug, 'debug')
        break
    end
end

if not activeSystem or not status then
    if status then
        warn('No active house system found, but config.property.houses is true', 'warn')
    end

    lib.callback.register('getHouses', function()
        return false
    end)

    return
end

-- Universal house query executor
local function queryHouses(citizenid)
    local config = activeSystem.config

    if config.queryType == 'export' then
        return config.exportFunction(citizenid)
    elseif config.queryType == 'sql' then
        return MySQL.query.await(config.query, { citizenid })
    end

    return false
end

-- Single callback registration for all house systems
lib.callback.register('getHouses', function(source)
    local citizenid = GetCitizenID(GetPlayer(source))
    local houses = queryHouses(citizenid)
    local found = houses and houses[1] ~= nil

    Debug(found and 'Houses: Found Houses' or 'Houses: Not Found')

    return found and houses or false
end)
