Config = {}
Config.Debug = false -- Set to true to enable debug mode

Config.Logs = {}
Config.Logs.Enabled = false
-- Use code "LBLOGS" for 20% off the https://fivemanage.com/ Logs Pro plan.
Config.Logs.Service = "discord" -- fivemanage, discord or ox_lib. if discord, set your webhook in server/apiKeys.lua
Config.Logs.Avatar = false -- attempt to get the player's avatar for discord logging?
Config.Logs.Dataset = "default" -- fivemanage dataset
Config.Logs.Actions = {
    Calls = true,
    Messages = true,
    InstaPic = true,
    Birdy = true,
    YellowPages = true,
    Marketplace = true,
    Mail = true,
    Wallet = true,
    DarkChat = true,
    Services = true,
    Crypto = true,
    Trendy = true,
    Uploads = true
}

Config.DatabaseChecker = {}
Config.DatabaseChecker.Enabled = true -- if true, the phone will check the database for any issues and fix them if possible
Config.DatabaseChecker.AutoFix = true

--[[ FRAMEWORK OPTIONS ]] --
Config.Framework = "auto"
--[[
    Supported frameworks:
        * auto: auto-detect framework
        * esx: es_extended - https://github.com/esx-framework/esx-legacy
        * qb: qb-core - https://github.com/qbcore-framework/qb-core
        * qbox: qbx_core - https://github.com/Qbox-project/qbx_core
        * ox: ox_core - https://github.com/overextended/ox_core
        * vrp2: vrp 2.0 (ONLY THE OFFICIAL vRP 2.0, NOT CUSTOM VERSIONS)
        * standalone: no framework. note that framework specific apps will not work unless you implement the functions
]]
Config.CustomFramework = false -- if set to true and you use standalone, you will be able to use framework specific apps
Config.QBMailEvent = false -- if you want this script to listen for qb email events, enable this.
Config.QBOldJobMethod = false -- use the old method to check job in qb-core? this is slower, and only needed if you use an outdated version of qb-core.

Config.Item = {}
-- If you want to set up multiple items & frame colours, see https://docs.lbscripts.com/phone/configuration/#multiple-items--colored-phones
Config.Item.Require = false -- require a phone item to use the phone
Config.Item.Name = "phone" -- name of the phone item
-- Config.Item.Names = {
--     {
--         name = "phone",
--         model = `lb_phone_prop`,
--         textureVariation = 0,
--         rotation = vector3(0.0, 0.0, 180.0),
--         offset = vector3(0.0, -0.005, 0.0)
--     },
--     {
--         name = "phone_green",
--         model = `prop_phone_cs_frank`,
--         frameColor = "#3cff00",
--         textureVariation = 0,
--         rotation = vector3(0.0, 0.0, 0.0),
--         offset = vector3(0.0, -0.005, 0.0)
--     },
--     {
--         name = "phone_orange",
--         model = `prop_phone_cs_frank`,
--         frameColor = "#ffa142",
--         textureVariation = 2,
--         rotation = vector3(0.0, 0.0, 0.0),
--         offset = vector3(0.0, -0.005, 0.0)
--     }
-- }

Config.Item.Unique = false -- should each phone be unique? https://docs.lbscripts.com/phone/configuration/#unique-phones
Config.Item.Inventory = "auto" --[[
    The inventory you use, IGNORE IF YOU HAVE Config.Item.Unique DISABLED.
    Supported:
        * auto: auto-detect inventory (ONLY WORKS WITH THE ONE LISTED BELOW)
        * ox_inventory - https://github.com/overextended/ox_inventory
        * qb-inventory - https://github.com/qbcore-framework/qb-inventory
        * lj-inventory - https://github.com/loljoshie/lj-inventory
        * core_inventory - https://www.c8re.store/package/5121548
        * mf-inventory - https://modit.store/products/mf-inventory?variant=39985142268087
        * qs-inventory - https://buy.quasar-store.com/package/4770732
        * codem-inventory - https://codem.tebex.io/package/5900973
]]

