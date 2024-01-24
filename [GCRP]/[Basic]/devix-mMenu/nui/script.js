var Locales = {}
var pages = {}
var ticetAdminsID = {}
var firstImage  = false
var firstLoad = false
var totalPage = 0
var selectedTicketID = null
var alreadyOpenedTicket = false
var ticketPlayerAvatar = null
var ticketIsAdmin = false
var coinIMG = null
var prisma_IMG = null
var ticketEnteredSide = false
// Case
var isFirstCaseOpening = false
var whenClickCaseOpenButton = false
// var inCaseCongPart = false 


let level = new ProgressBar.Circle(".battlepass-screen-rightbar-playerside-level", {
    strokeWidth: 5,
    easing: 'easeInOut',
    duration: 1500,
    color: '#ff4f4f',
    trailColor: '#682121',
    trailWidth: 5,
    svgStyle: null
});


window.addEventListener("message", (event) => {
    const data = event.data;
    const action = data.action;
    switch (action) {
        case "OPEN_MENU":
            return openMenu(data.images, data.menuTopMenus, data.menuBottomMenus, data.ticketAdminIDs);;
        case "CLOSE_SCREEN":
            return closeScreen();
        case "OPEN_PROFILESCREEN":
            return setProfilePages(data.Locales, data.account, data.phone, data.job, data.prime, data.vehicles, data.onlinetime, data.primeEndOfTime);
        case "OPEN_STORESCREEN":
            return openScreen('store',data.Locales, null, null, null, null, null, null, data.prime, data.coin, data.menus, data.coinIMG)
        case "OPEN_RULESCREEN":
            return openScreen("rule", data.Locales, null, null, null, null, null, null, null, null, null, null, data.rule)
        case "OPEN_BATTLESCREEN":
            return openScreen("battlepass", data.Locales, null, null, null, null, null, null, null, null, null, null, null, data.BATTLEPASS, data.pData)
        case "OPEN_JOBSCREEN":
            return setJobScreen(data.Locales, data.jobInfos)
        case "OPEN_SETTINGSSCREEN":
            return openScreen("settings", data.Locales, null, null, null, null, null, null, null, null, null, null, null, null, null, data.crosshair)
        case "OPEN_TICKETS":
            return openScreen("contact",data.Locales, null, null, null, null, null, null, null, null, null, null, null, null, null, null, data.status)
        case "CREATE_TICKET":
            return createTicketSection(data.ticketID, data.pAvatar, data.playerName)
        case "setTaskUpdate": 
            return setTaskUpdate(data.missionID, data.count)
        case "UPDATE_MESSAGES":
            return updateMessage(data.messages, data.ticketID, data.playerCID)
        case "SETUP_TICKETS":
            return setupTickets(data.status, data.data, data.isAdmin, data.Locales)
        case "SETUP_CASES":
            return setupCasePage(data.casesData, data.playerCoin, data.playerPrisma, data.playerFirstname, data.playerLastname, data.steamid, data.coinIMG, data.prismaIMG , data.caseSettings,data.Locales)
        case "SEND_NOTIFY":
            return SetNotify(data.notifyStatus, data.text)
        // case "TICKET_ADMIN_SECTION":
        //     return 
        default:
            return;
    }
});


document.onkeyup = function (event) {
    const charCode = event.key;
        console.log('Bastıgın tus =>', charCode, ticketEnteredSide);

    if (charCode == "Escape") {       
        closeScreen()
        ticketEnteredSide = false
    }
    if (charCode == "Enter") {
        if (ticketEnteredSide) {

            message = $('#ticket-input').val()
            if (message !== "") {
                currentTimeDate = GetCurrentDateKey()
                currentMessageTime = FormatMessageTime()
                pAvatar = ticketPlayerAvatar
                ticketID = selectedTicketID
                $.post("https://devix-mMenu/sendMessage", JSON.stringify({ticketID, message, currentTimeDate, currentMessageTime, pAvatar}));
                $('.contact-screen-ticket-chat-wrapper').scrollTop($('.contact-screen-ticket-chat-wrapper')[0].scrollHeight)
                $('#ticket-input').val("")
            }
        }
    }
};


$('.profile-screen-skill').click(function (e) { 
    e.preventDefault();
    $.post("https://devix-mMenu/openSkillScreen", JSON.stringify({}));
});


//  FUNCTIONS


openMenu = function(images, topButton, altButton, ticketAdmins) {
    // SetNotify('error', 'sa birader')
    ticetAdminsID = ticketAdmins
    $('.menu-wrapper').css({'display':'block'})
    if (!firstLoad) {
        $('.menu-pages-wrapper').html("")
        setImages(images)
        setMenuButtons(topButton)
        firstLoad = true
    }
}

openScreen = function(page, Lang, account, phone, job, prime, vehicles, onlinetime, storePrime, storeCoin, storeMenu,coinIMG, Rule, BATTLEPASS, pData, crosshair, status) {
    Locales = Lang
    $('.menu-wrapper').css({'display':'none'})
    $('.'+page+'-screen-wrapper').css({'display':'block'})
    if (page == "profile") {
        // setProfilePages( account, phone, job, prime, vehicles, onlinetime)
    } else if (page == "store") {
        setStorePages(storePrime, storeCoin,storeMenu,coinIMG)
    } else if (page == "rule") {
        setRulesPages(Rule)
    } else if (page == "battlepass") {
        setBattlePages(BATTLEPASS, pData)
    } else if (page == "settings") {4
        setSettingsScreen(crosshair)
    } else if (page == "contact") {
        console.log('contact status >= ', status);
        if (status) {
            $('.contact-screen-create-ticket').css({'display':'none'})
            $('.contact-screen-ticket-wrapper').css({'display':'block'})
        } else {
            $('.contact-screen-create-ticket').css({'display':'block'})
            $('.contact-screen-ticket-wrapper').css({'display':'none'})
        }
    }
}

setSettingsScreen = function (crosshairs) {
    $('.settings-screen-crosshair-wrapper').html("")
    $.each(crosshairs, function (i, v) { 
        $('.settings-screen-crosshair-wrapper').append(`
        <div class="settings-screen-crosshair-box">
            <div class="settings-screen-crosshair-box-header">${v.label}</div>
            <div class="settings-screen-crosshair-box-icon" style="background-image: url(${v.img})"></div>
            <div class="settings-screen-crosshair-box-select" data-crossimage="${v.img}">${Locales.settingsCrossSelect}</div>
        </div>`)
    });
    $('.settings-screen-crosshair-box-select').click(function (e) { 
        e.preventDefault();
        cImage = $(this).attr('data-crossimage');
        $('.crosshair img').attr('src', cImage)
        localStorage.setItem('LABMENU_CROSSHAIR', cImage)
    });
}

