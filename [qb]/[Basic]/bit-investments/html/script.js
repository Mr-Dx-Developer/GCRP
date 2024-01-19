
$(function () {
    function display(bool) {
        if (bool) {
            document.getElementById("notification").style.display = "none";
            document.getElementById("body").style.display = "block";
        } else {
            document.getElementById("body").style.display = "none";
        }
    }
    function displaypanel(bool) {
        if (bool) {
            document.getElementById("alert").style.display = "none";
            document.getElementById("panel").style.display = "block";
            document.getElementById("body").style.display = "block";
        } else {
            document.getElementById("panel").style.display = "none";
            document.getElementById("alert").style.display = "block";
            document.getElementById("body").style.display = "none";
            
        }
    }

    function displayconfirm(bool) {
        if (bool) {
            document.getElementById("investment").style.display = "none";
            document.getElementById("confirmation").style.display = "block";
        } else {
            document.getElementById("confirmation").style.display = "none";
            document.getElementById("investment").style.display = "block";
            
        }
    }

    function displayfinal(bool) {
        if (bool) {
            document.getElementById("alert").style.display = "none";
            document.getElementById("notification").style.display = "block";
        } else {
            document.getElementById("alert").style.display = "block";
            document.getElementById("notification").style.display = "none";
        }
    }

    function displayclear(bool) {
        if (bool) {
            document.getElementById("notification").style.display = "none";
        } else {
            document.getElementById("notification").style.display = "none";
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
                $('#time').text(item.timeuser);
                $('#amount').text(item.investprice);
            } else {
                display(false)
            }
        }

        if (item.type === "panel") {
            if (item.status == true) {
                displaypanel(true)
                
            } else {
                displaypanel(false)
            }
        }

        if (item.type === "confirm") {
            if (item.status == true) {
                displayconfirm(true)
                
            } else {
                displayconfirm(false)
            }
        }

        if (item.type === "final") {
            if (item.status == true) {
                displayfinal(true)
                if (item.invest == 1) {
                    document.getElementById("imgnoti").src="./img/big1.png";
                } else if (item.invest == 2) {
                    document.getElementById("imgnoti").src="./img/big2.png";
                } else if (item.invest == 3) {
                    document.getElementById("imgnoti").src="./img/big3.png";
                } else if (item.invest == 4) {
                    document.getElementById("imgnoti").src="./img/big4.png";
                } else if (item.invest == 5) {
                    document.getElementById("imgnoti").src="./img/big5.png";
                } else if (item.invest == 6) {
                    document.getElementById("imgnoti").src="./img/big6.png";
                } else {
                    document.getElementById("imgnoti").src="./img/big1.png";
                }

                $('#moneynoti').text(item.investprice)
            } else {
                displayfinal(false)
            }
        }
        if (item.type === "clear") {
            if (item.status == true) {
                displayclear(true)
            } else {
                displayclear(false)
            }
        }
    })

    $( "#select1" ).click(function() {
        $.post('https://bit-investments/selected', JSON.stringify({text:"1"}));
    });  

    $( "#select2" ).click(function() {
        $.post('https://bit-investments/selected', JSON.stringify({text:"2"}));
    });  

    $( "#select3" ).click(function() {
        $.post('https://bit-investments/selected', JSON.stringify({text:"3"}));
    });  

    $( "#select4" ).click(function() {
        $.post('https://bit-investments/selected', JSON.stringify({text:"4"}));
    });  

    $( "#select5" ).click(function() {
        $.post('https://bit-investments/selected', JSON.stringify({text:"5"}));
    });  
    
    $( "#select6" ).click(function() {
        $.post('https://bit-investments/selected', JSON.stringify({text:"6"}));
    });  

    $( "#confirmate" ).click(function() {
        $.post('https://bit-investments/confirmate', JSON.stringify({}));
        document.getElementById("confirmation").style.display = "none";
        document.getElementById("investment").style.display = "block";
        document.getElementById("panel").style.display = "none";
        document.getElementById("alert").style.display = "block";
    });  

    
    document.onkeyup = function (data) {
        if (data.which == 27) {
            displaypanel(false)
            document.getElementById("confirmation").style.display = "none";
            document.getElementById("investment").style.display = "block";
            document.getElementById("panel").style.display = "none";
            $.post('https://bit-investments/exit', JSON.stringify({}));
            return
        }
    };
        
})