Config.ServerSideSpawn = false -- should entities be spawned on the server? (phone prop, vehicles)

Config.PhoneModel = `lb_phone_prop` -- the prop of the phone, if you want to use a custom phone model, you can change this here
Config.PhoneRotation = vector3(0.0, 0.0, 180.0) -- the rotation of the phone when attached to a player
Config.PhoneOffset = vector3(0.0, -0.005, 0.0) -- the offset of the phone when attached to a player

Config.DisableOpenNUI = true -- disable the phone from opening if another script has NUI focus?

Config.DynamicIsland = true -- if enabled, the phone will have a Iphone 14 Pro inspired Dynamic Island.
Config.SetupScreen = true -- if enabled, the phone will have a setup screen when the player first uses the phone.

Config.AutoDisableSparkAccounts = true -- automatically disable inactive spark accounts? This can be set to the amount of days the account needs to be inactive to disable it, or true to disable after 7 days.
Config.AutoDeleteNotifications = true -- notifications that are more than X hours old, will be deleted. set to false to disable. if set to true, it will delete 1 week old notifications.
Config.MaxNotifications = 50 -- the maximum amount of notifications a player can have. if they have more than this, the oldest notifications will be deleted. set to false to disable
Config.DisabledNotifications = { -- an array of apps that should not send notifications, note that you should use the app identifier, found in config.json
    -- "DarkChat",
}

--[[
    Here you can whitelist/blacklist apps for certain jobs. There are two formats:

    an array of jobs that are allowed/blacklisted
    e.g.: { "police", "ambulance" }

    a key-value pair of jobs that are allowed/blacklisted, where the key is the job name and the value is the minimum grade required to access the app
    e.g.: { ["police"] = 1, ["ambulance"] = 1 }

    The key is the app identifier. The default app identifiers can be found in config/config.json. For custom apps, ask the creator of the app.
--]]

Config.WhitelistApps = {
    -- ["Weather"] = { "police", "ambulance" }
}

Config.BlacklistApps = {
    -- ["Maps"] = { "police" }
}

Config.ChangePassword = {
    ["Trendy"] = true,
    ["InstaPic"] = true,
    ["Birdy"] = true,
    ["DarkChat"] = true,
    ["Mail"] = true,
}

Config.DeleteAccount = {
    ["Trendy"] = false,
    ["InstaPic"] = false,
    ["Birdy"] = false,
    ["DarkChat"] = false,
    ["Mail"] = false,
    ["Spark"] = false,
}

Config.Companies = {}
Config.Companies.Enabled = true -- allow players to call companies?
Config.Companies.MessageOffline = true -- if true, players can message companies even if no one in the company is online
Config.Companies.DefaultCallsDisabled = false -- should receiving company calls be disabled by default?
Config.Companies.AllowAnonymous = false -- allow players to call companies with "hide caller id" enabled?
Config.Companies.SeeEmployees = "everyone" -- who should be able to see employees? they will see name, online status & phone number. options are: "everyone", "employees" or "none"
Config.Companies.DeleteConversations = true -- allow employees to delete conversations?
Config.Companies.AllowNoService = false -- allow players to call & message companies even if they have no phone service (reception)?
Config.Companies.Services = {
    {
        job = "police",
        name = "Police",
        icon = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png",
        canCall = true, -- if true, players can call the company
        canMessage = true, -- if true, players can message the company
        bossRanks = { "boss" }, -- ranks that can manage the company
        location = {
            name = "Mission Row",
            coords = {
                x = 428.9,
                y = -984.5,
            }
        }
        -- customIcon = "IoShield", -- if you want to use a custom icon for the company, set it here: https://react-icons.github.io/react-icons/icons?name=io5
        -- onCustomIconClick = function()
        --    print("Clicked")
        -- end
    },
    {
        job = "ambulance",
        name = "Ambulance",
        icon = "https://cdn-icons-png.flaticon.com/128/1032/1032989.png",
        canCall = true, -- if true, players can call the company
        canMessage = true, -- if true, players can message the company
        bossRanks = {"boss", "doctor"}, -- ranks that can manage the company
        location = {
            name = "Pillbox",
            coords = {
                x = 304.2,
                y = -587.0
            }
        }
    },
    {
        job = "mechanic",
        name = "Mechanic",
        icon = "https://cdn-icons-png.flaticon.com/128/10281/10281554.png",
        canCall = true, -- if true, players can call the company
        canMessage = true, -- if true, players can message the company
        bossRanks = {"boss", "worker"}, -- ranks that can manage the company
        location = {
            name = "LS Customs",
            coords = {
                x = -336.6,
                y = -134.3
            }
        }
    },
    {
        job = "taxi",
        name = "Taxi",
        icon = "https://cdn-icons-png.flaticon.com/128/433/433449.png",
        canCall = true, -- if true, players can call the company
        canMessage = true, -- if true, players can message the company
        bossRanks = {"boss", "driver"}, -- ranks that can manage the company
        location = {
            name = "Taxi HQ",
            coords = {
                x =984.2,
                y = -219.0
            }
        }
    },
}

