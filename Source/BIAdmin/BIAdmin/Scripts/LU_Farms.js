function RBLChanged(sender) {
    var RBL = document.getElementById(sender.id);
    var inputs = RBL.getElementsByTagName("input");

    var selected;

    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].checked) {
            selected = inputs[i].value;
            break;
        }
    }

    var TXB = document.getElementById(sender.id.replace("mrbl_", "mtxb_"));
    if (TXB != null) {
        if (selected == "Other") {
            TXB.disabled = false;
        }
        else {
            TXB.disabled = true;
            TXB.value = selected;
            Page_ClientValidate('MergeFarm');
        }
    }

    var CB = document.getElementById(sender.id.replace("mrbl_", "mcb_"));
    if (CB != null) {
        if (selected == "Other") {
            CB.disabled = false;
        }
        else {
            CB.disabled = true;
            if (selected == "True") {
                CB.checked = true;
            }
            else {
                CB.checked = false;
            }
        }
    }
}

function mcv_String_Validate(source, arguments) {

    var IsOK = true;

    var mcv = document.getElementById(source.id);
    var mtxb = document.getElementById(source.id.replace("mcv_", "mtxb_"));
    var mrbl = document.getElementById(source.id.replace("mcv_", "mrbl_"));

    var inputs = mrbl.getElementsByTagName("input");

    var selected;

    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].checked) {
            selected = inputs[i].value;
            break;
        }
    }

    if (selected == "Other" && mtxb.value.length == 0) {
        IsOK = false;
    }

    arguments.IsValid = IsOK;
}

function mcv_ActiveFrom_Validate(source, arguments) {

    var IsOK = true;

    var mcv = document.getElementById(source.id);
    var mtxb = document.getElementById(source.id.replace("mcv_", "mtxb_"));
    var mrbl = document.getElementById(source.id.replace("mcv_", "mrbl_"));
    if (mrbl != null) {
        var inputs = mrbl.getElementsByTagName("input");

        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].value != "Other") {
                var OldActiveFrom = GetDate(inputs[i].value);
                var NewActiveFrom = GetDate(mtxb.value);

                if (NewActiveFrom < OldActiveFrom) {
                    IsOK = false;
                }
            }
        }
    }

    arguments.IsValid = IsOK;
}

function GetDate(strDate) {
    var myYMD = strDate.split("/");
    var myYear = parseInt(myYMD[2].toString(), 10);
    var myMonth = parseInt(myYMD[1].toString(), 10) - 1;
    var myDay = parseInt(myYMD[0].toString(), 10);
    var myDate = new Date(myYear, myMonth, myDay);
    return myDate;
}

function FadeOut(source) {
    var lbl = document.getElementById(source.id);
    $(lbl).fadeOut(2000);
}