setProfilePages = function(Lang,account, phone, job, prime, vehicles, onlinetime, primeEndOfTime) {
    Locales = Lang
    $('.menu-wrapper').css({'display':'none'})
    $('.profile-screen-wrapper').css({'display':'block'})
    $('#accountHeaderText').text(Locales.accountHeaderText);
    $('#phoneHeaderText').text(Locales.phoneHeaderText);
    $('#jobHeaderText').text(Locales.jobHeaderText);
    $('#onlineHeaderText').text(Locales.onlineHeaderText);
    $('#primeHeaderText').text(Locales.primeHeaderText);
    $('#carsHeaderText').text(Locales.carsHeaderText);
    $('#accountText').text(account);
    $('#phoneText').text(phone);
    $('#jobText').text(job);
    $('#onlineText').text(onlinetime.sec + 'sec - ' + onlinetime.min + 'min - ' + onlinetime.hour + 'hr - '+ onlinetime.day +'dy');
    if (prime == "0" || prime == 0) {
        $('#primeText').text(Locales.PrimeOffText);
    } else {
        $('#primeText').text(Locales.PrimeOnText + ' ' + primeEndOfTime);
    }
    $('.profile-screen-type-statusbox').html("")
    $.each(vehicles, function (i, v) { 
        html = `
        <div class="profile-screen-carlist-box">
            <div class="profile-screen-carlist-box-icon"><i class="fa-solid fa-car" style="font-size:1vh;"></i></div>
            <div class="profile-screen-carlist-box-plate">${i}</div>
        </div>`
        $('.profile-screen-type-statusbox').append(html);
    });
}


setStorePages = function(storePrime, storeCoin,storeMenu, coinIMG) {
    $('.store-screen-leftbar-wrapper').html("")
    $('.store-screen-rightbar-wrapper').html("")
    // console.log('COIN IMG ?= ', coinIMG);
    $('.store-screen-coin-img').css({'background-image':'url('+coinIMG+')'})
    // $('.store-rightbar-screen-coin-img').css({'background-image':'url('+coinIMG+')'})
    
    $('.store-screen-coin-amount').text(storeCoin + ' ' + Locales.coinText);
    stores = {}
    $.each(storeMenu, function (i, v) { 
        stores[i+1] = v.storeBoxEvents
         html = `
        <div class="store-screen-leftbar-box" data-id=${i+1}>
            <div class="store-screen-leftbar-box-icon">${v.storeBoxIcon}</div>
            <div class="store-screen-leftbar-box-name">${v.storeBoxHeader}</div>
        </div>`
         $('.store-screen-leftbar-wrapper').append(html);
    });
    $('.store-screen-leftbar-box').click(function (e) { 
        e.preventDefault();
        boxEventID = $(this).attr('data-id')
        $('.store-screen-rightbar-wrapper').html("")
        $.each(stores[boxEventID], function (index, value) { 
            html = `
            <div class="store-screen-rightbar-box" data-playercoin=${storeCoin} data-type="${value.storeBoxEventType}" data-trigger="${value.storeBoxEventTrigger}" data-arg="${value.storeBoxEventargs}" data-cost="${value.storeBoxEventCoin}" style="background-image: linear-gradient(to bottom, rgba(245, 246, 252, 0), rgba(0, 0, 0, 0.73)),url(${value.storeBoxEventImage}); ${value.storeBoxStyle}">
            <div class="store-screen-rightbar-box-coin" style="${value.storeCoinBoxStyle}">
                <div class="store-rightbar-screen-coin-img" style=" background-image: url(${coinIMG}); ${value.storeCoinBoxICONStyle}"></div><p style="${value.storeCoinBoxTEXTtyle}">${value.storeBoxEventCoin}</p>
            </div>
            <div class="store-screen-rightbar-box-header" style="${value.storeBoxEventHeaderStyle}">${value.storeBoxEventHeader}</div>
            <div class="store-screen-rightbar-box-label"  style="${value.storeBoxEventLabelStyle}">${value.storeBoxEventLabel}</div>
            </div>`
            $('.store-screen-rightbar-wrapper').append(html);
        });
        $('.store-screen-rightbar-box').click(function (e) { 
            e.preventDefault();
            playerCoin = $(this).attr('data-playercoin');
            eventCost = $(this).attr('data-cost');
            eventTrigger = $(this).attr('data-trigger');
            eventArgs =  $(this).attr('data-arg');
            eventType = $(this).attr('data-type');
            newCost = Number(playerCoin) - Number(eventCost)
            console.log(':: COST >',Number(playerCoin) >= Number(eventCost), Number(playerCoin) , Number(eventCost));
            if (Number(playerCoin) >= Number(eventCost)) {
                $('.store-screen-buy-section-header').text(Locales.questionFromBought + newCost);
                $('.store-screen-buy-section').css('display', 'block');
                $('.store-screen-buy-section-confirm').unbind('click').bind('click', function (e) { 
                    e.preventDefault();
                    $('.store-screen-coin-amount').text(newCost + ' ' + Locales.coinText);
                    $.post("https://devix-mMenu/purchaseStore", JSON.stringify({eventTrigger, eventArgs, newCost, eventType, playerCoin, eventCost}));
                    $('.store-screen-buy-section').css('display', 'none');
                    closeScreen()
                    SetNotify("succses", Locales.succsesPurchase)
                });
                $('.store-screen-buy-section-decline').click(function (e) { 
                    e.preventDefault();
                    $('.store-screen-buy-section').css('display', 'none');
                });
                // ! Bir para ayağı yapılacak bir de araba verilme kısmı yazılacak kolayca
            } else {
                SetNotify("error", Locales.enoughCoin)
            }
            // ! tıklandığı zaman coinden hesaplanacak onaylanıyor mu diye soru gelecek ve duruma göre eşya araba neyse verilecek
        });
    });
}

setRulesPages = function(rules) {
    console.log('setRulesPages', rules);
    $('.rule-screen-header').text(Locales.ruleHeader)
    $('.grid').html("")
    $.each(rules, function (i, v) { 
         html =  `
           <div class="card">
    <span class="icon">
        ${i+1}
    </span>
    <h4>${v.ruleHeader}</h4>
    <p>
     ${v.ruleLabel}
    </p>
    <div class="shine"></div>
    <div class="background">
      <div class="tiles">
        <div class="tile tile-1"></div>
        <div class="tile tile-2"></div>
        <div class="tile tile-3"></div>
        <div class="tile tile-4"></div>

        <div class="tile tile-5"></div>
        <div class="tile tile-6"></div>
        <div class="tile tile-7"></div>
        <div class="tile tile-8"></div>

        <div class="tile tile-9"></div>
        <div class="tile tile-10"></div>
      </div>

      <div class="line line-1"></div>
      <div class="line line-2"></div>
      <div class="line line-3"></div>
    </div>
  </div>`
  $('.grid').append(html);
    });
}


setRightWrapper = function (events) {
    console.log('setRightWrapper TETIKLENDI');
    console.log(JSON.stringify(events));
}

setImages = function(images) {
    $('.menu-server-logo').css({'background-image':'url('+images+')'})
}

setMenuButtons = function(MenuSettings) {
    $('.menu-box-wrappers').html("")
    $.each(MenuSettings, function (i, v) { 
         $('.menu-box-wrappers').append(`
         <div class="menu-box" style="${v.boxStyle}" data-eventname="${v.boxEventName}">
                    <div class="menu-box-header" style="${v.boxHeaderStyle}">${v.boxName}</div>
                    <div class="menu-box-label" style="${v.boxLabelStyle}">${v.boxLabel}</div>
                    <div class="menu-box-bg-character" style="background-image:url(${v.boxBGCharacter}); ${v.boxBGCharacterStyle}"></div>
                </div> `);
    });
    $('.menu-box').mouseenter(function () { 
         $(this).css({"background-image":'url(https://cdn.discordapp.com/attachments/720451568041984013/1097544341230194718/boxHover.png)'})
         $(this).css({"scale":"1.02"})
         $(this).css({"border-top":"1px solid #3eff9d"})
         $(this).css({"border-right":"1px solid #3eff9d"})
         $(this).css({"border-left":"1px solid #3eff9d"})
    });
    $('.menu-box').mouseleave(function () { 
        $(this).css({"background-image":'url(")'})
        $(this).css({"scale":"1.0"})
        $(this).css({"border-top":"1px solid #ffffff3f"})
        $(this).css({"border-right":"1px solid #ffffff21"})
        $(this).css({"border-left":"1px solid #ffffff21"})
    });
    $('.menu-box').click(function (e) { 
        e.preventDefault();
        $('.menu-wrapper').css({"display":'none1'})
        eventName =  $(this).attr('data-eventname')
         $.post("https://devix-mMenu/setEvent", JSON.stringify({eventName}));
    });
}