Config.Companies.Contacts = { -- not needed if you use the services app, this will add the contact to the contacts app
    -- ["police"] = {
    --     name = "Police",
    --     photo = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png"
    -- },
}

Config.Companies.Management = {
    Enabled = true, -- if true, employees & the boss can manage the company

    Duty = true, -- if true, employees can go on/off duty
    -- Boss actions
    Deposit = true, -- if true, the boss can deposit money into the company
    Withdraw = true, -- if true, the boss can withdraw money from the company
    Hire = true, -- if true, the boss can hire employees
    Fire = true, -- if true, the boss can fire employees
    Promote = true, -- if true, the boss can promote employees
}

Config.CustomApps = {} -- https://docs.lbscripts.com/phone/custom-apps/

Config.Valet = {}
Config.Valet.Enabled = true -- allow players to get their vehicles from the phone
Config.Valet.VehicleTypes = { "car", "vehicle" }
Config.Valet.Price = 100 -- price to get your vehicle
Config.Valet.Model = `S_M_Y_XMech_01`
Config.Valet.Drive = true -- should a ped bring the car, or should it just spawn in front of the player?
Config.Valet.DisableDamages = false -- disable vehicle damages (engine & body health) on esx
Config.Valet.FixTakeOut = false -- repair the vehicle after taking it out?

Config.HouseScript = "auto" --[[
    The housing script you use on your server
    Supported:
        * loaf_housing - https://store.loaf-scripts.com/package/4310850
        * qb-houses - https://github.com/qbcore-framework/qb-houses
        * qs-housing - https://buy.quasar-store.com/package/5677308
]]

--[[ VOICE OPTIONS ]] --
Config.Voice = {}
Config.Voice.CallEffects = false -- enable call effects while on speaker mode? (NOTE: This may create sound-issues if you have too many submixes registered in your server)
Config.Voice.System = "auto"
--[[
    Supported voice systems:
        * pma: pma-voice - HIGHLY RECOMMENDED
        * mumble: mumble-voip - Not recommended, update to pma-voice
        * salty: saltychat - Not recommended, change to pma-voice
        * toko: tokovoip - Not recommended, change to pma-voice
]]

Config.Voice.HearNearby = true --[[
    Only works with pma-voice

    If true, players will be heard on instapic live if they are nearby
    If false, only the person who is live will be heard

    If true, allow nearby players to listen to phone calls if speaker is enabled
    If false, only the people in the call will be able to hear each other

    This feature is a work in progress and may not work as intended. It may have an impact on performance.
]]

Config.Voice.RecordNearby = true -- Should video recordings include nearby players?
Config.Voice.WaitUntilNotTalking = false -- Wait until the player is not talking before recording audio? This potentially fixes bugs with PTT getting stuck.

