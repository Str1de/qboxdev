var dataReceived = [];
var currentPage = "queue";
var myPerms = [];
$(function () {
    window.addEventListener('message', function (event) {
        let data = event.data;
        if (data.type === "openMenu") {
            dataReceived = data.data;
            myPerms = dataReceived.myPerms;
            updateUI(data.data);
            $("#wrap").fadeIn();
        }
        else if (data.type === "updateMenu") {
            dataReceived = data.data;
            updateUI(data.data);
        }
    });

    function updateUI(data) {
        $(".players-online").html(`<b>${data.onlinePlayers}</b> / ${data.maxSlots}<br/><span>PLAYERS ONLINE</span>`);
        $(".currently-queue span").text(`${data.queuePlayer} Players`);
        $(".priority-time-lock span").text(`${data.lockTime} Minutes`);

        let progressValue = (data.onlinePlayers / data.maxSlots) * 100;
        document.querySelector('.players-progress-bar').style.setProperty('--progress-value', progressValue);

        let playerList = $(".player-list-scrollable");
        playerList.empty();
        if (currentPage === "queue") {
            let sortedQueue = Object.values(data.qData).sort((a, b) => a.originalOrder - b.originalOrder);
            $(".total-players-priority span").text(`${data.totalpriorityplayers} Players`);
            sortedQueue.forEach(player => {
                let queuePos = data.qPos[player.identifier] || "-";
                let truncatedIdentifier = player.identifier.length > 24 ? player.identifier.substring(0, 24) + "..." : player.identifier; // Truncate identifier
                let playerHTML = `
                    <div class="player-item">
                        <div class="player-pos">${queuePos}</div>
                        <div class="player-name">${player.name}</div>
                        <div class="player-steamid">${truncatedIdentifier}</div>
                        <div class="player-priority ${player.priority}">${player.priority || "None"}</div>
                        <div class="player-actions">
                            <button class="btn-skip-queue" data-id="${player.identifier}" data-name="${player.name}"><i class="fal fa-forward"></i> Skip Queue</button>
                            <button class="btn-kick-queue" data-id="${player.identifier}" data-name="${player.name}"><i class="far fa-sign-out"></i> Kick from Queue</button>
                            <button class="btn-push-queue" data-id="${player.identifier}" data-name="${player.name}"><i class="fas fa-arrow-to-top"></i> Push To Top</button>
                        </div>
                    </div>`;
                playerList.append(playerHTML);
            });
        }
        else
        {
            let sortedPlayers = Object.entries(data.playersWithLineCutter).sort(([, a], [, b]) => a.expiresTimeStamp - b.expiresTimeStamp);
            let curpos = 1;
            sortedPlayers.forEach(([key, player]) => {
                let truncatedIdentifier = key.length > 24 ? key.substring(0, 24) + "..." : key; // Truncate identifier
            let playerHTML = `
                <div class="player-item">
                <div class="player-pos">${curpos}</div>
                <div class="player-name">${player.name}</div>
                <div class="player-steamid">${truncatedIdentifier}</div>
                <div class="player-type">${player.type}</div>
                
                <div class="player-actions">
                    <div class="player-expires">Expires: ${player.expires}</div>
                    <button class="btn-remove-priority" data-id="${key}" data-name="${player.name}"><i class="far fa-times-circle"></i> Remove Priority</button>
                </div>
                </div>`;
            curpos++;
            playerList.append(playerHTML);
            });
        }
    }



    $(".btn-confirm-slots").click(function () {
        if (myPerms["changeSlots"] !== true) {
            showPopup(`You don't have permission to change the server slots.`);
            return;
        }
        let newSlots = $(".change-slots-input").val();
        if (!newSlots || isNaN(newSlots)) return;
        $.post(`https://${GetParentResourceName()}/changeSlots`, JSON.stringify({ slots: newSlots }));
        showPopup(`You have successfully changed the Server Slots to <b>${newSlots}</b>`);
       
        $(".players-online").html(`<b>${dataReceived.onlinePlayers}</b> / ${newSlots}<br/><span>PLAYERS ONLINE</span>`);
        let progressValue = (dataReceived.onlinePlayers / newSlots) * 100;
        document.querySelector('.players-progress-bar').style.setProperty('--progress-value', progressValue);
    });

    $(".topbar-close-btn").click(function () {
        $("#wrap").fadeOut();
        $.post(`https://${GetParentResourceName()}/closeMenu`, JSON.stringify({}));
    });

    $(document).on("click", ".btn-skip-queue", function () {
        if (myPerms["skipQueue"] !== true) {
            showPopup(`You don't have permission to skip players in the queue.`);
            return;
        }
        let playerId = $(this).data("id");
        let playerName = $(this).data("name");
        $.post(`https://${GetParentResourceName()}/skipQueue`, JSON.stringify({ id: playerId }));
        showPopup(`You have skipped <b>${playerName}</b> in the queue.`);
    });

    $(document).on("click", ".btn-kick-queue", function () {
        if (myPerms["kickQueue"] !== true) {
            showPopup(`You don't have permission to kick players from the queue.`);
            return;
        }
        let playerId = $(this).data("id");
        let playerName = $(this).data("name");
        $.post(`https://${GetParentResourceName()}/kickQueue`, JSON.stringify({ id: playerId }));
        showPopup(`<b>${playerName}</b> has been removed from the queue.`);
    });
    $(document).on("click", ".btn-push-queue", function () {
        if (myPerms["pushQueue"] !== true) {
            showPopup(`You don't have permission to push players in the queue.`);
            return;
        }
        let playerId = $(this).data("id");
        let playerName = $(this).data("name");
        $.post(`https://${GetParentResourceName()}/pushQueue`, JSON.stringify({ id: playerId }));
        showPopup(`<b>${playerName}</b> has been pushed in top of the queue.`);
    });
    $(document).on("click", ".btn-remove-priority", function () {
        if (myPerms["removePriority"] !== true) {
            showPopup(`You don't have permission to remove priority from players.`);
            return;
        }
        let playerId = $(this).data("id"); 
        let playerName = $(this).data("name"); 
    
        removePriority(playerId, playerName);
    });
});


