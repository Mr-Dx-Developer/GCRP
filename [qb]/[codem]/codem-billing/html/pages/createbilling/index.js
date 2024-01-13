import importTemplate from "../../js/util/importTemplate.js";

export default {
    template: await importTemplate("pages/createbilling/index.html"),

    components: {},
    data: () => ({
        invoiceData: {
            from: "myjob",
            reason: null,
            note: null,
            targetPlayerId: null,
            amount: null
        },
        bills: [],
        showNearbyPlayers: false,
        showInvoiceReasons: false,
        nearbyPlayers: [],
        dateFormat: "",
        dueDateFormat: "",
        interval: null,
        dueDate: 7,
        findBillingPlayerValue: false
    }),
    methods: {
        setInvoiceData(payload) {
            if (payload.value == "personal") {
                if (!this.$store.state.billingpage.personelAccount) {
                    postNUI("sendnotification");
                    return;
                }
            }

            this.invoiceData[payload.type] = payload.value;
        },
        formatNum(num) {
            if (num < 10) {
                num = "0" + num;
            }
            return num;
        },
        eventHandler(event) {
            switch (event.data.action) {
                case "setBills":
                    this.bills = event.data.payload;
                    break;
                default:
                    break;
            }
        },
        CreateBill() {
            postNUI("CreateBill", {
                from: this.invoiceData.from,
                reason: this.invoiceData.reason,
                note: this.invoiceData.note,
                targetId: this.invoiceData.targetPlayerId,
                amount: this.invoiceData.amount
            });
        },
        async findBillingPlayer(val) {
            if (val && val.length > 0) {
                let data = await postNUI("findBillingPlayer", { id: val });

                this.findBillingPlayerValue = data;
                this.invoiceData.targetPlayerId = this.findBillingPlayerValue.id;

                // this.nearbyPlayers = data;
            }
        }
    },

    computed: {
        ...Vuex.mapState({
            Locales: state => state.Locales
        })
    },

    watch: {
        async showNearbyPlayers(show) {
            if (show) {
                let data = await postNUI("getNearbyPlayers");
                this.nearbyPlayers = data;
            }
        },

        async "invoiceData.amount"(val) {
            if (!isNaN(this.invoiceData.amount)) {
                this.invoiceData.amount = Number(this.invoiceData.amount);
            }
        }
    },

    mounted() {
        window.addEventListener("message", this.eventHandler);
        const dueDate = new Date();
        dueDate.setDate(dueDate.getDate() + this.dueDate);
        this.dueDateFormat = `${this.formatNum(dueDate.getDate())}.${this.formatNum(
            dueDate.getMonth() + 1
        )}.${dueDate.getFullYear()} ${this.formatNum(dueDate.getHours())}:${this.formatNum(dueDate.getMinutes())}`;

        const date = new Date();
        this.dateFormat = `${this.formatNum(date.getDate())}.${this.formatNum(date.getMonth() + 1)}.${date.getFullYear()} ${this.formatNum(
            date.getHours()
        )}:${this.formatNum(date.getMinutes())}`;
        this.interval = setInterval(() => {
            const date = new Date();
            this.dateFormat = `${this.formatNum(date.getDate())}.${this.formatNum(date.getMonth() + 1)}.${date.getFullYear()} ${this.formatNum(
                date.getHours()
            )}:${this.formatNum(date.getMinutes())}`;
            const dueDate = new Date();
            dueDate.setDate(dueDate.getDate() + this.dueDate);
            this.dueDateFormat = `${this.formatNum(dueDate.getDate())}.${this.formatNum(
                dueDate.getMonth() + 1
            )}.${dueDate.getFullYear()} ${this.formatNum(dueDate.getHours())}:${this.formatNum(dueDate.getMinutes())}`;
        }, 1000);
        setTimeout(async () => {
            postNUI("getBills");

            let date = await postNUI("getDueDate");
            this.dueDate = date;
        }, 1000);
    },
    beforeDestroy() {
        clearInterval(this.interval);
        window.removeEventListener("message", this.eventHandler);
    }
};
