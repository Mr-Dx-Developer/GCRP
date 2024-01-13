const store = Vuex.createStore({
  state: {},
  mutations: {},
  actions: {},
});
let audioPlayer = null;
const app = Vue.createApp({
  data: () => ({
    show: true,
    registerPage: false,
    charactersData: "",
    animleftContainer: false,
    currentCharacterData: false,
    slotNumber: 0,
    tebexSlotPopup: false,
    selectedPopup: [],
    steamName: "",
    steamProfile: "",
    steamID: "",
    nameValue: "",
    surnameValue: "",
    birthdayValue: "",
    heightValue: "",
    genderValue: "",
    nationalityValue: "",
    cid: 0,
    currentCid: "",
    selectedCid: "",
    tbxID: "",
    viewedCharacters: [],
    viewedCharacters2: [],
    deletePopup: false,
    dataLoaded: false,
    isError: false,
    errorMessage: "",
    forbiddenSymbols: [
      "!",
      "@",
      "#",
      "$",
      "%",
      "^",
      "&",
      "*",
      "(",
      ")",
      "+",
      "=",
    ],
    displayMessage: "",
    Locales: "",
    isError: false,
    serverLogo: "",
    EnableDeleteButton: "",
    loadingContainer: false,
    dateFormat: "",
  }),

  methods: {
    onNumericInput() {
      this.numericValue = this.numericValue.replace(/[^0-9]/g, "");
    },
    playClickSound() {
      clicksound("click.mp3");
    },
    shouldShowCharacter(slotId) {
      return (
        !this.viewedCharacters.includes(slotId) && this.getCharacter(slotId)
      );
    },
    getCharacter(slotId, bool) {
      setTimeout(() => {
        $(".loading-container").fadeOut(300);
        this.loadingContainer = false;
      }, 1000);
      if (!this.loadingContainer) {
        if (bool) {
          const character = this.charactersData.find(
            (info) => info.cid === slotId
          );
          if (character) {
            return character;
          }
          return null;
        } else {
          const character = this.charactersData.find(
            (info) => info.cid === slotId
          );
          if (character) {
            return character.job.name;
          }
          return null;
        }
      }
    },

    handleCharacterClick(slotId) {
      const character = this.getCharacter(slotId);
      if (character) {
        this.currentCharacterDataValue(character, slotId);
        this.viewedCharacters.push(slotId);
      }
    },

    setGender(value) {
      this.genderValue = value;
    },
    joinGame() {
      postNUI("Play", {
        charData: this.currentCharacterData,
      });
      this.show = false;
      this.selectedPopup = [];
      this.selectedCid = "";
      this.viewedCharacters = [];
      this.currentCharacterData = false;
    },
    tebexSlot() {
      this.tebexSlotPopup = true;
    },
    openRegister(slot, tebexSlot) {
      if (!this.loadingContainer) {
        this.selectedCid = slot;

        if (tebexSlot) {
          this.tebexSlotPopup = true;
          this.registerPage = false;
          postNUI("SetAnimations", {
            // charData : this.currentCharacterData,
            toggle: false,
          });
        } else {
          (this.show = false), (this.registerPage = true);
          postNUI("SetAnimations", {
            // charData : this.currentCharacterData,
            toggle: false,
          });
        }
        postNUI("ChangeCam", {});
      }
    },
    checkTebex() {
      postNUI("checkTebex", {
        tbxid: this.tbxID,
        cid: this.selectedCid,
      });
    },
    createCharacter() {
      if (
        this.genderValue.toString() !== "0" &&
        this.genderValue.toString() !== "1"
      ) {
        this.displayMessage = this.Locales["registerError"];
        this.isError = true;
        return;
      }
      if (this.nationalityValue === "") {
        this.displayMessage = this.Locales["registerError"];
        this.isError = true;
      } else {
        this.displayMessage = this.Locales["registerVerify"];
      }
      for (const value of [this.nameValue, this.surnameValue]) {
        if (!value || value.trim() === "") {
          this.displayMessage = this.Locales["registerError"];
          return;
        }

        for (const symbol of this.forbiddenSymbols) {
          if (value.includes(symbol)) {
            this.displayMessage = this.Locales["registerError"];
            this.isError = true;
            return;
          }
        }
      }

      if (
        this.heightValue.toString() < "0" ||
        this.heightValue.toString() > "300"
      ) {
        this.displayMessage = this.Locales["registerError"];
        this.isError = true;
        return;
      }

      const dateValue = new Date(this.selectedDate);
      const year = dateValue.getFullYear();

      if (year > 2023 || year.toString().length > 4) {
        this.displayMessage = this.Locales["registerError"];
        this.isError = true;
      } else {
        this.displayMessage = this.Locales["registerVerify"];
      }
      (this.show = false),
        (this.registerPage = false),
        (this.charactersData.cid += 1);
      postNUI("createChar", {
        firstname: this.nameValue,
        lastname: this.surnameValue,
        nationality: this.nationalityValue,
        birthdate: this.birthdayValue,
        height: this.heightValue,
        gender: this.genderValue,
        cid: this.selectedCid,
      });

      this.selectedPopup = [];
      this.selectedCid = "";
      this.viewedCharacters = [];
    },
    openDeletePopUp() {
      if (this.EnableDeleteButton == true) {
        this.deletePopup = true;
      } else {
        this.deletePopup = false;
      }
    },
    cancelCreate() {
      if (this.registerPage) {
        this.registerPage = false;
        this.show = true;
        this.nameValue = "";
        this.surnameValue = "";
        this.heightValue = "";
        this.genderValue = "";
        this.nationalityValue = "";
        this.birthdayValue = "";
        this.displayMessage = "";
        this.isError = false;
        this.currentCharacterData = false;
        this.selectedPopup = [];
        this.selectedCid = "";
        this.viewedCharacters = [];
      } else if (this.tebexSlotPopup) {
        this.tebexSlotPopup = false;
        this.show = true;
        this.tbxID = "";
        this.currentCharacterData = false;
        this.selectedPopup = [];
        this.selectedCid = "";
        this.viewedCharacters = [];
      }
    },
    cancelDelete() {
      this.deletePopup = false;
    },
    deleteCharacter() {
      const charactersDatas = this.charactersData.find(
        (item) => item.citizenid == this.currentCharacterData.citizenid
      );
      postNUI("DeleteCharacter", {
        citizenid: this.currentCharacterData.citizenid,
      });
      this.charactersData.splice(
        this.charactersData.indexOf(charactersDatas),
        1
      );
      this.currentCharacterData = false;
      this.deletePopup = false;
    },
    checkData() {
      if (this.dataLoaded == false) {
        postNUI("loadagain");
        this.dataLoaded = true;
      }
    },
    handleKeyUp: function (e) {
      if (e.key == "Escape") {
        this.cancelCreate();
      }
    },
    currentCharacterDataValue(val, slotNumber) {
      if (!this.loadingContainer) {
        const character = this.getCharacter(val);
        if (character) {
          this.currentCharacterDataValue(character, val);
          this.viewedCharacters.push(val);
        }

        if (val === this.currentCharacterData) {
          this.currentCharacterData = false;
          for (let key in this.selectedPopup) {
            this.selectedPopup[key] = false;
          }
        } else {
          this.currentCharacterData = val;
          if (this.currentCharacterData) {
            this.currentCharacterData = false;
            setTimeout(() => {
              this.currentCharacterData = val;
              for (let key in this.selectedPopup) {
                this.selectedPopup[key] = false;
              }
              this.selectedPopup[slotNumber] = !this.selectedPopup[slotNumber];
              postNUI("SetAnimations", {
                charData: this.currentCharacterData,
                toggle: true,
              });
            }, 250);
          } else {
            this.currentCharacterData = val;
            for (let key in this.selectedPopup) {
              this.selectedPopup[key] = false;
            }
            this.selectedPopup[slotNumber] = !this.selectedPopup[slotNumber];
            postNUI("SetAnimations", {
              charData: this.currentCharacterData,
              toggle: true,
            });
          }
        }
      }
    },
  },
  computed: {
    formattedAge() {
      const birthdateArr =
        this.currentCharacterData.charinfo.birthdate.split("-");
      const birthdateObj = new Date(
        birthdateArr[0],
        birthdateArr[1] - 1,
        birthdateArr[2]
      );
      const now = new Date();

      const ageInMilliseconds = now - birthdateObj;

      const ageDate = new Date(ageInMilliseconds);
      const age = Math.abs(ageDate.getUTCFullYear() - 1970);

      const formattedBirthdate = birthdateObj.toLocaleDateString(
        this.dateFormat,
        {
          day: "numeric",
          month: "long",
          year: "numeric",
        }
      );

      return `${age} ${this.Locales["ageTitle"]} - ${formattedBirthdate}`;
      this.age = formattedBirthdate;
    },
  },

  watch: {
    heightValue: function (newVal) {
      if (newVal !== "" && isNaN(newVal)) {
        this.displayMessage = this.Locales["registerError"];
        this.isError = true;
      }
    },
  },

  beforeDestroy() {},
  mounted() {
    window.addEventListener("load", (event) => {
      this.checkData();
    });
    window.addEventListener("keyup", this.keyHandler);
    window.addEventListener("message", (event) => {
      switch (event.data.message) {
        case "SetChars":
          $(".loading-container").fadeIn(1000);
          this.loadingContainer = true;
          this.show = true;
          this.nameValue = "";
          this.surnameValue = "";
          this.heightValue = "";
          this.genderValue = "";
          this.nationalityValue = "";
          this.birthdayValue = "";
          this.currentCid = event.data.charData.length;
          this.charactersData = event.data.charData;
          this.Locales = event.data.Locales;
          this.slotNumber = event.data.Slots;
          this.serverLogo = event.data.serverLogo;
          this.EnableDeleteButton = event.data.canDelete;
          this.dateFormat = event.data.dateFormat;
        case "SetSteamInfos":
          this.steamName = event.data.name;
          this.steamProfile = event.data.profilephoto;
          this.steamID = event.data.id;
        case "UnlockTebexSlot":
          this.unlockTebex = event.data.cid;
          this.tebexSlotPopup = false;
          if (this.slotNumber) {
            this.slotNumber.forEach((item) => {
              if (item.id === this.unlockTebex) {
                item.tebex = false;
              }
            });
          }

          break;
      }
    });
    setTimeout(() => {
      this.animleftContainer = true;
    }, 2000);
    window.addEventListener("keyup", this.handleKeyUp);
  },

  destroyed() {
    window.removeEventListener("keyup", this.handleKeyUp);
  },
});

app.use(store).mount("#app");

var resourceName = "m-multichar";

if (window.GetParentResourceName) {
  resourceName = window.GetParentResourceName();
}

window.postNUI = async (name, data) => {
  try {
    const response = await fetch(`https://${resourceName}/${name}`, {
      method: "POST",
      mode: "cors",
      cache: "no-cache",
      credentials: "same-origin",
      headers: {
        "Content-Type": "application/json",
      },
      redirect: "follow",
      referrerPolicy: "no-referrer",
      body: JSON.stringify(data),
    });
    return !response.ok ? null : response.json();
  } catch (error) {
    // console.log(error)
  }
};

function clicksound(val) {
  let audioPath = `./${val}`;
  
  if (audioPlayer && audioPlayer.playing()) {
      audioPlayer.stop();
  } else {
      audioPlayer = new Howl({
          src: [audioPath]
      });
      audioPlayer.volume(0.4);
      audioPlayer.play();
  }
}