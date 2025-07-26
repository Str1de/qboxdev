-- Apartment system configurations with complete SQL and validation
local APARTMENT_SYSTEMS = {
    ['bcs_housing'] = {
        queryType = 'sql',
        query = 'SELECT identifier, apartment FROM house_apartment WHERE owner = ?',
        validator = function(result) return result?.apartment and true or false end
    },
    ['ps-housing'] = {
        queryType = 'sql',
        query = 'SELECT * FROM properties WHERE owner_citizenid = ? AND apartment IS NOT NULL',
        validator = function(result) return result ~= nil end
    },
    ['nolag_properties'] = {
        queryType = 'export',
        exportFunction = function(citizenid)
            return exports.nolag_properties:GetAllProperties(citizenid, 'user', true)
        end,
        validator = function(result) return next(result) end
    },
    ['snipe-motel'] = {
        queryType = 'export',
        exportFunction = function(_, src)
            return exports["snipe-motel"]:currentPlayerRoom(src)
        end,
        validator = function(result) return result ~= false end
    },
    ['qb-apartments'] = {
        queryType = 'sql',
        query = 'SELECT * FROM apartments WHERE citizenid = ?',
        validator = function(result) return result ~= nil end
    },
    ['qbx_properties'] = {
        queryType = 'sql',
        query = 'SELECT id, property_name, coords FROM properties WHERE owner = ?',
        validator = function(result) return result ~= nil end
    },
    ['qbx_apartments'] = {
        queryType = 'sql',
        query = 'SELECT * FROM apartments WHERE citizenid = ?',
        validator = function(result) return result ~= nil end
    }
}

-- System detection and initialization
local activeSystem = nil

for resource, config in pairs(APARTMENT_SYSTEMS) do
    if GetResourceState(resource) == 'started' then
        activeSystem = {
            name = resource,
            config = config,
        }
        Debug(string.format('%s for apartments', resource), 'debug')
        break
    end
end

if not activeSystem then
    if GetConvar('um:NewPlayerApartmentInsideStart', 'false') == 'true' then
        warn('No active apartment system found, but NewPlayerApartmentInsideStart is true', 'warn')
        -- Fallback to a default system or disable apartment functionality
        SetConvarReplicated('um:NewPlayerApartmentInsideStart', 'false')
    end

    lib.callback.register('getApartments', function()
        return true
    end)

    return
end

-- Universal house query executor
local function queryApartments(citizenid, src)
    local config = activeSystem.config

    if config.queryType == 'export' then
        return config.exportFunction(citizenid, src)
    elseif config.queryType == 'sql' then
        return MySQL.single.await(config.query, { citizenid })
    end

    return false
end


-- Single callback registration for all systems
lib.callback.register('getApartments', function(source)
    local citizenid = GetCitizenID(GetPlayer(source))
    local result = queryApartments(citizenid, source)
    local found = activeSystem.config.validator(result)

    Debug(found and 'Apartments: Found Apartments' or 'Apartments: Not Found')

    return found and result or false
end)
