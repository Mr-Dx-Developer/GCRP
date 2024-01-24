UM = {}

// ? Main Settings
UM.MainSettings = {
    color: '#bb55da', // Todo: https://www.color-hex.com/
    opacity: 1, // 0 close background opacity, | 0.7 low background opacity,
    logo: "assets/images/baner.png",
    logowidth: 50,
    extra: {
        autoRGB: false,
        autoSnow: false,
    },
}

UM.BackgroundSettings = {

    musicBackground: {
        enabled: true,
        link: "assets/audio/audio.mp3",
        volume: 0.4
    },

    videoBackground: {
        defaultVID: {
            enabled: false,                 
            link: "https://cdn.discordapp.com/attachments/1114458557883093022/1160822490562576394/GTA_5_-_Cinematic_Film.mp4?ex=65360f30&is=65239a30&hm=ae534a486c3f94445dc55ae943c3d357adfae8702f8b6b6584e7c13de5063673&", // ? if you want the video in the showcase download it here and put it in the assets > video folder
                                            // ? https://cdn.discordapp.com/attachments/627254815252152331/1077573043771166810/video.mp4
        },                                  // ? youtubeVID is recommended instead because the file size is high (100MB)
        youtubeVID: {
            enabled: true,
            link: "https://www.youtube.com/watch?v=Awgpquzwwz0",
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
    description: 'Our Store is Avaiable NOW!',
    button: 'VIEW STORE',
    character_image: 'assets/images/characters/char-girl.png',
    url: "https://goldencityrp.tebex.io/",
}

UM.AboutUs = {
    enabled: false, // ? If you want to cancel the store, set it to true.
    title: 'ABOUT US',
    description: '',
    button: 'VIEW ABOUT',
    character_image: 'assets/images/characters/char-girl.png',
    content: 'Mr_Dx does all the development work on the server.',
}

UM.ChangeLog = {
    title: 'CHANGELOG',
    description: '',
    button: 'VIEW CHANGELOG',
    character_image: 'assets/images/characters/char-man.png',
    page: {
        
        // ? If you want the content part as multiple lines, you need to enable it in the lines section.
     content: [
            "[ 🍕 ] New Phone.",
            "[ 🍕 ] Charecture Create",
            "[ 🍕 ] Custom Cars",
            "[ 🍕 ] Custom Sound.",
    ],
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
        "🎉[1] Welcome Golden City Roleplay",
        "🥳[2] It's not just a game, it's your reality.",
        "🥳[3] A new adventure every time.",
        /* "🎉[4] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🥳[5] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🎉[6] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🥳[7] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🎉[8] Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "🥳[9] Lorem Ipsum is simply dummy text of the printing and typesetting industry.", */
    ]
}