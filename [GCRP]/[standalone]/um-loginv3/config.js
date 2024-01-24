UM = {}

// ? Main Settings
UM.MainSettings = {
    color: '#bb55da', // Todo: https://www.color-hex.com/
    opacity: 1, // 0 close background opacity, | 0.7 low background opacity,
    logo: "assets/images/logo.png",
    logowidth: 9,
    extra: {
        autoRGB: false,
        autoSnow: false,
    },
}

UM.BackgroundSettings = {

    musicBackground: {
        enabled: true,
        link: "assets/audio/audio.mp3",
        volume: 0.3
    },

    videoBackground: {
        defaultVID: {
            enabled: false,                 
            link: "assets/video/video.mp4", // ? if you want the video in the showcase download it here and put it in the assets > video folder
                                            // ? https://cdn.discordapp.com/attachments/627254815252152331/1077573043771166810/video.mp4
        },                                  // ? youtubeVID is recommended instead because the file size is high (100MB)
        youtubeVID: {
            enabled: false,
            link: "https://www.youtube.com/watch?v=NK5WxKd6kC4",
        },
    },

    imageBackground: {
        defaultIMG: {
            link: "assets/images/bg/bg.jpg",
        },
        randomIMG: {
            enabled: false,
            imglist: ['bg1.jpg','bg2.png','bg3.jpg'],
        },
    }
}

// ? Cards
UM.Store = {
    title: 'STORE',
    description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    button: 'VIEW STORE',
    character_image: 'assets/images/characters/char-girl.png',
    url: "https://uyuyorumstore.com",
}

UM.AboutUs = {
    enabled: false, // ? If you want to cancel the store, set it to true.
    title: 'ABOUT US',
    description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    button: 'VIEW ABOUT',
    character_image: 'assets/images/characters/char-girl.png',
    content: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
}

UM.ChangeLog = {
    title: 'CHANGELOG',
    description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    button: 'VIEW CHANGELOG',
    character_image: 'assets/images/characters/char-man.png',
    page: {
        content: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        // ? If you want the content part as multiple lines, you need to enable it in the lines section.
        // content: [
        //     "[ 🍕 ] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        //     "[ 🍕 ] Lorem Ipsum is simply dummy text of the printing and typesetting industry",
        //     "[ 🍕 ] Lorem Ipsum is simply dummy text of the printing and typesetting industry",
        //     "[ 🍕 ] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        // ],
    },
    // ? if you want to use github, you need to enable it in the github section 
    // ! Attention: Make sure you enter the information you created in your github account correctly
    // Todo: https://streamable.com/nsv7dx
    github: {
        enabled: false,
        username: 'alp1x',
        repository: 'um-loadingscreen',
        branch: 'main',
        path: 'newupdates',
    },
    url: {
        enabled: false,
        link: "https://uyuyorumstore.com",
    }
}

UM.PlayerOfTheMonth = {
    enabled: true,
    title: "PLAYER OF THE MONTH",
    playerimg: "assets/images/player/playerbest.png",
    playername: "Rosalind Norris"
}

UM.UserSocial = {
    discord: true,
    steam: true,
}

UM.Settings = {
    title: "SETTINGS",
    loading: "LOADING ASSETS",
}

UM.RandomInfo = {
    time: 3000,
    text: [
        "🎉[1] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🥳[2] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🥳[3] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🎉[4] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🥳[5] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🎉[6] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🥳[7] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🎉[8] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🥳[9] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ]
}