setBattlePages = function (BATTLEPASS, pData) {
    $('.battlepass-screen-wrapper-header').text(Locales.battlepassHeader)
    $('.battlepass-screen-premium-box-lock').text(Locales.purchaseButton)

}

oldCount = 0
newCount = 0
setTaskUpdate = function(missionID, count) {
    totalCount = $('#'+missionID+'_count').attr("data-totalcount");
    if (oldCount == 0) {
        newCount = count
        oldCount = newCount
    } else {
        oldCount = Number(oldCount) + Number(count)
        console.log('oldCount => ', oldCount, count);
    }
    if (Number(totalCount) >= Number(oldCount)){
        $('#'+missionID+'_count').text(''+ oldCount +' / ' + totalCount);
    } else {
        // Tamamlandığı zaman xp vericek.
        oldCount = totalCount
    }

}

setJobScreen = function(Lang, jobInfos) {
    Locales = Lang
    $('.menu-wrapper').css({'display':'none'})
    $('.job-screen-wrapper').css({'display':'flex'})
    $('.job-screen-leftbar').html("")
    $.each(jobInfos, function (i, v) { 
        $('.job-screen-leftbar').append(`
            <div class="job-screen-leftbar-box" data-jobheader="${v.jobHeader}" data-joblabel="${v.jobLabel}" data-jobimage="${v.jobImages}" data-jobcoordsx=${v.jobCoordsX} data-jobcoordsy=${v.jobCoordsY}>
                <div class="job-screen-leftbar-icon">${v.buttonIcon}</div>
                <div class="job-screen-leftbar-name">${v.buttonText}</div>
            </div>
        `)
    });
    $('.job-screen-leftbar-box').click(function (e) { 
        e.preventDefault();
        jobCoordsX = $(this).attr('data-jobcoordsx');
        jobCoordsY = $(this).attr('data-jobcoordsy');
        jobHeader = $(this).attr('data-jobheader');    
        jobLabel = $(this).attr('data-joblabel');    
        jobImage = $(this).attr('data-jobimage');    
        $('.job-screen-right-section-setwaypoint').css('display', 'block');
        if (jobImage !== "") {
            $('.job-screen-right-section-image').css('background-image', 'url('+jobImage+')');
        } else {
            $('.job-screen-right-section-image').css('background-image', 'url()');
        }
        $('.job-screen-right-section-header').text(jobHeader)
        $('.job-screen-right-section-label').text(jobLabel)

        $('.job-screen-right-section-setwaypoint').attr('data-jobcoordsx', jobCoordsX);
        $('.job-screen-right-section-setwaypoint').attr('data-jobcoordsy', jobCoordsY);
        $('.job-screen-right-section-setwaypoint').click(function (e) { 
            e.preventDefault();
            jobCoordsX = $(this).attr('data-jobcoordsx');
            jobCoordsY = $(this).attr('data-jobcoordsy');
            $.post("https://devix-mMenu/setNewPoint", JSON.stringify({jobCoordsX, jobCoordsY}));
        });
    });
}

createTicketSection = function(ticketID, pAvatar, playerName) {
    console.log('createTicketSection',ticketID, pAvatar);
    $('.contact-screen-ticket-wrapper').css({'display':'block'})
    $('.contact-screen-ticket-header').text(ticketID)
    $('.contact-screen-ticket-chat-wrapper').html("")
    ticketPlayerAvatar = pAvatar
    selectedTicketID = ticketID
    // Yeni sohbet arabirimi açılacak ve onun üzerinde yazışmalar başlıyacak
}

updateMessage = function(messages, ticketID, playerCID,) {
    
    console.log('UPDATED MESSAGE >', JSON.stringify(messages));    
    $.post("https://devix-mMenu/getTicketMessages", JSON.stringify({ticketID}), function(messages) {
        $('.contact-screen-ticket-chat-wrapper').html("")
        $.each(messages[0], function (index, value) { 
            $.each(value, function (i, v) { 
                $.each(ticetAdminsID, function (ticketAdminID, ticketAdminLabels) { 
                     
                    //  ! Admin tarafındayken  player kısmının admin olması gerekiyor
                    if (v.sender !== ticketAdminID) {
                        html = `
                        <div class="contact-screen-ticket-player-box">
                        <div class="contact-screen-ticket-player-playergrade"></div>
                        <div class="contact-screen-ticket-player-playername">${v.firstname} ${v.lastname}</div>
                        <div class="contact-screen-ticket-player-sendtime"> ${v.date}  | ${v.time}</div>
                        <div class="contact-screen-ticket-player-text">${v.message}</div>
                        </div>
                        `
                    } else {
                        html = `
                        <div class="contact-screen-ticket-other-box">
                        <div class="contact-screen-ticket-other-playergrade">ADMIN</div>
                        <div class="contact-screen-ticket-other-playername">${v.firstname} ${v.lastname}</div>
                        <div class="contact-screen-ticket-other-sendtime"> ${v.date}  | ${v.time}</div>
                        <div class="contact-screen-ticket-other-text">${v.message}</div>
                        </div>
                        `
                    }
                });
                $('.contact-screen-ticket-chat-wrapper').append(html);
            });
        });
        $('.contact-screen-ticket-chat-wrapper').scrollTop($('.contact-screen-ticket-chat-wrapper')[0].scrollHeight)
    });
}

