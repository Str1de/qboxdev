local config = {}

config.debug = false

config.lang = 'en' -- tr,en,es,zh,fr,hi [or add locales > .json]

-- For apartments start convar in server.cfg | setr um:NewPlayerApartmentInsideStart "true"
config.property = {
    houses = true,
    defaultImage = 'https://files.fivemerr.com/images/534eff8f-e6cb-473f-b441-bf0ac114e256.png', -- Default image for houses
}

config.coords = {
    ['motel'] = {
        coords = vector4(313.23, -236.72, 53.99, 68.11),
        street = 'Meteor St',
        text = 'Motel St'
    },
    ['hospital'] = {
        coords = vector4(286.42, -602.82, 43.19, 128.92),
        street = 'Elgin Ave Del Perro Fwy',
        text = 'Hospital Ave'
    },
    ['police'] = {
        coords = vector4(400.46, -979.54, 29.39, 270.35),
        street = 'Sinner St Atlee St',
        text = 'Police Station'
    },
    ['sandy'] = {
        coords = vector4(1421.33, 3601.24, 34.85, 297.93),
        street = 'Algonquin Blvd',
        text = 'Sandy Shore'
    },
    ['paleto'] = {
        coords = vector4(-131.32, 6390.86, 31.5, 34.13),
        street = 'Paleto Blvd',
        text = 'Paleto Bay'
    }
}

-- If you want to show the logo, set it to true or hidden false
config.logo = {
    status = false,
    url = 'imageurl',
}

config.main = {
    onlyLastLocation = false,        -- If you want to only last location set true.
    forceDeadPedLastLocation = true, -- If you want force injured ped last location set true.
    camera = {
        radius = 2.0,                -- Camera distance from the character
        angle = 50,                  -- Camera angle
        point = 0.1,                 -- Camera point
        turning = true,              -- If you want to turn the camera, set it to true.
        skyspawnPos = -20,           -- -100 vertical, -20 horizontal
    },
    spawn = {
        type = 'playerFromSky', -- playerFromSky (um), gtaVNative
        cutScene = false,       -- If you want to show the cutscene, set it to true.
    },
    ped = {
        status = false, -- Make it true if you want your character to see and walk the path
    },
    bookmark = {
        status = false,   -- If you want to show the bookmark system, set it to true.
        money = {
            free = false, -- If you want to bookmark the free money, set it to true.
            amount = math.random(1000, 10000) or 500
        }
    },
}

--[[
   If your hud appears in spawn menu,
   this is nonsense, remember that hud is not shown without playerLoaded or LocalPlayer loaded,
   but that's ok, that's what this function was made for
--]]
config.hud = function(bool)
    if bool then
        -- Example: exports['myhud']:SetDisplay(false)
        Debug('Hud is hidden', 'debug')
    else
        -- Example: exports['myhud']:SetDisplay(true)
        Debug('Hud is show', 'debug')
    end
end

config.weather = {
    sync = true,         -- If you want to custom weather, set it to false.
    sc = 'qb',           -- cd , qb
    type = 'EXTRASUNNY', -- https://docs.fivem.net/docs/game-references/weather-types/
    time = 23,           -- 0 - 23
}

return config
