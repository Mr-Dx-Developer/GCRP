

const Modules = {

};



const store = Vuex.createStore({
    components: {
        
    },
    state: {
        
    },
    getters: {},
    mutations: {
        
    },
    actions: {
        
    },

    modules: Modules
});

const app = Vue.createApp({
    components: {

    },
    data: () => ({
        // selectedData : {type : "vehicles", data :{brand : "BMW",
        // model : "M4 G80 Custom Build",
        // price : '12.500',
        // image : 'bmw.png'}},
        Translate : {
            ["vipmenu"] : "VIP MENU",
            ["vehicles"] : "VEHICLES",
            ["weapons"] : "WEAPONS",
            ["other"] : "OTHER",
            ["history"] : "Purchase History",
            ["viewpass"] : "View My Pass",
            ["needvcoin"] : "NEED VCOIN ?",
            ["visitstore"] : "To get VCoin you can visit our store",
            ["tebexid"] : "codem.tebex.io",
            ["info"] : "After the payment put your tbx-id to input down below",
            ["paymentid"] : "Tebex Payment ID",
            ["getvcoin"] : "Get VCoins",
            ["clickpreview"] : "Click to preview all details",
            ["hotdeals"] : "HOT DEALS",
            ["getdeal"] : "Get Deal Now",
            ["vippasses"] : "VIP PASSES",
            ["checkpasses"] : "Check Passes",
            ["timeforpass"] : "Passes are active after the payment for 30 days.",
            ["gobck"] : "GO BACK",
            ["pass"] : "PASS",
            ["getthepass"] : "Get The Pass",
            ["lessdetail"] : "Less Detail",
            ["getdealnow"] : "Get Deal Now",
            ["donthavepass"] : "You don't have any active VIP Pass.",
            ["currentpass"] : "Current Pass",
            ["getitem"] : "Get Item Now",
            ["cancel"] : "Cancel"

        },
        tbxid : '',
        popup : false,
        selectedData : {},
        activeindexs : -1,
        uiswiper : false,
        page : 'main',
        expireddata : {
            ["vehicle"] : false,
            ["weapon"] : false,
            ["other"] : false,
        },
        PlayerData : {
            
        },
        Vehicles : {
        },
        Weapons : {
            
        },
        Other : {
            
        },
        HotDealData : {
        },

        Passes : {
            
        }
    }),
    computed: {
        ...Vuex.mapState({
            // activePage: state => state.activePage
        })
    },

    watch: {},

    beforeDestroy() {
        window.removeEventListener("keyup", this.updateNavbarActive);
    },

    mounted() {
        window.addEventListener("message", (event) => {
            if (event.data.action == "init") {
                this.Vehicles = event.data.Vehicles;
                this.Weapons = event.data.Weapons;
                this.Other = event.data.Other;
                this.HotDealData = event.data.HotDealData;
                this.Passes = event.data.Passes;
                this.Translate = event.data.Translate;
            } else if (event.data.action == 'open') {
                setTimeout(() => {
                    this.SetSwiper();
                }, 5);
                this.PlayerData = event.data.PlayerData;
                $("#app").fadeIn(300);
            } else if (event.data.action == 'update') {
                this.PlayerData = event.data.PlayerData;
            }
          })

          $(document).on("keydown", function () {
            switch (event.keyCode) {
                case 27: // ESC
                    $("#app").fadeOut(300);
                    $.post("https://m-vipsystem/close", JSON.stringify({}));
                    break;
            }
        });

        setTimeout(() => {
            this.SetSwiper();
        }, 150);

    },

    methods: {
        GetNonBreaking(oldText) {
            let newText = "";
            for (let i = 0; i < oldText.length; i++) {
                if (oldText[i] === " ") {
                    newText += "\n"; 
                } else {
                    newText += oldText[i];
                }
            }
            return newText

        },
        GetPhoto(photo) {
            return `./template/${photo}`;
        },
        BuyHotDeal(type, data) {
            if (this.expireddata[type]) return;
            $.post("https://m-vipsystem/BuyHotDeal", JSON.stringify({data : data}));
            this.page = 'main'
            this.selectedData = {}
            $("#app").fadeOut(300);
            $.post("https://m-vipsystem/close", JSON.stringify({}));
        },
        ChangePage(page) {
            if (this.page == page) return;
            this.popup = false
            if (this.page == 'buyitem' && page != 'buyitem') {this.selectedData = {};}
            this.page = page;
            setTimeout(() => {
                this.SetSwiper();
            }, 5);
            if(page == "details") {
                setTimeout(() => {
                    this.uiswiper.params.slidesPerView = 6;
                    this.uiswiper.update();
                }, 30);

            }
            
        },
        BuyItem() {
            $.post("https://m-vipsystem/BuyItem", JSON.stringify({data : this.selectedData}));
            this.page = 'main'
            this.selectedData = {}
            $("#app").fadeOut(300);
            $.post("https://m-vipsystem/close", JSON.stringify({}));
        },
        Cancel() {
            if (this.selectedData.type) {
                this.ChangePage(this.selectedData.type);
            }
        },
        ClickToBuy (type, data) {
            this.selectedData.type = type;
            this.selectedData.data = data;
            this.ChangePage("buyitem");
        },
        GetInterval(type, timedata) {
            var expirationDate = new Date(timedata.year, timedata.month, timedata.day, timedata.hour, timedata.minute, timedata.second);
            var currentDate = new Date();
            if (expirationDate > currentDate) {
                var temp = expirationDate;
                expirationDate = currentDate;
                currentDate = temp;
            
            } else {
                this.expireddata[type] = true;
                return "Expired";
            }
            var remainingTime =  currentDate - expirationDate;
            var days = Math.floor(remainingTime / (1000 * 60 * 60 * 24));
            var hours = Math.floor((remainingTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((remainingTime % (1000 * 60 * 60)) / (1000 * 60));
            return days + " day " + hours + " hours " + minutes + " min";
        },
        SetSwiper(){
            this.uiswiper = new Swiper('.swiper', {
                pagination: {
                  el: '.swiper-pagination',
                },
                direction: 'vertical',
                slidesPerView: 1.75,

              });
              this.activeindexs = this.uiswiper.activeIndex;
              this.uiswiper.on("slideChange", () => {
                this.activeindexs = this.uiswiper.activeIndex;
            });
        },
        SetAnimationtoGetVCoin() {
            $(".headercontent").animate({
                width:"67.5%",
            }, 600, function(){
                
                $(".vcoincontainer").animate({
                    opacity:"0",
                }, 400, function(){
                    
                    $(".vcoincontainer").css({'display':'none'});
                    
                $(".secretdiv").css({'display':'flex'}).animate({
                    opacity: 100,
                }, 500, function(){
                    
                });
                });
            });
        },
        CheckTebex() {
            $.post("https://m-vipsystem/CheckTebex", JSON.stringify({tbxid : this.tbxid}));
            this.selectedData = {}
            $("#app").fadeOut(300);
            $.post("https://m-vipsystem/close", JSON.stringify({}));
        },
        BuyPass(type) {
            $.post("https://m-vipsystem/BuyPass", JSON.stringify({type : type}));
            this.page = 'main'
            this.selectedData = {}
            $("#app").fadeOut(300);
            $.post("https://m-vipsystem/close", JSON.stringify({}));
        },
        BuyHotDealMain() {
            $.post("https://m-vipsystem/BuyHotDealmain", JSON.stringify({}));
            this.page = 'main'
            this.selectedData = {}
            $("#app").fadeOut(300);
            $.post("https://m-vipsystem/close", JSON.stringify({}));
        },
        ClearAnimation() {
            $(".secretdiv").css({'display':'flex'}).animate({
                opacity: 0,
            }, 500, function(){

                $(".vcoincontainer").css({'display':'flex'}).animate({
                    opacity:"100",
                }, 400, function(){
                    $(".headercontent").animate({
                        width:"100%",
                    }, 600, function(){
                        
                    });
                });
            });
        }
    }
});
app.use(store).mount("#app");


