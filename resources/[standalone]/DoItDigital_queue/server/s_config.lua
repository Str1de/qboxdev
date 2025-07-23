--Display Random Messages When Player Waiting In Queue
--You Can Add More Messages By Adding More Lines
serverTexts = {
    "\n\n✅Fun Fact: This server is so popular, even NPCs are trying to join the queue!",
    "\n\n❗️INFO: You can buy a linecutter from the store to skip the queue!",
    "\n\n💡TIP: Drone deliveries. Watch the skies and keep an eye out for opportunistic thieves swooping in on your package. Protect your loot or lose it!",
    "\n\n❗️INFO: Players With Linecutter Have Also Priority In The Queue",
    "\n\n💡TIP: Post Your Ingame Images On Our Discord Server And Watch Featured On Our Social Media",
    "\n\n💡TIP: Free Small Fishes Back In The Water To Gain FisherMan Reputation",
    "\n\n💡TIP: Reputation matters. Helping others or completing jobs with finesse will open more doors for you.",
    "\n\n✅Did You Know? Collect rare items hidden across the city and trade them for exclusive rewards!",
    "\n\n❗️INFO: The city never sleeps—jobs, missions, and opportunities are waiting for you 24/7.",
    "\n\n✅Did You Know? Weather affects driving conditions—rainy nights make the streets extra slick.",
}


--IdentifiersToUse = "steam" or "license" or "discord"
IdentifiersToUse = "steam"

--Time Message To Display When Player Waiting In Queue
timeInQueueMsg = "\n\n\n\n🕒You have been waiting in the queue for "

--Priority Levels For Queue , Set To 1 For Highest Priority, The Lower The Number The Higher The Priority
Priority = {god = 1, gold = 2, silver = 3, bronze = 4}

--Queue Skip List, Set To True To Skip Queue (Player Will Join Instantly Without Waiting In Queue Eveen Server Is Full For Example 102/100 etc)
--Can Be Used As Line Cutter For Donators Or VIPs
SkipQueue = {
    ["god"] = true,
    ["gold"] = false,
    ["silver"] = false,
    ["bronze"] = false
}


--GraceTimer In Seconds (Grace Timer Starts When Player Disconnects So He Can Re - Join) Use 0 To Disable Grace
GraceTimer = 90 

--[[
Grace Modes
     "pushToTop": When a grace player rejoins, they will be pushed to the front of the queue.
     "skipQueue": When a grace player rejoins, they will skip the queue and join instantly.
     "priority": When a grace player rejoins, they will be placed in the queue based on configurable priority level.
]]


GraceMode = "skipQueue"
GraceModeTimer = 900 --Grace Mode Timer In Seconds (Only Used When GraceMode = "priority" or "pushToTop" is the time the grace player will be pushed to the top of the queue or given priority in the queue) 


--Grace Priority Level (Only Used When GraceMode = "priority")
GracePriority = "god"

--[[
ReserveGraceSlot (Only Used When GraceMode = "skipQueue")

When ReserveGraceSlot = true:
    The server will reserve a slot for a grace player until:
        -The grace player rejoins, or
        -The grace timer expires.
    This means the server will have one less slot available for normal players. For example:
    If the server has 100 slots, and 1 slot is reserved for a grace player, only 99 slots will be available for normal players.
    If the server is full (99/100), new players will be placed in a queue.

When ReserveGraceSlot = false:
    If the server has 100 slots and is already full (100/100), the grace player can still join, resulting in 101/100 players for a sort time.
]]
ReserveGraceSlot = true 

--Lock Server For Priority Players Only For X Minutes After Server Restart (Set To 0 To Disable)
LockServerForPriority = 0 

--Display Queue In Project Name (Example :  Project Name ⌠10⌡)
DisplayQueueInProjectName = true 

--Users Who Have Access To Script Commands (q_openmenu to open ui)
WhoCanUseCommands = {
    ["steam:110000143e4069a"]  = 
    {
        ["openUI"] = true, --Open UI
        ["skipQueue"] = true, --Skip Queue
        ["pushQueue"] = true, -- Push To Top
        ["kickQueue"] = true, --kick from queue
        ["addPriority"] = true, --Add Priority
        ["removePriority"] = true, --Remove Priority
        ["changeSlots"] = true, --changes slots
    },
}

EnableDiscordRoles = false --Enable Discord Roles [can work at the same time both discord role priority system and identifiers priority system]
s_DiscordToken = "" --Discord Bot Token (Required If EnableDiscordRoles Is True)
s_GuildID = "" --Discord Guild ID (Required If EnableDiscordRoles Is True)
--Roles Mapping , set priority level to specific role ID , every user with that role will have that priority level
s_DiscordRoles = {
    ["1349692749019877421"] = "god", -- Replace with actual role ID for god priority
    ["234567890123456789"] = "gold", -- Replace with actual role ID for gold priority
    ["345678901234567890"] = "silver", -- Replace with actual role ID for silver priority
    ["456789012345678901"] = "bronze", -- Replace with actual role ID for bronze priority
}



--Enable Console Commands For Queue Management , Setting This To True Will Allow You To Manage Queue Using Console Commands
EnableConsoleCommands = true 
--Delete Expired Priority Records From Database (Set To False If You Want To Keep Expired Priority In Database They Wont Have Any Effect)
DeleteExpiredPriorityFromDB = true 
--Discord Webhook For Logging
DiscordHook = { 
    ['addpriority'] = '', -- webhook for addpriority logging
    ['removepriority'] = '', -- webhook for removepriority logging
    ['skipqueue'] = '', -- webhook for skipqueue logging
    ['kickqueue'] = '', -- webhook for kickqueue logging
    ['pushqueue'] = '', -- webhook for pushqueue logging
    ['changeslots'] = '', -- webhook for changeslots logging
    ['enterwithGrace'] = '', -- webhook for enterwithGrace logging
}






