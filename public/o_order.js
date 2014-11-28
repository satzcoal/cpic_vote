var select;

function iniGoDownItems1() {
    iniGoDownItems();
    changecategory();
    $(".items").each(function () {
        $(this).change(function () {
            changeItem(this);
        });
    });
}

var GoDowinItmeUrl = "http://" + window.location.host + "/go_down_items/search.json/";
var GoDowinItmes;
function iniGoDownItems() {
    if (GoDowinItmes == null) {
        $.getJSON(GoDowinItmeUrl, function (json) {
            GoDowinItmes = eval(json);
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
        $(".items").each(function () {
            $(this).empty();
            var itemno = $("#itemline" + $(this).attr("rowid") + "_Item_id").val();
            $(this).append("<option value='请选择'  data='|'>请选择</option>");
            for (var i = 0; i < items.length; i++) {
                //if (items[i].Type == select) {
                if (items[i].id == itemno) {
                    $(this).append("<option value='" + items[i].id + "' selected='true'  data='" + items[i].CategoryName + "|" + items[i].subCategoryName + "'>" + items[i].Name + "</option>");
                }
                else {
                    $(this).append("<option value='" + items[i].id + "'  data='" + items[i].CategoryName + "|" + items[i].subCategoryName + "'>" + items[i].Name + "</option>");
                }

                // }
            }
        });
    }
}

function changeItem(obj) {
    var rowid = $(obj).attr("rowid");
    var select = $(obj).find("option:selected").attr("data").split('|');
    debugger;
    if ($(obj).find("option:selected").val() != "请选择") {
        var itemid = $(obj).find("option:selected").val();
        $("#category" + rowid).val(select[0]);
        $("#subcategory" + rowid).val(select[1]);
        $("#itemline" + rowid + "_Item_id").val(itemid);
        var sum = GoDowinItmes[itemid];
        if (sum != null) {
            $("#Sum" + rowid).val(sum);
            //test();
        }
        else {
            $("#Sum" + rowid).val(0);
//            alert("没有库存");
//            $(obj).get(0).selectedIndex = 0;
//            $("#category" + rowid).val("");
//            $("#subcategory" + rowid).val("");
//            $("#itemline" + rowid + "_Item_id").val("");
//            $("#Sum" + rowid).val("");
        }

    }
    else {
        $("#category" + rowid).val("");
        $("#subcategory" + rowid).val("");
        $("#itemline" + rowid + "_Item_id").val("");
        $("#Sum" + rowid).val("");
    }
}