$(".search-btn").click(function () {
    let searchQuery = $(".search-input").val().toLowerCase();
    if (!searchQuery) return;

    $(".player-item").each(function () {
        let playerName = $(this).find(".player-name").text().toLowerCase();
        let steamId = $(this).find(".player-steamid").text().toLowerCase();

        if (playerName.includes(searchQuery) || steamId.includes(searchQuery)) {
            $(this).show(); 
        } else {
            $(this).hide();
        }
    });
});

function removePriority(playerId, playerName) {
    $.post(`https://${GetParentResourceName()}/removePriority`, JSON.stringify({ id: playerId }));
    showPopup(`<b>${playerName}</b>'s priority has been removed.`);
}

function showPopup(message) {
    $(".pop-up-desc").html(message);
    $(".pop-up-wrap").fadeIn();
    $.post(`https://${GetParentResourceName()}/sendUpdates`, JSON.stringify({ data: "none" }));
    setTimeout(() => $(".pop-up-wrap").fadeOut(), 3500);
}

$(".search-input").on("input", function () {
    if ($(this).val() === "") {
        $(".player-item").show(); // Show all players
    }
});
$(document).on("click", ".btn-manage-queue", function () {
    currentPage = "queue"; //
    showPopup(`<b>Please wait...</b>`);
});

$(document).on("click", ".btn-manage-players", function () {
    currentPage = "players"; // Set currentPage to "players"
    showPopup(`<b>Please wait...</b>`);
    
});
$(document).on("keydown", function (event) {
    if (event.key === "Escape") { 
        $("#wrap").fadeOut(); 
        $.post(`https://${GetParentResourceName()}/closeMenu`, JSON.stringify({})); 
    }
});