setupTickets = function (status, data, isAdmin, Lang) {  
    Locales = Lang
    ticketEnteredSide = true
    // Ticket History için arama butonu eklenecek 
    console.log('SETUP TICKETS => ', status);
    console.log('SETUP TICKET[test] =>',isAdmin);
    $('.menu-wrapper').css({'display':'none'})
    $('.contact-screen-wrapper').css({'display':'block'})
    $('.contact-screen-admin-section').css({'display':'none'});
    if (isAdmin) {
        ticketIsAdmin = isAdmin
        $('.contact-screen-ticket-wrapper').css({'display':'none'})
        $('.contact-screen-ticket-history-wrapper').css({'display':'none'})
        $('.contact-screen-create-ticket').css({'display':'none'})
        $('.contact-screen-admin-section-wrapper').css({'display':'block'})
        $('.contact-screen-admin-ticket-wrapper').html("")
        $('.contact-screen-admin-ownticket-wrapper').html("")
        console.log('Locales.ticketNoAdmin', Locales.ticketNoAdmin);
        $.each(data, function (i, v) { 
            console.log('v.pID == v.ticketAdminID', JSON.stringify(v) ,v.pID ,v.ticketAdminID);
            if (v.pID == v.ticketAdminID) {
                $('.contact-screen-admin-ownticket-wrapper').append(`
                <div class="contact-screen-admin-ticket-box" data-ticketid="${v.ticketID}">
                    <div class="contact-screen-admin-ticket-playerimage"></div>
                    <div class="contact-screen-admin-ticket-playername">${v.ticketID}</div>
                    <div class="contact-screen-admin-ticket-status">STATUS: <p style="color:greenyellow">${v.status}</p></div>
                    <div class="contact-screen-admin-ticket-status" style="font-size:.7vh;">Owned Admin: <p style="color: rgb(255, 88, 82)">${v.ticketAdminID ||  Locales.ticketNoAdmin}</p></div>
                </div>`);    
            } else {
                $('.contact-screen-admin-ticket-wrapper').append(`
                <div class="contact-screen-admin-ticket-box" data-ticketid="${v.ticketID}">
                    <div class="contact-screen-admin-ticket-playerimage"></div>
                    <div class="contact-screen-admin-ticket-playername">${v.ticketID}</div>
                    <div class="contact-screen-admin-ticket-status">STATUS: <p style="color:greenyellow">${v.status}</p></div>
                    <div class="contact-screen-admin-ticket-status" style="font-size:.7vh;">Owned Admin: <p style="color: rgb(255, 88, 82);">${v.ticketAdminID ||  Locales.ticketNoAdmin}</p></div>

                </div>`);    
            }
        });
        $('.contact-screen-admin-ticket-box').click(function (e) { 
            e.preventDefault();
            ticketID = $(this).attr('data-ticketid');
            console.log('clicked => ', ticketID);
            $.post("https://devix-mMenu/getTicketMessages", JSON.stringify({ticketID}), function(messages) {
                // ! sayfa düzenlenicek ve sohbeti yüklüyecek.
                $('.contact-screen-ticket-chat-wrapper').html("")
                console.log('messages, ticketID, ownerID', JSON.stringify(messages[0]), messages[1]);
                $.each(messages[0], function (index, value) { 
                    $.each(value, function (i, v) { 
                        $.each(ticetAdminsID, function (ticketAdminID, ticketAdminLabels) {  
                            
                            //  ! Admin tarafındayken  player kısmının admin olması gerekiyor
                            if (v.sender !== ticketAdminID) {
                                html = `
                                <div class="contact-screen-ticket-player-box">
                                <div class="contact-screen-ticket-player-playergrade"></div>
                                <div class="contact-screen-ticket-player-playername">${v.firstname} ${v.lastname}</div>
                                <div class="contact-screen-ticket-player-sendtime"> ${v.date}  | ${v.time}</div>
                                <div class="contact-screen-ticket-player-text">${v.message}</div>
                                </div>
                                `
                            } else {
                                html = `
                                <div class="contact-screen-ticket-other-box">
                                <div class="contact-screen-ticket-other-playergrade">ADMIN</div>
                                <div class="contact-screen-ticket-other-playername">${v.firstname} ${v.lastname}</div>
                                <div class="contact-screen-ticket-other-sendtime"> ${v.date}  | ${v.time}</div>
                                <div class="contact-screen-ticket-other-text">${v.message}</div>
                                </div>
                                `
                            }
                        });
                        $('.contact-screen-ticket-chat-wrapper').append(html);
                    });
                });
                $('.contact-screen-ticket-header').text(ticketID);
                $('.contact-screen-admin-section-wrapper').css({'display':'none'})
                $('.contact-screen-ticket-wrapper').css({'display':'block'})
                $('.contact-screen-ticket-history-wrapper').css({'display':'none'})
                $('.contact-screen-admin-section').css({'display':'block'});
                $('#ticketTakeOwner').attr('data-ticketid', ticketID);
                $('#ticketRE_TakeOwner').attr('data-ticketid', ticketID);
                $('#closeTheTicket').attr('data-ticketid', ticketID);
                $('#teleportToPlayer').attr('data-ticketid', ticketID);
                $('#bringToPlayer').attr('data-ticketid', ticketID);
                
                
                selectedTicketID = ticketID
            });
            $('.contact-screen-ticket-chat-wrapper').scrollTop($('.contact-screen-ticket-chat-wrapper')[0].scrollHeight)

        });
    } else {
        ticketIsAdmin = isAdmin
        $('.contact-screen-ticket-history-wrapper').html("")
        if (status) {
            $('.contact-screen-ticket-history-wrapper').css({'display':'block'})
            $('.contact-screen-create-ticket').css({'display':'none'})
            $('.contact-screen-ticket-wrapper').css({'display':'none'})
        } else {
            $('.contact-screen-create-ticket').css({'display':'block'})
            $('.contact-screen-ticket-history-wrapper').css({'display':'none'})
            $('.contact-screen-ticket-wrapper').css({'display':'none'})
        }
        $.each(data, function (i, v) { 
        $('.contact-screen-ticket-history-wrapper').append(`
        <div class="contact-screen-ticket-history-box" data-ticketid="${v.ticketID}">
            <div class="contact-screen-ticket-history-box-icon"><i class="fa-solid fa-paper-plane"></i></div>
            <div class="contact-screen-ticket-history-box-name">${v.ticketID}</div>
        </div>
        `);
        });
        $('.contact-screen-ticket-history-box').click(function (e) { 
            e.preventDefault();
            ticketID = $(this).attr('data-ticketid');
            $.post("https://devix-mMenu/getTicketMessages", JSON.stringify({ticketID}), function(messages) {
                // ! sayfa düzenlenicek ve sohbeti yüklüyecek.
                $('.contact-screen-ticket-chat-wrapper').html("")
             $.each(messages[0], function (index, value) { 
                    $.each(value, function (i, v) { 
                         
                        // console.log('v.sender, v.firstname =>', JSON.stringify(v));
                        $.each(ticetAdminsID, function (ticketAdminID, ticketAdminLabels) { 
                     
                        //  ! Admin tarafındayken  player kısmının admin olması gerekiyor
                            if (v.sender !== ticketAdminID) {
                                html = `
                                <div class="contact-screen-ticket-player-box">
                                <div class="contact-screen-ticket-player-playergrade"></div>
                                <div class="contact-screen-ticket-player-playername">${v.firstname} ${v.lastname}</div>
                                <div class="contact-screen-ticket-player-sendtime"> ${v.date}  | ${v.time}</div>
                                <div class="contact-screen-ticket-player-text">${v.message}</div>
                                </div>
                                `
                            } else {
                                html = `
                                <div class="contact-screen-ticket-other-box">
                                <div class="contact-screen-ticket-other-playergrade">ADMIN</div>
                                <div class="contact-screen-ticket-other-playername">${v.firstname} ${v.lastname}</div>
                                <div class="contact-screen-ticket-other-sendtime"> ${v.date}  | ${v.time}</div>
                                <div class="contact-screen-ticket-other-text">${v.message}</div>
                                </div>
                                `
                            }
                        });
                        $('.contact-screen-ticket-chat-wrapper').append(html);
                    });
                });
                $('.contact-screen-ticket-wrapper').css({'display':'block'})
                $('.contact-screen-ticket-history-wrapper').css({'display':'none'})
                selectedTicketID = ticketID
            });
        });
        
    }
}

$('#ticketTakeOwner').click(function (e) { 
    e.preventDefault();
    $.post("https://devix-mMenu/setTicketOwner", JSON.stringify({ticketID}))
});

