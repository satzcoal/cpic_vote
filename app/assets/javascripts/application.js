// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree ./jquery
//= require_tree ./pannonia

$(window).bind('page:change', function () {
    $(".field_with_errors").each(function () {
        //alert(this);
        $(this).addClass("control-group error");
    });
});
var select;

function iniItems() {
    iniGoDownItems();
    iniGodwns();
    iniBatchs();
    var type = $("#order_Type").val();
    if (type == "1") {
        select = "原料";
    }
    else {
        select = "产品";
    }
    changecategory();
    $(".items").each(function () {
        $(this).change(function () {
            changeItem(this);
        });
    });
}
var GoDownUrl = "http://" + window.location.host + "/go_downs.json/";
var GoDowns;
function iniGodwns() {
    if (GoDowns == null) {
        $.get(GoDownUrl, function (data, status) {
            GoDowns = eval(data);
        });
    }
}
var GoDowinItmeUrl = "http://" + window.location.host + "/go_down_items.json/";
var GoDowinItmes;
function iniGoDownItems() {
    if (GoDowinItmes == null) {
        $.get(GoDowinItmeUrl, function (data, status) {
            GoDowinItmes = eval(data);
        });
    }
}
var BatchsUrl = "http://" + window.location.host + "/batches.json/";
var Batchs;
function iniBatchs() {
    if (Batchs == null) {
        $.get(BatchsUrl, function (data, status) {
            Batchs = eval(data);
        });
    }
}

var ItmeUrl = "http://" + window.location.host + "/items.json/";
var items;
function changecategory(obj) {
    //选择产品--品目变化
    if (items == null) {
        $.get(ItmeUrl, function (data, status) {
            items = eval(data);
            changecategory(obj);
        });
    } else {
        debugger;
        $(".items").each(function () {
            debugger;
            $(this).empty();
            var itemno = $("#itemline" + $(this).attr("rowid") + "_Item_id").val();
            $(this).append("<option value='请选择'  data='|'>请选择</option>");
            for (var i = 0; i < items.length; i++) {
                //if (items[i].Type == select) {
                if (items[i].id == itemno) {
                    $(this).append("<option value='" + items[i].id + "' selected='true'  data='" + items[i].CategoryName + "|" + items[i].subCategoryName + "|" + items[i].BasePrice + "|" + items[i].SalePrice + "|" + items[i].Discount + "'>" + items[i].Name + "</option>");
                }
                else {
                    $(this).append("<option value='" + items[i].id + "'  data='" + items[i].CategoryName + "|" + items[i].subCategoryName + "|" + items[i].BasePrice + "|" + items[i].SalePrice + "|" + items[i].Discount + "'>" + items[i].Name + "</option>");
                }

                // }
            }
        });
    }
}

function changeItem(obj) {
    var rowid = $(obj).attr("rowid");
    var select = $(obj).find("option:selected").attr("data").split('|');
    if ($(obj).find("option:selected").attr("data") != "请选择") {
        $("#category" + rowid).val(select[0]);
        $("#subcategory" + rowid).val(select[1]);
        $("#saleprice" + rowid).val(select[2]);
        $("#itemline" + rowid + "_Item_id").val($(obj).find("option:selected").val());
    }
    else {
        $("#category" + rowid).val("");
        $("#subcategory" + rowid).val("");
        $("#saleprice" + rowid).val();
        $("#itemline" + rowid + "_Item_id").val("");
    }
}
function getItemGoDown(obj, itemid) {
    var rowid = $(obj).attr("rowid");
    var item = ",";
    for (var i = 0; i < GoDowinItmes.length; i++) {
        if (GoDowinItmes[i].Item_id == itemid) {
            if (item.indexOf("," + GoDowinItmes[i].GoDown_id + ",") < 0) {
                item = item + GoDowinItmes[i].GoDown_id + ",";
            }
        }
    }
    $("#itemline" + rowid + "_GoDown_id").empty();
    if (item != ",") {
        $("#itemline" + rowid + "_GoDown_id").append("<option value='请选择'  data='|'>请选择</option>");
        for (var j = 0; j < GoDowns.length; j++) {
            if (item.indexOf("," + GoDowns[j].id + ",") >= 0) {
                $("#itemline" + rowid + "_GoDown_id").append("<option value='" + GoDowns[j].id + "'>" + GoDowns[j].Name + "</option>");
            }
        }
    }
    else {
        alert("没有库存");
        $(obj).get(0).selectedIndex = 0
        $("#category" + rowid).val("");
        $("#subcategory" + rowid).val("");
        $("#itemline" + rowid + "_Item_id").val("");
    }


}
function changeGoDowns(obj) {
    debugger;
    var rowid = $(obj).attr("rowid");
    var itemid = $("#itemline" + rowid + "_Item_id").val();
    var godid = $(obj).find("option:selected").val();
    var item = ","
    for (var i = 0; i < GoDowinItmes.length; i++) {
        if (GoDowinItmes[i].Item_id == itemid && GoDowinItmes[i].GoDown_id == godid) {
            if (item.indexOf("," + GoDowinItmes[i].BatchId + ",") < 0) {
                item = item + GoDowinItmes[i].BatchId + ",";
            }
        }
    }
    $("#itemline" + rowid + "_Batch_id").empty();
    if (item != ",") {
        $("#itemline" + rowid + "_Batch_id").append("<option value='请选择'  data='|'>请选择</option>");
        for (var j = 0; j < Batchs.length; j++) {
            if (item.indexOf("," + Batchs[j].id + ",") >= 0) {
                $("#itemline" + rowid + "_Batch_id").append("<option value='" + Batchs[j].id + "'data='" + Batchs[j].Date + "'>" + Batchs[j].Name + "</option>");
            }
        }
    }

}

function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam) {
            return sParameterName[1];
        }
    }
}