--[[ PHONE OPTIONS ]] --
Config.CellTowers = {}
Config.CellTowers.Enabled = true
Config.CellTowers.Debug = false -- show the cell towers on the map?
Config.CellTowers.MinService = 0 -- you will always have at least this many bars
Config.CellTowers.Range = {
    [4] = 250.0, -- You have to be within 250 meters of a cell tower to get 4 bars
    [3] = 500.0,
    [2] = 750.0,
    [1] = 1500.0,
}

Config.Locations = { -- Locations that'll appear in the maps app.
    {
        position = vector2(428.9, -984.5),
        name = "LSPD",
        description = "Los Santos Police Department",
        icon = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png",
    },
    {
        position = vector2(304.2, -587.0),
        name = "Pillbox",
        description = "Pillbox Medical Hospital",
        icon = "https://cdn-icons-png.flaticon.com/128/1032/1032989.png",
    },
}

Config.Locales = { -- If your desired language isn't here, you may contribute at https://github.com/lbphone/lb-phone-locales
    {
        locale = "en",
        name = "English"
    },
    {
        locale = "de",
        name = "Deutsch"
    },
    {
        locale = "fr",
        name = "Français"
    },
    {
        locale = "es",
        name = "Español"
    },
    {
        locale = "nl",
        name = "Nederlands"
    },
    {
        locale = "dk",
        name = "Dansk"
    },
    {
        locale = "no",
        name = "Norsk"
    },
    {
        locale = "th",
        name = "ไทย"
    },
    {
        locale = "ar",
        name = "عربي"
    },
    {
        locale = "ru",
        name = "Русский"
    },
    {
        locale = "cs",
        name = "Czech"
    },
    {
        locale = "sv",
        name = "Svenska"
    },
    {
        locale = "pl",
        name = "Polski"
    },
    {
        locale = "hu",
        name = "Magyar"
    },
    {
        locale = "tr",
        name = "Türkçe"
    },
    {
        locale = "pt-br",
        name = "Português (Brasil)"
    },
    {
        locale = "pt-pt",
        name = "Português"
    },
    {
        locale = "it",
        name = "Italiano"
    },
    {
        locale = "ua",
        name = "Українська"
    },
    {
        locale = "ba",
        name = "Bosanski"
    },
    {
        locale = "zh-cn",
        name = "简体中文 (Chinese Simplified)"
    },
    {
        locale = "ro",
        name = "Romana"
    },
    {
        locale = "ja",
        name = "日本語",
    },
}

Config.DefaultLocale = "en"
Config.DateLocale = "en-US" -- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat/DateTimeFormat
Config.DateFormat = "auto" -- auto: use the date format from the locale, or set a custom format (e.g. "DDDD, MMMM DD")