$('#teleportToPlayer').click(function (e) { 
    e.preventDefault();
    $.post("https://devix-mMenu/teleportToPlayer", JSON.stringify({ticketID}))
});

$('#bringToPlayer').click(function (e) { 
    e.preventDefault();
    $.post("https://devix-mMenu/bringToPlayer", JSON.stringify({ticketID}))
});



$('#ticketRE_TakeOwner').click(function (e) { 
    e.preventDefault();
    $.post("https://devix-mMenu/setRETicketOwner", JSON.stringify({ticketID}))
});

$('#closeTheTicket').click(function (e) { 
    e.preventDefault();
    $.post("https://devix-mMenu/closeTheTicket", JSON.stringify({ticketID}))
    closeScreen()
});



$(".contact-screen-found-ticket").keyup(function() {
  // Retrieve the input field text and reset the count to zero
  var filter = $(this).val(),
    count = 0;
  // Loop through the comment list
  $('.contact-screen-admin-ticket-wrapper .contact-screen-admin-ticket-box .contact-screen-admin-ticket-playername').each(function() {
    // If the list item does not contain the text phrase fade it out
    if ($(this).text().search(new RegExp(filter, "i")) < 0) {
      $(this).parent(".contact-screen-admin-ticket-box").hide();
      // Show the list item if the phrase matches and increase the count by 1
    } else {
      $(this).parent(".contact-screen-admin-ticket-box").show();
      count++;
    }
  });
});
$(".contact-screen-found-ticket").keyup(function() {
  // Retrieve the input field text and reset the count to zero
  var filter = $(this).val(),
    count = 0;
  // Loop through the comment list
  $('.contact-screen-admin-ownticket-wrapper .contact-screen-admin-ticket-box .contact-screen-admin-ticket-playername').each(function() {
    // If the list item does not contain the text phrase fade it out
    if ($(this).text().search(new RegExp(filter, "i")) < 0) {
      $(this).parent(".contact-screen-admin-ownticket-box").hide();
      // Show the list item if the phrase matches and increase the count by 1
    } else {
      $(this).parent(".contact-screen-admin-ownticket-box").show();
      count++;
    }
  });
});


$('.contact-screen-ticket-send').click(function (e) { 
    e.preventDefault();
    message = $('#ticket-input').val()
    if (message !== "") {
        currentTimeDate = GetCurrentDateKey()
        currentMessageTime = FormatMessageTime()
        pAvatar = ticketPlayerAvatar
        ticketID = selectedTicketID
        $.post("https://devix-mMenu/sendMessage", JSON.stringify({ticketID, message, currentTimeDate, currentMessageTime, pAvatar}));
        $('.contact-screen-ticket-chat-wrapper').scrollTop($('.contact-screen-ticket-chat-wrapper')[0].scrollHeight)
        $('#ticket-input').val("")
    }
});

GetLastMessage = function(messages) {
    var CurrentDate = new Date();
    var CurrentMonth = CurrentDate.getMonth();
    var CurrentDOM = CurrentDate.getDate();
    var CurrentYear = CurrentDate.getFullYear();
    var LastMessageData = {
        time: "00:00",
        message: "nothing"
    }

    if (messages == undefined) {
        LastMessageData.time = "00:00";
        LastMessageData.message = "Yok";
    } else {
        $.each(messages[messages.length - 1], function(i, msg){
            var msgData = msg[msg.length - 1];
            LastMessageData.time = msgData.time
            LastMessageData.message = msgData.message
        });
    }

    return LastMessageData
}

const monthNames = ["Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"];

FormatChatDate = function(date) { // * Mesaj ayı alıp ne zaman önce gitti vesaire gibi bir işlem uyguluyor
    var TestDate = date.split("-");
    var NewDate = new Date((parseInt(TestDate[1]) + 1)+"-"+TestDate[0]+"-"+TestDate[2]);

    var CurrentMonth = monthNames[NewDate.getMonth()];
    var CurrentDOM = NewDate.getDate();
    var CurrentYear = NewDate.getFullYear();
    var CurDateee = CurrentDOM + "-" + NewDate.getMonth() + "-" + CurrentYear;
    var ChatDate = CurrentDOM + " " + CurrentMonth + " " + CurrentYear;
    var CurrentDate = GetCurrentDateKey();

    var ReturnedValue = ChatDate;

    if (CurrentDate == CurDateee) {
        ReturnedValue = "Bugün";
    }

    return ReturnedValue;
}


GetCurrentDateKey = function() {  // * Mesaj gönderirken aktif zaman alma 
    var CurrentDate = new Date();
    var CurrentMonth = CurrentDate.getMonth();
    var CurrentDOM = CurrentDate.getDate();
    var CurrentYear = CurrentDate.getFullYear();
    var CurDate = ""+CurrentDOM+"-"+CurrentMonth+"-"+CurrentYear+"";

    return CurDate;
}


FormatMessageTime = function() { // * Mesaj gönderirken aktif dakika alma 
    var NewDate = new Date();
    var NewHour = NewDate.getHours();
    var NewMinute = NewDate.getMinutes();
    var Minutessss = NewMinute;
    var Hourssssss = NewHour;
    if (NewMinute < 10) {
        Minutessss = "0" + NewMinute;
    }
    if (NewHour < 10) {
        Hourssssss = "0" + NewHour;
    }
    var MessageTime = Hourssssss + ":" + Minutessss
    return MessageTime;
}




$('.settings-screen-fps-box').click(function (e) { 
    e.preventDefault();
    fpsStatus = $(this).attr('data-status');
    $.post("https://devix-mMenu/setFpsSettings", JSON.stringify({fpsStatus}));
    // console.log('CLICK FPS BOX', fpsStatus);
});

$('.contact-screen-create-ticket').click(function (e) { 
    e.preventDefault();
    $(this).css({'display':'none'})
    $.post("https://devix-mMenu/createTicket", JSON.stringify({})); 
});

closeScreen = function() {
    $('.menu-wrapper').css({'display':'none'})
    $('.profile-screen-wrapper').css({'display':'none'})
    $('.store-screen-wrapper').css({'display':'none'})
    $('.rule-screen-wrapper').css({'display':'none'})
    $('.battlepass-screen-wrapper').css({'display':'none'})
    $('.case-screen-wrapper').css({'display':'none'})
    $('.job-screen-wrapper').css({'display':'none'})
    $('.settings-screen-wrapper').css({'display':'none'})
    $('.contact-screen-wrapper').css({'display':'none'})
    $('.store-screen-buy-section').css({'display':'none'})
    $('.case-screen-wrapper').css({'display':'none'})
    $('.case-opening-side').css({'display':'none'})
    $('.case-opening-side-cong-side').css({'display':'none'})
    

    
    ticketEnteredSide = false

    $.post("https://devix-mMenu/closeScreen", JSON.stringify({}));
}

function LoadCrosshair() {
    var srcimgpe = localStorage.getItem('LABMENU_CROSSHAIR')
    $('.crosshair img').attr('src', srcimgpe || '')
}


window.addEventListener('load', () => {
    LoadCrosshair()
});




var getIndex
var caseAltIndex
var caseType 
var itemType
var itemArg 
var itemCount
var itemSellCost
var itemLabel 
var itemimage
var itemColor 
var itemVariable
var itemVariableLabel
var itemVariableSellCost
var itemTotalSellCost 
var pCoin 
var pPrisma
var caseOpeningPrice



