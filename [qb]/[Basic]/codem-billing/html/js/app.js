import billingModule from "./modules/billingModule.js";
import createbillingModule from "./modules/createbillingModule.js";

let audioPlayer = null;
const Modules = {
    billingpage: billingModule,
    createbillingpage: createbillingModule
};

import billingpage from "../pages/billing/index.js";
import createbillingpage from "../pages/createbilling/index.js";

const store = Vuex.createStore({
    components: {
        billingpage: billingpage,
        createbillingpage: createbillingpage
    },

    state: {
        activePage: "",
        notifications: [],
        timeout: false,
        Locales: false
    },
    getters: {},
    mutations: {},
    actions: {
        soundPlay({ state }, val) {
            clicksound(val);
        },
        notification({ state }, text) {
            const timeout = 10000;
            let id = Date.now();
            if (state.notifications.length > 0) {
                if (state.timeout) {
                    clearTimeout(state.timeout);
                    state.timeout = false;
                }
                state.notifications = [];
            }
            state.notifications.push({
                id: id,
                text: text,
                timeout: timeout
            });
            state.timeout = setTimeout(() => {
                state.notifications = state.notifications.filter(notification => notification.id != id);
            }, timeout);
        }
    },

    modules: Modules
});

const app = Vue.createApp({
    components: {
        billingpage: billingpage,
        createbillingpage: createbillingpage
    },
    data: () => ({
        props: ['mode'],
    }),
    computed: {
        ...Vuex.mapState({
            activePage: state => state.activePage,
            notifications: state => state.notifications,
            Locales: state => state.Locales
        })
    },

    watch: {},

    beforeDestroy() {
        window.removeEventListener("keyup", this.updateNavbarActive);
    },
    mounted() {
        window.addEventListener("keyup", this.keyHandler);
        window.addEventListener("message", this.eventHandler);
    },

    methods: {
        ...Vuex.mapMutations({}),

        keyHandler(e) {
            if (e.which == 27) {
                this.$store.state.activePage = "";
                postNUI("close");
            }
        },

        eventHandler(event) {
            switch (event.data.action) {
                case "CHECK_NUI":
                    postNUI("loaded");
                    break;
                case "openBillingMenu":
                    this.$store.state.activePage = "billingpage";
                    this.$store.state.billingpage.billingData = event.data.payload.billingData;
                    this.$store.state.billingpage.playerAccount.money = event.data.payload.playerData.money;
                    this.$store.state.billingpage.playerAccount.name = event.data.payload.playerData.name;
                    this.$store.state.billingpage.playerAccount.avatar = event.data.payload.playerData.avatar;
                    this.$store.state.billingpage.playerAccount.admin = event.data.payload.playerData.isAdmin;

                    break;
                case "updateMoney":
                    this.$store.state.billingpage.playerAccount.money = event.data.payload;
                    break;
                case "configDefaulTax":
                    this.$store.state.billingpage.tax = event.data.payload;
                    break;
                case "locales":
                    this.$store.state.Locales = event.data.payload;

                    break;
                case "configAllowJobs":
                    this.$store.state.billingpage.allowJobs = event.data.payload;
                    break;
                case "confirSearchBill":
                    this.$store.state.billingpage.allowSearchJobs = event.data.payload;
                    break;
                case "playerJob":
                    this.$store.state.billingpage.playerjob = event.data.payload.job;
                    this.$store.state.billingpage.playerjoblabel = event.data.payload.job_grade_name;
                    break;
                case "configAdmin":
                    this.$store.state.billingpage.admin = event.data.payload;
                    break;
                case "showNotify":
                    this.$store.dispatch("notification");
                    break;
                case "refreshPage":
                    if (this.$store.state.activePage == "createbillingpage") {
                        this.$store.state.activePage = "billingpage";
                        this.$store.dispatch("soundPlay", "mbillingcreate.wav");
                    }

                    break;
                case "configPersonelAccount":
                    this.$store.state.billingpage.personelAccount = event.data.payload;
                    break;
                default:
                    break;
            }
        }
    }
});

app.use(store).mount("#app");
var resourceName = "codem-billing";

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
                "Content-Type": "application/json"
            },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch (error) {
        // console.log(error)
    }
};

function clicksound(val) {
    let audioPath = `./sound/${val}`;
    audioPlayer = new Howl({
        src: [audioPath]
    });
    audioPlayer.volume(0.4);
    audioPlayer.play();
}
