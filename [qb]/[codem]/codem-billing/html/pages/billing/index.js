import importTemplate from "../../js/util/importTemplate.js";

export default {
    template: await importTemplate("pages/billing/index.html"),

    components: {},
    data: () => ({
        billDeatils: false,
        paybutton: false,
        currentBillButton: [],
        oldBillingData: false,
        animationTable: {
            blueborder: false,
            whitebackground: false,
            paidText: false
        },
        showTooltip: null,
        billingDataSearchBarInputValue: "",
        totalModal: false,
        allBills: false,
        allowJobs: false,
        allowSearchJobs: false,
        societyBillingData: false,
        currentBillButtonValue: false,
        sortBox: false,
        payWithInoviceValue: false,
        payWithInoviceValueInput: "",
        findedInvoice: false,
        searchBillValue: "",
        searchFoundValue: true
    }),
    methods: {
        async payWithInoviceValueButton() {
            this.$store.dispatch("soundPlay", "click.wav");
            if (this.payWithInoviceValueInput.length <= 0) return;

            let data = await postNUI("checkInvoice", { invoice: this.payWithInoviceValueInput });
            if (Object.keys(data).length <= 0) return;
            this.findedInvoice = data;
        },
        payWithInvoiceId() {
            this.payWithInoviceValue = true;
        },
        async cancelBilling(data) {
            this.$store.dispatch("soundPlay", "click.wav");
            let reponse = await postNUI("cancelBilling", { id: data });

            let dataArray = [].concat(...Object.values(reponse));
            if (Object.keys(dataArray).length <= 0) {
                this.oldBillingData = false;
                return;
            } else {
                this.oldBillingData = false;
                if (this.currentBillButtonValue == "societyunpaid") {
                    this.oldBillingData = false;
                    let filteredData = dataArray.filter(billing => billing.status === "unpaid");
                    setTimeout(() => {
                        this.oldBillingData = filteredData;
                    }, 250);
                } else {
                    setTimeout(() => {
                        this.oldBillingData = dataArray;
                    }, 250);
                }
            }
        },
        async cancelMyBilling(data) {
            this.$store.dispatch("soundPlay", "click.wav");
            let reponse = await postNUI("cancelmybilling", { id: data });
            let dataArray = [].concat(...Object.values(reponse));
            if (Object.keys(dataArray).length <= 0) {
                return;
            } else {
                this.oldBillingData = false;
                setTimeout(() => {
                    let filteredData = dataArray.filter(billing => billing.societyname == "identifier");
                    this.oldBillingData = filteredData;
                }, 250);
            }
        },
        async jobcancelBilling(data) {
            this.$store.dispatch("soundPlay", "click.wav");
            let reponse = await postNUI("cancelBillingjob", { id: data });
            let dataArray = [].concat(...Object.values(reponse));
            if (Object.keys(dataArray).length <= 0) {
                return;
            } else {
                this.oldBillingData = false;
                if (this.currentBillButtonValue == "societyunpaid") {
                    this.oldBillingData = false;
                    let filteredData = dataArray.filter(
                        billing => billing.status === "unpaid" && billing.societyname === this.$store.state.billingpage.playerjob
                    );
                    setTimeout(() => {
                        this.oldBillingData = filteredData;
                    }, 250);
                } else if (this.currentBillButtonValue == "society") {
                    this.oldBillingData = false;
                    let filteredData2 = dataArray.filter(billing => billing.societyname === this.$store.state.billingpage.playerjob);

                    setTimeout(() => {
                        this.oldBillingData = filteredData2;
                    }, 250);
                } else {
                    this.oldBillingData = false;
                    setTimeout(() => {
                        this.oldBillingData = dataArray;
                    }, 250);
                }
            }
        },

        openFilterIcon() {
            this.sortBox = !this.sortBox;
        },
        sortData(val) {
            this.$store.dispatch("soundPlay", "click.wav");
            if (val == "latest") {
                this.oldBillingData.sort((a, b) => {
                    return new Date(b.date) - new Date(a.date);
                });
            } else {
                this.oldBillingData.sort((a, b) => {
                    return new Date(a.date) - new Date(b.date);
                });
            }
        },
        createInvoice() {
            this.$store.dispatch("soundPlay", "click.wav");
            this.$store.state.activePage = "createbillingpage";
        },
        showBillDetails(val) {
            this.billDeatils = val;
        },
        payAllBills() {
            let filterData = this.oldBillingData.filter(bill => bill.status == "unpaid");
            if (filterData.length <= 0) {
                return;
            } else {
                this.totalModal = true;
                this.allBills = this.$store.state.billingpage.billingData.filter(bill => bill.status == "unpaid");
                this.$store.dispatch("soundPlay", "mbillingpay.mp3");
            }
        },

        async payBill() {
            if (!this.billDeatils) return;
            this.$store.dispatch("soundPlay", "click.wav");
            let response = await postNUI("payBill", this.billDeatils);
            this.oldBillingData = false;
            if (response) {
                this.paybutton = true;
                this.animationTable.blueborder = true;
                this.animationTable.whitebackground = true;
                this.animationTable.paidText = true;
                setTimeout(() => {
                    this.oldBillingData = response;
                    this.$store.state.billingpage.billingData = response;
                    this.$store.dispatch("soundPlay", "mbillingpay.mp3");
                }, 250);
            }
        },
        async payFindInvoice() {
            if (!this.findedInvoice) return;
            this.$store.dispatch("soundPlay", "click.wav");
            let response = await postNUI("payBillFind", this.findedInvoice);
            this.oldBillingData = false;
            if (response) {
                this.paybutton = true;
                this.animationTable.blueborder = true;
                this.animationTable.whitebackground = true;
                this.animationTable.paidText = true;
                setTimeout(() => {
                    this.oldBillingData = response;
                    this.$store.state.billingpage.billingData = response;
                }, 250);
            }
        },

        closePayModal() {
            this.payWithInoviceValue = false;
            this.totalModal = false;
            this.paybutton = false;
            this.billDeatils = false;
            this.findedInvoice = false;
            this.animationTable.blueborder = false;
            this.animationTable.whitebackground = false;
            this.animationTable.paidText = false;
        },
        async payAllButton() {
            this.$store.dispatch("soundPlay", "click.wav");
            let response = await postNUI("payAllBills");
            if (Object.keys(response).length <= 0) return;
            this.paybutton = true;
            this.animationTable.blueborder = true;
            this.animationTable.whitebackground = true;
            this.animationTable.paidText = true;
            this.$store.state.billingpage.billingData = false;
            this.oldBillingData = false;
            setTimeout(() => {
                this.oldBillingData = response;
                this.paybutton = true;
                this.$store.state.billingpage.billingData = response;
            }, 500);
        },
        async changeCategory(val) {
            if (val == this.currentBillButtonValue) return;
            this.searchFoundValue = true;
            this.$store.dispatch("soundPlay", "click.wav");
            this.currentBillButtonValue = val;
            for (let key in this.currentBillButton) {
                if (key != val) {
                    this.currentBillButton[key] = false;
                }
            }
            if (val == "paid") {
                this.oldBillingData = false;
                let data = await postNUI("getMyBillingData");
                if (Object.keys(data).length <= 0) {
                    this.currentBillButton[val] = !this.currentBillButton[val];
                    return;
                } else {
                    setTimeout(() => {
                        let filteredData = this.$store.state.billingpage.billingData.filter(billing => billing.status === "paid");

                        this.oldBillingData = filteredData;
                    }, 150);
                }
            }
            if (val == "unpaid") {
                this.oldBillingData = false;
                let data = await postNUI("getMyBillingData");
                if (Object.keys(data).length <= 0) {
                    this.currentBillButton[val] = !this.currentBillButton[val];
                    return;
                } else {
                    setTimeout(() => {
                        let filteredData = this.$store.state.billingpage.billingData.filter(billing => billing.status === "unpaid");
                        this.oldBillingData = filteredData;
                    }, 150);
                }
            }
            if (val == "all") {
                this.oldBillingData = false;
                let data = await postNUI("getMyBillingData");
                if (Object.keys(data).length <= 0) {
                    this.currentBillButton[val] = !this.currentBillButton[val];
                    return;
                } else {
                    setTimeout(() => {
                        this.oldBillingData = data;
                        this.$store.state.billingpage.billingData = data;
                    }, 150);
                }
            }
            if (val == "society") {
                this.oldBillingData = false;
                let data = await postNUI("getSocietyBills", { society: this.allowJobs });

                if (Object.keys(data).length <= 0) {
                    this.currentBillButton[val] = !this.currentBillButton[val];
                    return;
                }
                setTimeout(() => {
                    this.oldBillingData = data;
                }, 150);
            }
            if (val == "societyunpaid") {
                this.oldBillingData = false;
                let data = await postNUI("getSocietyBills", { society: this.allowJobs });
                if (Object.keys(data).length <= 0) {
                    this.currentBillButton[val] = !this.currentBillButton[val];
                    return;
                }
                let filteredData = data.filter(billing => billing.status === "unpaid");
                this.oldBillingData = filteredData;
            }
            if (val == "societypaid") {
                this.oldBillingData = false;
                let data = await postNUI("getSocietyBills", { society: this.allowJobs });
                if (Object.keys(data).length <= 0) {
                    this.currentBillButton[val] = !this.currentBillButton[val];
                    return;
                }
                let filteredData = data.filter(billing => billing.status === "paid");
                this.oldBillingData = filteredData;
            }
            if (val == "createdinvoices") {
                this.oldBillingData = false;
                let data = await postNUI("getAllSociety");
                if (Object.keys(data).length <= 0) {
                    this.currentBillButton[val] = !this.currentBillButton[val];
                    return;
                }

                this.oldBillingData = data;
            }
            if (val == "mybill") {
                this.oldBillingData = false;
                let data = await postNUI("getMyAllBillingData");
                if (Object.keys(data).length <= 0) {
                    this.currentBillButton[val] = !this.currentBillButton[val];
                    return;
                }
                this.oldBillingData = data;
            }
            if (val == "searchbill") {
                this.oldBillingData = false;
                this.searchFoundValue = false;
            }

            this.currentBillButton[val] = !this.currentBillButton[val];
        },
        async searchBill() {
            this.oldBillingData = false;
            if (this.searchBillValue.trim().length <= 0) return;
            const numberValue = parseFloat(this.searchBillValue);

            if (isNaN(numberValue)) {
                let response = await postNUI("searchBillName", { name: this.searchBillValue });
                if (Object.keys(response).length <= 0) {
                    // this.currentBillButton[val] = !this.currentBillButton[val];
                    this.searchBillValue = "";
                    this.searchFoundValue = false;
                    return;
                } else {
                    setTimeout(() => {
                        this.searchFoundValue = true;
                        this.searchBillValue = "";
                        this.oldBillingData = response;
                        this.$store.state.billingpage.billingData = response;
                    }, 150);
                }
            } else {
                let response = await postNUI("searchBill", { id: numberValue });
                if (Object.keys(response).length <= 0) {
                    // this.currentBillButton[val] = !this.currentBillButton[val];
                    this.searchBillValue = "";
                    this.searchFoundValue = false;
                    return;
                } else {
                    setTimeout(() => {
                        this.searchFoundValue = true;
                        this.searchBillValue = "";
                        this.oldBillingData = response;
                        this.$store.state.billingpage.billingData = response;
                    }, 150);
                }
            }
        },
        closeMenu() {
            this.$store.dispatch("soundPlay", "click.wav");
            postNUI("close", {});
            this.$store.state.activePage = "";
            this.closePayModal;
        },

        eventHandler(event) {
            switch (event.data.action) {
                case "updateBillData":
                    this.oldBillingData = event.data.payload;
                    this.$store.state.billingpage.billingData = event.data.payload;
                    break;
                default:
                    break;
            }
        },
        handleButtonClick(data) {
            this.$store.dispatch("soundPlay", "click.wav");
            if (this.buttonActionType === "cancelBilling") {
                if (this.currentBillButtonValue == "societyunpaid" || this.currentBillButtonValue == "society") {
                    this.jobcancelBilling(data.uniqueid);
                }
                if (this.currentBillButtonValue == "createdinvoices") {
                    this.cancelBilling(data.uniqueid);
                }
                if (this.currentBillButtonValue == "mybill") {
                    this.cancelMyBilling(data.uniqueid);
                }
            } else {
                this.showBillDetails(data);
            }
        }
    },

    computed: {
        filterByTermBillingData() {
            if (this.billingDataSearchBarInputValue.length > 0) {
                if (!this.oldBillingData || this.oldBillingData.length <= 0) {
                    return this.oldBillingData;
                }
                return this.oldBillingData.filter(name => {
                    return (
                        name.id.toString().toLowerCase().includes(this.billingDataSearchBarInputValue.toLowerCase()) ||
                        name.targetname.toLowerCase().includes(this.billingDataSearchBarInputValue.toLowerCase()) ||
                        name.name.toLowerCase().includes(this.billingDataSearchBarInputValue.toLowerCase()) ||
                        name.invoicelabel.toLowerCase().includes(this.billingDataSearchBarInputValue.toLowerCase()) ||
                        name.uniqueid.toLowerCase().includes(this.billingDataSearchBarInputValue.toLowerCase())
                    );
                });
            } else {
                return this.oldBillingData;
            }
        },
        getTotalUnpaidBillPrice() {
            let total = 0;
            if (this.$store.state.billingpage.billingData.length > 0) {
                this.$store.state.billingpage.billingData.forEach(bill => {
                    if (bill.status == "unpaid") {
                        let kdv = parseFloat(bill.amount) * this.$store.state.billingpage.tax;
                        total += kdv;
                        total += parseFloat(bill.amount);
                    }
                });
            }
            return total + "$";
        },
        getTotalUnpaidBillAmount() {
            let total = 0;
            if (this.$store.state.billingpage.billingData.length > 0) {
                this.$store.state.billingpage.billingData.forEach(bill => {
                    if (bill.status == "unpaid") {
                        total += 1;
                    }
                });
            }

            return total;
        },
        allPayTotalBillsPercent() {
            let total = 0;
            this.allBills.forEach(bill => {
                total += parseFloat(bill.amount);
            });

            let kdv = total * this.$store.state.billingpage.tax;
            return kdv;
        },
        allPayTotalBills() {
            let total = 0;
            this.allBills.forEach(bill => {
                total += parseFloat(bill.amount);
            });

            return total;
        },
        isAdmin() {
            return this.$store.state.billingpage.playerAccount.admin;
        },
        buttonActionType() {
            if (this.isAdmin && this.currentBillButtonValue === "createdinvoices") return "cancelBilling";
            if (this.currentBillButtonValue === "society" || this.currentBillButtonValue === "societyunpaid") return "cancelBilling";
            if (this.currentBillButtonValue === "mybill") return "cancelBilling";
            return "showBillDetails";
        },
        buttonText() {
            return this.buttonActionType === "cancelBilling" ? this.$store.state.Locales["CANCEL"] : this.$store.state.Locales["PAY"];
        },
        buttonTextStyle() {
            let baseStyle = "font-family: sf-pro-rounded-medium; font-size: 0.8vw;";
            return this.buttonActionType === "cancelBilling" ? baseStyle + "color: #ff6565" : baseStyle + "color: black";
        },
        buttonClass() {
            return {
                "w-[90%]": true,
                "h-[45%]": true,
                flex: true,
                "items-center": true,
                "justify-center": true,
                "cursor-pointer": true
            };
        },
        formatDate() {
            const date = new Date();
            const monthNames = [
                "January",
                "February",
                "March",
                "April",
                "May",
                "June",
                "July",
                "August",
                "September",
                "Octomber",
                "November",
                "December"
            ];
            return `${date.getDate()} ${monthNames[date.getMonth()]} ${date.getFullYear()} ${date.getHours()}:${date.getMinutes()}`;
        }
        // ...Vuex.mapState({
        //     Locales: state => state.Locales
        // })
    },

    watch: {},

    mounted() {
        window.addEventListener("message", this.eventHandler);
        this.oldBillingData = this.$store.state.billingpage.billingData;

        if (this.$store.state.billingpage.allowJobs) {
            for (let key in this.$store.state.billingpage.allowJobs) {
                if (key == this.$store.state.billingpage.playerjob) {
                    this.allowJobs = key;
                }
            }
        }
        if (this.$store.state.billingpage.allowSearchJobs) {
            for (let key in this.$store.state.billingpage.allowSearchJobs) {
                if (key == this.$store.state.billingpage.playerjob) {
                    this.allowSearchJobs = key;
                }
            }
        }

        this.changeCategory("all");
    },
    beforeDestroy() {
        window.removeEventListener("message", this.eventHandler);
    }
};