// Another things

selecetedItem = {}
cases = {} // ? Burada alt kısımdakilerin kasaların içeriği olarak girilecek, yani tıklanan kasanın iç kasaları buradan verisi çekilecek
cSettings = {} // itemlerin type'ları ve afişin yeri
// !CASE 
setupCasePage = function(casesData, playerCoin, playerPrisma, playerFirstname, playerLastname, steamid, coin_IMG, prismaIMG , caseSettings, Lang) {
    prisma_IMG = prismaIMG
    coinIMG = coin_IMG
    cSettings = caseSettings
    Locales = Lang
    pCoin = Number(playerCoin)
    pPrisma = Number(playerPrisma)
    $('.case-screen-header-playername').text(playerFirstname+ ' '+ playerLastname)
    $('.menu-wrapper').css({'display':'none'})
    $('.case-screen-wrapper').css({'display':'block'})
    $('.case-screen-ad-part').css({'background-image':'url('+cSettings.advirsmentIMG+')'})
    $('.case-screen-header-prisma-icon').css({'background-image':'url('+prismaIMG+')'})
    $('.case-screen-header-coin-icon').css({'background-image':'url('+coinIMG+')'})
    $('.case-screen-header-coin-amount').text(pCoin);
    $('.case-screen-header-prisma-amount').text(pPrisma);
    if (isFirstCaseOpening !== true ) {
        isFirstCaseOpening = true
        // !Cases Data içerisindeki veriyi appendliyecek
        $.each(casesData, function (i, v) { 
            console.log('casesData =>', i ,v.casePartOfName);
            $('.case-cases-wrapper').append(`
                <div class="case-part-wrapper"> <!-- *** Oluşturulan kategori yeri -->
                    <div class="cases-caseheader">${v.casePartOfName}</div>
                    <div class="case-caseheader-bottom"></div>
                    <div class="case-side-cases-wrapper"  id="cases_${i}"></div> <!-- *** Oluşturulan kategornin içindeki kasaların bulunacağı yer -->
                </div>
            `)
            $.each(v.cases, function (icase, vcase) { 
                $.each(vcase, function (index, value) { 
                    var img 
                    var casesNew 
                    var casesNewText
                    if (value.casesAreNew) { casesNew = "1" } else { casesNew = "0" }
                    if (value.casesAreNew) { casesNewText = "NEW" } else { casesNewText = "" }
                    if (value.casesType == "coin") { img = coinIMG } else if (value.casesType == "prisma") { img = prismaIMG }
                    cases[i+'_'+index+'_'+icase] = value.casesItem
                    $('#cases_'+i).append(`
                        <div class="case" style="background-image: linear-gradient(357deg, rgba(22, 21, 21, 1) 2%, rgba(255, 50, 50, 0) 56%), url(${value.casesBackgroundImage})" data-caselabel="${value.casesHeader}" data-caseimg="${value.casesBackgroundImage}"  data-caseindex="${i+'_'+index+'_'+icase}" data-casetype="${value.casesType}" data-casesopeningprice="${value.casesOpeningPrice}" >
                        <div class="caseNewStatus" style="opacity: ${casesNew}" >${Locales.caseAreNew}</div>
                        <div class="casePrice">${value.casesOpeningPrice} <div class="caseCoinIMG" style="background-image:url(${img})"></div></div>
                        <div class="caseLabel">${value.casesHeader}</div>
                        </div>
                    `)
                });
            });
    // background: linear-gradient(357deg, rgba(22, 21, 21, 1) 2%, rgba(255, 50, 50, 0) 56%), url(https://cdn.discordapp.com/attachments/1106256169296724059/1106314999728709683/GOLD_DIGGER.png);

            $('.case').unbind("click").click(function (e) { 
                e.preventDefault();
                getIndex = $(this).attr('data-caseindex');
                caseType = $(this).attr('data-casetype');
                caseImage = $(this).attr('data-caseimg');
                caseLabel = $(this).attr('data-caselabel');
                caseOpeningPrice = Number($(this).attr('data-casesopeningprice'))
                $('.case-opening-side-header-casename').text(caseLabel);
                $('.case-opening-side-header-caseimg').css({'background-image':'linear-gradient(357deg, rgba(22, 21, 21, 1) 2%, rgba(255, 50, 50, 0) 56%), url('+caseImage+')'})
                $('.normalopencase').attr('data-casetype', caseType);
                $('.normalopencase').attr('data-casesopeningprice', caseOpeningPrice);
                $('.fastopencase').attr('data-casetype', caseType);
                $('.fastopencase').attr('data-casesopeningprice', caseOpeningPrice);
                $('.case-opening-side-caseitems').html("")
                $.each(cases[getIndex], function (i, v) {
                    console.log('cSettings.variableTypes[v.casesItemVariable].color', cSettings.variableTypes[v.casesItemVariable].color);
                    $('.case-opening-side-caseitems').append(`
                        <div class="case-opening-side-box" style="border-radius:8px;">
                        <div class="case-opening-side-box-item-img" style="background-image: url(${v.casesItemImage}); background-position: center;background-repeat: no-repeat; background-size: contain;"></div>
                        <div class="case-opening-side-box-item-label" style="border-bottom: 5px solid ${cSettings.variableTypes[v.casesItemVariable].color}">${v.caseItemLabel}</div>
                    </div>`);
                });
                setRollArea(cases[getIndex], caseType)

                showMenus("openingSide", "case-opening-side")

            });
        });
    } 
}
// cSettings.variableTypes[rollItems[randed].casesItemVariable].color


$('.case-opening-side-return').click(function (e) { 
    e.preventDefault();
    if (whenClickCaseOpenButton) {
        SetNotify('error', Locales.errorClickCaseOpen)
    } else {
        showMenus("openingSide", "case-opening-side")
    }
});

$('.normalopencase').click(function (e) { 
    e.preventDefault();
    // caseOpening.play();

    caseType = $(this).attr('data-casetype');
    caseOpeningPrice = Number($(this).attr('data-casesopeningprice'))
    if (caseType == "prisma") {
        if (pPrisma - caseOpeningPrice <= pPrisma) {
            if (whenClickCaseOpenButton !== true) {
                pPrisma = (pPrisma - caseOpeningPrice)
                whenClickCaseOpenButton = true
                setTimeout(function() {
                    goRoll();
                    // Ses eklenicek
                }, 500);
            } else {
                SetNotify('error', Locales.errorClickCaseOpen)
            }
        } else {
            SetNotify('error', Locales.youDontHaveEnoughCredit)
        }
    } else if (caseType == "coin") {
        if (pCoin - caseOpeningPrice <= pCoin) {
            if (whenClickCaseOpenButton !== true) {
                whenClickCaseOpenButton = true
                pCoin = (pCoin - caseOpeningPrice)
                setTimeout(function() {
                    goRoll();
                    // Ses eklenicek
                }, 500);
            } else {
                SetNotify('error', Locales.errorClickCaseOpen)
            }            
        } else {
            SetNotify('error', Locales.youDontHaveEnoughCredit)
        }
    }
    $('.case-screen-header-coin-amount').text(pCoin);
    $('.case-screen-header-prisma-amount').text(pPrisma);
    $.post("https://devix-mMenu/updateCoins", JSON.stringify({pCoin, pPrisma}));
});