Config.FrameColor = "#39334d" -- This is the color of the phone frame. Default (#39334d) is SILVER.
Config.AllowFrameColorChange = true -- Allow players to change the color of their phone frame?

Config.PhoneNumber = {}
Config.PhoneNumber.Format = "({3}) {3}-{4}" -- Don't touch unless you know what you're doing. IMPORTANT: The sum of the numbers needs to be equal to the phone number length + prefix length
Config.PhoneNumber.Length = 7 -- This is the length of the phone number WITHOUT the prefix.
Config.PhoneNumber.Prefixes = { -- These are the first numbers of the phone number, usually the area code. They all need to be the same length
    "205",
    "907",
    "480",
    "520",
    "602"
}

Config.Battery = {} -- WITH THESE SETTINGS, A FULL CHARGE WILL LAST AROUND 2 HOURS.
Config.Battery.Enabled = false -- Enable battery on the phone, you'll need to use the exports to charge it.
Config.Battery.ChargeInterval = { 5, 10 } -- How much battery
Config.Battery.DischargeInterval = { 50, 60 } -- How many seconds for each percent to be removed from the battery
Config.Battery.DischargeWhenInactiveInterval = { 80, 120 } -- How many seconds for each percent to be removed from the battery when the phone is inactive
Config.Battery.DischargeWhenInactive = true -- Should the phone remove battery when the phone is closed?

Config.CurrencyFormat = "$%s" -- ($100) Choose the formatting of the currency. %s will be replaced with the amount.
Config.MaxTransferAmount = 1000000 -- The maximum amount of money that can be transferred at once via wallet / messages.
Config.TransferOffline = true -- Allow players to transfer money to offline players via the wallet app?

Config.TransferLimits = {}
Config.TransferLimits.Daily = false -- The maximum amount of money that can be transferred in a day. Set to false for unlimited.
Config.TransferLimits.Weekly = false -- The maximum amount of money that can be transferred in a week. Set to false for unlimited.

Config.EnableMessagePay = true -- Allow players to pay other players via messages?
Config.EnableVoiceMessages = true -- Allow players to send voice messages?
Config.EnableGIFs = true

Config.CityName = "Los Santos" -- The name that's being used in the weather app etc.
Config.RealTime = true -- if true, the time will use real life time depending on where the user lives, if false, the time will be the ingame time.
Config.CustomTime = false -- NOTE: disable Config.RealTime if using this. you can set this to a function that returns custom time, as a table: { hour = 0-24, minute = 0-60 }

Config.EmailDomain = "lbscripts.com"
Config.AutoCreateEmail = false -- should the phone automatically create an email for the player when they set up the phone?
Config.DeleteMail = true -- allow players to delete mails in the mail app?
Config.ConvertMailToMarkdown = false -- convert mails from html to markdown?

Config.DeleteMessages = true -- allow players to delete messages in the messages app?

Config.SyncFlash = true -- should flashlights be synced across all players? May have an impact on performance
Config.EndLiveClose = false -- should InstaPic live end when you close the phone?

Config.AllowExternal = { -- allow people to upload external images? (note: this means they can upload nsfw / gore etc)
    Gallery = false, -- allow importing external links to the gallery?
    Birdy = false, -- set to true to enable external images on that specific app, set to false to disable it.
    InstaPic = false,
    Spark = false,
    Trendy = false,
    Pages = false,
    MarketPlace = false,
    Mail = false,
    Messages = false,
    Other = false, -- other apps that don't have a specific setting (ex: setting a profile picture for a contact, backgrounds for the phone etc)
}

-- Blacklisted domains for external images. You will not be able to upload from these domains.
Config.ExternalBlacklistedDomains = {
    "imgur.com",
    "discord.com",
    "discordapp.com",
}

-- Whitelisted domains for external images. If this is not empty/nil/false, you will only be able to upload images from these domains.
Config.ExternalWhitelistedDomains = {
    -- "fivemanage.com"
}

-- Set to false/empty to disable
Config.UploadWhitelistedDomains = { -- domains that are allowed to upload images to the phone (prevent using devtools to upload images)
    "fivemanage.com",
    "fmfile.com",
    "cfx.re" -- lb-upload
}

Config.WordBlacklist = {}
Config.WordBlacklist.Enabled = false
Config.WordBlacklist.Apps = { -- apps that should use the word blacklist (if Config.WordBlacklist.Enabled is true)
    Birdy = true,
    InstaPic = true,
    Trendy = true,
    Spark = true,
    Messages = true,
    Pages = true,
    MarketPlace = true,
    DarkChat = true,
    Mail = true,
    Other = true,
}
Config.WordBlacklist.Words = {
    -- array of blacklisted words, e.g. "badword", "anotherbadword"
}

Config.AutoFollow = {}
Config.AutoFollow.Enabled = false

Config.AutoFollow.Birdy = {}
Config.AutoFollow.Birdy.Enabled = true
Config.AutoFollow.Birdy.Accounts = {} -- array of usernames to automatically follow when creating an account. e.g. "username", "anotherusername"

Config.AutoFollow.InstaPic = {}
Config.AutoFollow.InstaPic.Enabled = true
Config.AutoFollow.InstaPic.Accounts = {} -- array of usernames to automatically follow when creating an account. e.g. "username", "anotherusername"

Config.AutoFollow.Trendy = {}
Config.AutoFollow.Trendy.Enabled = true
Config.AutoFollow.Trendy.Accounts = {} -- array of usernames to automatically follow when creating an account. e.g. "username", "anotherusername"

Config.AutoBackup = true -- should the phone automatically create a backup when you get a new phone?

Config.Post = {} -- What apps should send posts to discord? You can set your webhooks in server/webhooks.lua
Config.Post.Birdy = true -- Announce new posts on Birdy?
Config.Post.InstaPic = true -- Anmnounce new posts on InstaPic?
Config.Post.Accounts = {
    Birdy = {
        Username = "Birdy",
        Avatar = "https://loaf-scripts.com/fivem/lb-phone/icons/Birdy.png"
    },
    InstaPic = {
        Username = "InstaPic",
        Avatar = "https://loaf-scripts.com/fivem/lb-phone/icons/InstaPic.png"
    }
}

Config.BirdyTrending = {}
Config.BirdyTrending.Enabled = true -- show trending hashtags?
Config.BirdyTrending.Reset = 7 * 24 -- How often should trending hashtags be reset on birdy? (in hours)

Config.BirdyNotifications = false -- should everyone get a notification when someone posts? (if set to false, only followers will get a notification)
Config.InstaPicLiveNotifications = false -- should everyone get a notification when someone goes live on InstaPic? (if set to false, only followers will get a notification)

Config.PromoteBirdy = {}
Config.PromoteBirdy.Enabled = true -- should you be able to promote post?
Config.PromoteBirdy.Cost = 2500 -- how much does it cost to promote a post?
Config.PromoteBirdy.Views = 100 -- how many views does a promoted post get?

Config.UsernameFilter = {
    Regex = "[a-zA-Z0-9]+", -- This regex is used to clean up usernames in mentions & account creation
    LuaPattern = "^[%w]+$", -- This pattern is used to ensure the username doesn't contain any special characters when creating an account
}

Config.TrendyTTS = {
    {"English (US) - Female", "en_us_001"},
    {"English (US) - Male 1", "en_us_006"},
    {"English (US) - Male 2", "en_us_007"},
    {"English (US) - Male 3", "en_us_009"},
    {"English (US) - Male 4", "en_us_010"},

    {"English (UK) - Male 1", "en_uk_001"},
    {"English (UK) - Male 2", "en_uk_003"},

    {"English (AU) - Female", "en_au_001"},
    {"English (AU) - Male", "en_au_002"},

    {"French - Male 1", "fr_001"},
    {"French - Male 2", "fr_002"},

    {"German - Female", "de_001"},
    {"German - Male", "de_002"},

    {"Spanish - Male", "es_002"},

    {"Spanish (MX) - Male", "es_mx_002"},

    {"Portuguese (BR) - Female 2", "br_003"},
    {"Portuguese (BR) - Female 3", "br_004"},
    {"Portuguese (BR) - Male", "br_005"},

    {"Indonesian - Female", "id_001"},

    {"Japanese - Female 1", "jp_001"},
    {"Japanese - Female 2", "jp_003"},
    {"Japanese - Female 3", "jp_005"},
    {"Japanese - Male", "jp_006"},

    {"Korean - Male 1", "kr_002"},
    {"Korean - Male 2", "kr_004"},
    {"Korean - Female", "kr_003"},

    {"Ghostface (Scream)", "en_us_ghostface"},
    {"Chewbacca (Star Wars)", "en_us_chewbacca"},
    {"C3PO (Star Wars)", "en_us_c3po"},
    {"Stitch (Lilo & Stitch)", "en_us_stitch"},
    {"Stormtrooper (Star Wars)", "en_us_stormtrooper"},
    {"Rocket (Guardians of the Galaxy)", "en_us_rocket"},

    {"Singing - Alto", "en_female_f08_salut_damour"},
    {"Singing - Tenor", "en_male_m03_lobby"},
    {"Singing - Sunshine Soon", "en_male_m03_sunshine_soon"},
    {"Singing - Warmy Breeze", "en_female_f08_warmy_breeze"},
    {"Singing - Glorious", "en_female_ht_f08_glorious"},
    {"Singing - It Goes Up", "en_male_sing_funny_it_goes_up"},
    {"Singing - Chipmunk", "en_male_m2_xhxs_m03_silly"},
    {"Singing - Dramatic", "en_female_ht_f08_wonderful_world"}
}

-- You can customize the function in lb-phone/server/custom/functions/webrtc.lua
-- You can set your api key in lb-phone/server/apiKeys.lua
Config.DynamicWebRTC = {}
Config.DynamicWebRTC.Enabled = false -- enable dynamic WebRTC? (this will allow you to generate new WebRTC credentials for each user)
Config.DynamicWebRTC.Service = "cloudflare" -- supported by default: cloudflare
Config.DynamicWebRTC.RemoveStun = false -- remove the stun servers?

-- ICE Servers for WebRTC (ig live, live video). If you don't know what you're doing, leave this as it is.
-- see https://developer.mozilla.org/en-US/docs/Web/API/RTCPeerConnection/RTCPeerConnection
-- Config.RTCConfig = {
--     iceServers = {
--         { urls = "stun:stun.l.google.com:19302" },
--     }
-- }

Config.Crypto = {}
Config.Crypto.Enabled = true
Config.Crypto.Coins = {"bitcoin","ethereum","tether","binancecoin","usd-coin","ripple","binance-usd","cardano","dogecoin","solana","shiba-inu","polkadot","litecoin","bitcoin-cash"}
Config.Crypto.Currency = "usd" -- currency to use for crypto prices. https://api.coingecko.com/api/v3/simple/supported_vs_currencies
Config.Crypto.Refresh = 5 * 60 * 1000 -- how often should the crypto prices be refreshed (client cache)? (Default 5 minutes)
Config.Crypto.QBit = true -- support QBit? (requires qb-crypto & qb-core)
Config.Crypto.Limits = {}
Config.Crypto.Limits.Buy = 1000000 -- how much ($) you can buy for at once
Config.Crypto.Limits.Sell = 1000000 -- how much ($) you can sell at once

Config.KeyBinds = {
    -- Find keybinds here: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
    Open = { -- toggle the phone
        Command = "phone",
        Bind = "F1",
        Description = "Open your phone"
    },
    Focus = { -- keybind to toggle the mouse cursor.
        Command = "togglePhoneFocus",
        Bind = "LMENU",
        Description = "Toggle cursor on your phone"
    },
    StopSounds = { -- in case the sound would bug out, you can use this command to stop all sounds.
        Command = "stopSounds",
        Bind = false,
        Description = "Stop all phone sounds"
    },

    FlipCamera = {
        Command = "flipCam",
        Bind = "UP",
        Description = "Flip phone camera"
    },
    TakePhoto = {
        Command = "takePhoto",
        Bind = "RETURN",
        Description = "Take a photo / video"
    },
    ToggleFlash = {
        Command = "toggleCameraFlash",
        Bind = "E",
        Description = "Toggle flash"
    },
    LeftMode = {
        Command = "leftMode",
        Bind = "LEFT",
        Description = "Change mode"
    },
    RightMode = {
        Command = "rightMode",
        Bind = "RIGHT",
        Description = "Change mode"
    },
    RollLeft = {
        Command = "cameraRollLeft",
        Bind = "Z",
        Description = "Roll camera to the left"
    },
    RollRight = {
        Command = "cameraRollRight",
        Bind = "C",
        Description = "Roll camera to the right"
    },
    FreezeCamera = {
        Command = "cameraFreeze",
        Bind = "X",
        Description = "Freeze camera"
    },

    AnswerCall = {
        Command = "answerCall",
        Bind = "RETURN",
        Description = "Answer incoming call"
    },
    DeclineCall = {
        Command = "declineCall",
        Bind = "BACK",
        Description = "Decline incoming call"
    },
    UnlockPhone = {
        Bind = "SPACE",
        Description = "Open your phone",
    },
}

Config.KeepInput = true -- keep input when nui is focused (meaning you can walk around etc)
Config.DisableFocusTalking = false -- disable the focus key (default ALT) when talking in-game? Potentially fixes issues with PTT getting stuck (open mic)

--[[ PHOTO / VIDEO OPTIONS ]] --
Config.Camera = {}
Config.Camera.ShowTip = true -- show a tip in the top-left of key binds for the camera?
Config.Camera.Enabled = true -- use a custom camera that allows you to walk around while taking photos?
Config.Camera.Roll = true -- allow rolling the camera to the left & right?
Config.Camera.AllowRunning = true
Config.Camera.MaxFOV = 70.0 -- higher = zoomed out
Config.Camera.DefaultFOV = 60.0
Config.Camera.MinFOV = 10.0 -- lower = zoomed in
Config.Camera.MaxLookUp = 80.0
Config.Camera.MaxLookDown = -80.0

Config.Camera.Vehicle = {}
Config.Camera.Vehicle.Zoom = true -- allow zooming in vehicles?
Config.Camera.Vehicle.MaxFOV = 80.0
Config.Camera.Vehicle.DefaultFOV = 60.0
Config.Camera.Vehicle.MinFOV = 10.0
Config.Camera.Vehicle.MaxLookUp = 50.0
Config.Camera.Vehicle.MaxLookDown = -30.0
Config.Camera.Vehicle.MaxLeftRight = 120.0
Config.Camera.Vehicle.MinLeftRight = -120.0

Config.Camera.Selfie = {}
Config.Camera.Selfie.Offset = vector3(0.05, 0.55, 0.6)
Config.Camera.Selfie.Rotation = vector3(10.0, 0.0, -180.0)
Config.Camera.Selfie.MaxFov = 90.0
Config.Camera.Selfie.DefaultFov = 60.0
Config.Camera.Selfie.MinFov = 50.0

Config.Camera.Freeze = {}
Config.Camera.Freeze.Enabled = false -- allow players to freeze the camera when taking photos? (this will make it so they can take photos in 3rd person)
Config.Camera.Freeze.MaxDistance = 10.0 -- max distance the camera can be from the player when frozen
Config.Camera.Freeze.MaxTime = 60 -- max time the camera can be frozen for (in seconds)

-- Set your api keys in lb-phone/server/apiKeys.lua
Config.UploadMethod = {}
-- You can edit the upload methods in lb-phone/shared/upload.lua
-- We recommend Fivemanage, https://fivemanage.com
-- Use code LBPHONE10 for 10% off on Fivemanage
-- A video tutorial for how to set up Fivemanage can be found here: https://www.youtube.com/watch?v=y3bCaHS6Moc
-- If you want to host uploads yourself, you can use LBUpload: https://github.com/lbphone/lb-upload
Config.UploadMethod.Video = "Fivemanage" -- "Fivemanage" or "LBUpload" or "Custom"
Config.UploadMethod.Image = "Fivemanage" -- "Fivemanage" or "LBUpload" or "Custom
Config.UploadMethod.Audio = "Fivemanage" -- "Fivemanage" or "LBUpload" or "Custom"

Config.Video = {}
Config.Video.Bitrate = 400 -- video bitrate (kbps), increase to improve quality, at the cost of file size
Config.Video.FrameRate = 24 -- video framerate (fps), 24 fps is a good mix between quality and file size used in most movies
Config.Video.MaxSize = 25 -- max video size (MB)
Config.Video.MaxDuration = 60 -- max video duration (seconds)

Config.Image = {}
Config.Image.Mime = "image/webp" -- image mime type, "image/webp" or "image/png" or "image/jpg"
Config.Image.Quality = 0.95