$('.fastopencase').click(function (e) { 
    e.preventDefault();
    // caseFastOpening.play();
    caseType = $(this).attr('data-casetype');
    caseOpeningPrice = Number($(this).attr('data-casesopeningprice'))
    if (caseType == "prisma") {
        if (pPrisma - caseOpeningPrice <= pPrisma) {
            if (whenClickCaseOpenButton !== true) {
                whenClickCaseOpenButton = true
                setTimeout(function() {
                    goRoll();
                    // Ses eklenicek
                    pPrisma = pPrisma - caseOpeningPrice
                }, 500);
            } else {
                SetNotify('error', Locales.errorClickCaseOpen)
            }
        } else {
            SetNotify('error', Locales.youDontHaveEnoughCredit)
        }
    } else if (caseType == "coin") {
        if (pCoin - caseOpeningPrice <= pCoin) {
            if (whenClickCaseOpenButton !== true) {
                whenClickCaseOpenButton = true
                setTimeout(function() {
                    goRoll();
                    // Ses eklenicek
                    pCoin = pCoin - caseOpeningPrice 
                }, 500);
            } else {
                SetNotify('error', Locales.errorClickCaseOpen)
            }            
        } else {
            SetNotify('error', Locales.youDontHaveEnoughCredit)
        }
    }
    $('.case-screen-header-coin-amount').text(pCoin);
    $('.case-screen-header-prisma-amount').text(pPrisma);
    $.post("https://devix-mMenu/updateCoins", JSON.stringify({pCoin, pPrisma}));
});

$('.take').click(function (e) { 
    e.preventDefault();
    array = [];
    // itemGet.play();
    array.push(caseType)
    array.push(itemType)
    array.push(itemArg)
    array.push(itemCount)
    array.push(itemSellCost)
    array.push(itemLabel)
    array.push(itemimage)
    array.push(itemColor)
    array.push(itemVariable)
    array.push(itemVariableLabel)
    array.push(itemVariableSellCost)
    array.push(itemTotalSellCost)
   $.post("https://devix-mMenu/collectItem", JSON.stringify({array}));
   setTimeout(() => {
       showMenus("openingCongSide", "case-opening-side-cong-side")
    }, 150);
    setRollArea(cases[getIndex], caseType)
    setTimeout(() => {
        console.log('data temizlendi ');
        caseType  = null
        itemType = null
        itemArg  = null
        itemCount  = null
        itemSellCost = null
        itemLabel  = null
        itemimage = null
        itemColor  = null
        itemVariable = null
        itemVariableLabel = null
        itemVariableSellCost = null
        itemTotalSellCost  = null
    }, 500);
    // showMenus("openingSide", "case-opening-side")
    whenClickCaseOpenButton = false
});

$('.sell').click(function (e) { 
    e.preventDefault();
    // itemSell.play();
    // Amount'u kaç ise satma çarpanı ile birlikte oyuncuya eklenecek
    // caseitemVariable = cSettings.variableTypes[itemVariable].costMultiplier
    totalSellCost =  Number(itemSellCost) * Number(itemVariableSellCost)
    if (caseType == "prisma") {
        pPrisma = totalSellCost + pPrisma
        $('.case-screen-header-'+caseType+'-amount').text(pPrisma);

    } else if (caseType == "coin") {
        pCoin = totalSellCost + pCoin
        $('.case-screen-header-'+caseType+'-amount').text(pCoin);
        
    }
    $.post("https://devix-mMenu/updateCoins", JSON.stringify({pCoin, pPrisma}));
    setTimeout(() => {
       showMenus("openingCongSide", "case-opening-side-cong-side")
    }, 150);
    setRollArea(cases[getIndex], caseType)
        setTimeout(() => {
        console.log('data temizlendi ');
        caseType  = null
        itemType = null
        itemArg  = null
        itemCount  = null
        itemSellCost = null
        itemLabel  = null
        itemimage = null
        itemColor  = null
        itemVariable = null
        itemVariableLabel = null
        itemVariableSellCost = null
        itemTotalSellCost  = null
    }, 500);
    whenClickCaseOpenButton = false
});


function randomInt(min, max) {
  return Math.floor(Math.random() * (max - min)) + min;
}

function caseRandomizer() {
    return Math.floor((Math.random() * -4000) + -8000);
}

function setRollArea(caseData, casesType) {
     $('.raffle-roller-container').css({
        transition: "all 0s cubic-bezier(.08,.6,0,1)"
    });
    $(".raffle-roller-container").css("margin-left", "0px");
    $('.raffle-roller-container').html("")
    var rollItems = []
    for (var i = 0; i < caseData.length; i++) {
      var item = caseData[i];
      var chance = Math.round(item.casesItemChance / 1);
      for (var j = 0; j < chance; j++) {
        if (rollItems.length > 200) {
          break;
        }
        rollItems.push(item);
      }
    }  
    for(var i = 0; i < 256; i++) {
        var randed = randomInt(0, rollItems.length);
        var item = rollItems[randed]
        if (i == 93) {
            $('.raffle-roller-container').append(`
                <div id="CardNumber${i}" class="boxitem item-${i}" data-itemvariable="${item.casesItemVariable}" data-casetype="${casesType}" data-itemcount="${item.casesItemCount}" data-itemtype="${item.caseItemType}" data-itemarg="${item.casesItemArg}" data-itemsellcoin="${item.casesItemSellCoin}" data-itemlabel="${item.caseItemLabel}" data-itemimage="${item.casesItemImage}" data-itemcolor="${cSettings.variableTypes[rollItems[randed].casesItemVariable].color}" data-itemvariablesellcost="${cSettings.variableTypes[rollItems[randed].casesItemVariable].costMultiplier}" data-itemvariablelabel="${cSettings.variableTypes[rollItems[randed].casesItemVariable].variableLabel}"  style="background-color: linear-gradient(358deg, ${cSettings.variableTypes[rollItems[randed].casesItemVariable].color}, #080812);border-radius:10px;  border-top:0px solid transparent;background-image: url(${item.casesItemImage});"><div class="cardText" style=" border-bottom: 5px solid ${cSettings.variableTypes[rollItems[randed].casesItemVariable].color}">${item.caseItemLabel}</div></div>
            `);
        } else {
            $('.raffle-roller-container').append(`
                <div id="CardNumber${i}" class="boxitem item-${i}"  style="background-color: linear-gradient(358deg, ${cSettings.variableTypes[rollItems[randed].casesItemVariable].color}, #080812);border-radius:10px; border-top:0px solid transparent;background-image: url(${item.casesItemImage});"><div class="cardText" style=" border-bottom: 5px solid ${cSettings.variableTypes[rollItems[randed].casesItemVariable].color}">${item.caseItemLabel}</div></div>
            `);
        }
    }
}

function goRoll() {

    // Variables =>
    caseType = $('#CardNumber93').attr('data-casetype');
    itemType = $('#CardNumber93').attr('data-itemtype');
    itemArg = $('#CardNumber93').attr('data-itemarg');
    itemCount = $('#CardNumber93').attr('data-itemcount');
    itemSellCost = $('#CardNumber93').attr('data-itemsellcoin');
    itemLabel = $('#CardNumber93').attr('data-itemlabel');
    itemImage = $('#CardNumber93').attr('data-itemimage');
    itemColor = $('#CardNumber93').attr('data-itemcolor');
    itemVariable = $('#CardNumber93').attr('data-itemvariable');
    itemVariableLabel = $('#CardNumber93').attr('data-itemvariablelabel');
    itemVariableSellCost = $('#CardNumber93').attr('data-itemvariablesellcost'); // itemSellCost'ile çarpan şeklinde olacak bu sayede tipine göre satışı artıcak
    itemTotalSellCost = (Number(itemVariableSellCost) * Number(itemSellCost))
    img = null
    if (caseType == "coin") { img = coinIMG } else if (caseType == "prisma") { img = prisma_IMG }
    console.log('caseType img vs vs', img, coinIMG, prisma_IMG, caseType);
    // SETTINGS =>
    $('.case-opening-side-cong-side').css({'background':'linear-gradient(1deg, '+itemColor+' 2%, #00000077 68%)'});
    
    // $('.coinIconIMG').css({'background-image':'url('+img+')'});;
    $('.case-opening-side-cong-side-itemType').css({'background':itemColor});
    $('.case-opening-side-cong-side-itemIMG').css({'background-image':'url('+itemImage+')'});
    $('.case-opening-side-cong-side-header').text(Locales.caseCongratulations);
    $('.case-opening-side-cong-side-itemType').text(itemVariableLabel);
    $('.sell').html(Locales.caseSellItem + ' : '+ itemTotalSellCost +" <div class='coinIconIMG' style='background-image:url("+img+")'></div>");
    $('.take').text(Locales.caseTakeItem);

    $('.raffle-roller-container').css({
        transition: "all 8s cubic-bezier(.08,.6,0,1)"
    });
    $(".raffle-roller-container").css("margin-left", "-12000px"); // ! Random hesaplanıp eğer ki o yol olmazsa sadece belirli item çıkacak şekilde ayarlanacak, çıkan her zaman 66.'ncı item oluyor
    setTimeout(() => {
        $('#CardNumber93').css({
            "scale": "1.1",
            "border":"2px solid lightgreen",
            "box-shadow":"3px 6px 81px rgb(82, 255, 114)",
        });
    }, 8500);
    setTimeout(() => {
        showMenus("openingCongSide", "case-opening-side-cong-side")
    }, 9300);


}

function goFastRoll() {

    // Variables =>
    caseType = $('#CardNumber93').attr('data-casetype');
    itemType = $('#CardNumber93').attr('data-itemtype');
    itemArg = $('#CardNumber93').attr('data-itemarg');
    itemCount = $('#CardNumber93').attr('data-itemcount');
    itemSellCost = $('#CardNumber93').attr('data-itemsellcoin');
    itemLabel = $('#CardNumber93').attr('data-itemlabel');
    itemImage = $('#CardNumber93').attr('data-itemimage');
    itemColor = $('#CardNumber93').attr('data-itemcolor');
    itemVariable = $('#CardNumber93').attr('data-itemvariable');
    itemVariableLabel = $('#CardNumber93').attr('data-itemvariablelabel');
    itemVariableSellCost = $('#CardNumber93').attr('data-itemvariablesellcost'); // itemSellCost'ile çarpan şeklinde olacak bu sayede tipine göre satışı artıcak
    itemTotalSellCost = (Number(itemVariableSellCost) * Number(itemSellCost))
    var img
    if (caseType == "coin") { img = coinIMG } else if (caseType == "prisma") { img = prisma_IMG }

    // SETTINGS =>
    $('.case-opening-side-cong-side').css({'background':'linear-gradient(1deg, '+itemColor+' 2%, #00000077 68%)'});
    
    // $('.coinIconIMG').css({'background-image':'url('+img+')'});;
    $('.case-opening-side-cong-side-itemType').css({'background':itemColor});
    $('.case-opening-side-cong-side-itemIMG').css({'background-image':'url('+itemImage+')'});
    $('.case-opening-side-cong-side-header').text(Locales.caseCongratulations);
    $('.case-opening-side-cong-side-itemType').text(itemVariableLabel);
    $('.sell').html(Locales.caseSellItem + ' | '+ itemTotalSellCost +"<div class='coinIconIMG' style='background-image:url("+img+")'></div>");
    $('.take').text(Locales.caseTakeItem);

    $('.raffle-roller-container').css({
        transition: "all .8s cubic-bezier(.08,.6,0,1)"
    });
    $(".raffle-roller-container").css("margin-left", "-12000px"); // ! Random hesaplanıp eğer ki o yol olmazsa sadece belirli item çıkacak şekilde ayarlanacak, çıkan her zaman 66.'ncı item oluyor
    setTimeout(() => {
        $('#CardNumber93').css({
            "scale": "1.1",
            "border":"2px solid lightgreen",
            "box-shadow":"3px 6px 81px rgb(82, 255, 114)",
        });
    }, 800);
    setTimeout(() => {
        showMenus("openingCongSide", "case-opening-side-cong-side")
    }, 930);
}
    

var side = {}

showMenus = function(elementSide,elementName) {
    console.log('showMenus =>', elementSide, elementName, side["openingSide"]);
    if (elementSide == "openingSide") {
        if (side[elementSide] == undefined ){
            side[elementSide] = false
        }
        console.log('SIDE ELEMETNZ>',side[elementSide]);
        if (side[elementSide] == false) {
            $("."+elementName+"").removeClass("animate__animated animate__fadeOutDown");
            $("."+elementName+"").addClass("animate__animated animate__fadeInDown");
            side[elementSide] = true
            console.log('showMenus1 =>', elementSide, elementName, side["openingSide"]);
            $('.case-screen-wrapper').css({'overflow-y':'hidden'});
            
             $('.case-screen-wrapper').scrollTop($("."+elementName+"")[0].scrollHeight)

            $("."+elementName+"").css({'display':'block'});
        } else {
            $("."+elementName+"").removeClass("animate__animated  animate__fadeOutDown");
            $("."+elementName+"").addClass("animate__animated animate__fadeInDown");
            side[elementSide] = false
            $("."+elementName+"").css({'display':'none'});
            console.log('showMenus2 =>', elementSide, elementName, side["openingSide"]);
            $('.case-screen-wrapper').css({'overflow-y':'scroll'});


        }
    }
    if (elementSide == "openingCongSide") {
        if (side[elementSide] == undefined ){
            side[elementSide] = false
        }
        if (side[elementSide] == false) {
            $("."+elementName+"").removeClass("animate__animated animate__bounceOutDown");
            $("."+elementName+"").addClass("animate__animated animate__bounceInDown");
            side[elementSide] = true
            $("."+elementName+"").css({'display':'block'});
        } else {
            $("."+elementName+"").removeClass("animate__animated  animate__bounceOutDown");
            $("."+elementName+"").addClass("animate__animated animate__bounceInDown");
            side[elementSide] = false
            $("."+elementName+"").css({'display':'none'});
        }
    }
}


SetNotify = function(status, text) {
    // $('.notify-wrapper').animate({'display': 'block'});
    console.log('[ SetNotify ]', status, text)
    $('.notify-box-label').text(text)
    if (status == "succses"){
        $('.notify-wrapper').css({'background': '#5db74c','box-shadow': '10px -3px 55px #73f783'});
    } else if (status == "error") {
        $('.notify-wrapper').css({'background': '#ff5959','box-shadow': '10px -3px 55px #ff5959'});
    }
    setTimeout(() => {
        $('.notify-wrapper').fadeIn(200);
    }, 500);
    setTimeout(() => {
        $('.notify-wrapper').fadeOut(700);
    }, 2500);
}