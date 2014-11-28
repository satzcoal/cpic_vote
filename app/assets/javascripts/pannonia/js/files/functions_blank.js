var initPage;
initPage = function () {

    //===== Hide/show sidebar =====//
    $('.fullview').click(function () {
        $("body").toggleClass("clean");
        $('#sidebar').toggleClass("hide-sidebar mobile-sidebar");
        $('#content').toggleClass("full-content");
    });


    //===== Hide/show action tabs =====//
    $('.showmenu').click(function () {
        $('.actions-wrapper').slideToggle(100);
    });


    //===== Easy tabs =====//

    /*$('.sidebar-tabs').easytabs({
     animationSpeed: 150,
     collapsible: false,
     tabActiveClass: "active"
     });*/

    //===== Collapsible plugin for main nav =====//
    $('.expand').collapsible({
        defaultOpen: 'current,third',
        cookieName: 'navAct',
        cssOpen: 'subOpened',
        cssClose: 'subClosed',
        speed: 200
    });

    //===== Datatables =====//

    oTable = $('#filer-table').dataTable({

        "aaSorting": [
            [ 0, 'desc' ]
        ],
        "bJQueryUI": false,
        "bAutoWidth": false,
        "sPaginationType": "full_numbers",
        "sDom": '<"datatable-header"fl>t<"datatable-footer"ip>',
        "oLanguage": {
            "sSearch": "<span>请输入筛选条件（姓名，部门名，处室名等）:</span> _INPUT_",
            "sLengthMenu": "<span>每页显示行数:</span> _MENU_",
            "oPaginate": { "sFirst": "首页", "sLast": "尾页", "sNext": ">", "sPrevious": "<" },
            "sInfo": "_START_ 到 _END_ 条，共 _TOTAL_ 条"
        }
    });

    //===== Bootboxes =====//

    $("a.reset-password").click(function (e) {

            f = "\
            <form id='infos' action=''>\
                <div class='control-group'>\
                    <label class='control-label'>原密码：</label>\
                    <div class='controls'>\
                        <input type='password' class='span12' id='cpass-input-old' name='oldpass'>\
                    </div>\
                </div>\
                <div class='control-group'>\
                    <label class='control-label'>新密码：</label>\
                    <div class='controls'>\
                        <input class='span12' type='password' id='cpass-input-pass' name='newpass'>\
                    </div>\
                </div>\
                <div class='control-group'>\
                    <label class='control-label'>重复新密码：</label>\
                    <div class='controls'>\
                        <input class='span12' type='password' id='cpass-input-pass2' name='newpass2'>\
                    </div>\
                </div>\
            </form>";
            cb = [
                {
                    "取消": function () {
                        return true;
                    }
                },
                {
                    "提交": function () {
                        xmlhttp = new XMLHttpRequest();
                        xmlhttp.open("POST", "/origin/ajax_authorize", false);
                        xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                        xmlhttp.send("password=" + $("#cpass-input-old").val());
                        if (xmlhttp.responseText == "failed") {
                            bootbox.alert("原密码不正确！", function () {
                                bootbox.dialog(f, cb);
                            });
                            return true;
                        } else if ($("#cpass-input-pass").val() == "") {
                            bootbox.alert("新密码不能为空！", function () {
                                bootbox.dialog(f, cb);
                            });
                            return true;
                        }
                        else if ($("#cpass-input-pass").val() != $("#cpass-input-pass2").val()) {
                            bootbox.alert("两次密码输入必须一致！", function () {
                                bootbox.dialog(f, cb);
                            });
                            return true;
                        }
                        else {
                            xmlhttp = new XMLHttpRequest();
                            xmlhttp.open("POST", "/origin/ajax_changepass", false);
                            xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                            xmlhttp.send("password=" + $("#cpass-input-pass").val());
                            bootbox.alert("修改成功！");
                            return true;
                        }
                    }
                }
            ];
            e.preventDefault();
            bootbox.dialog(f, cb);
        }
    );
}
$(document).ready(initPage);
$(document).on('page:load', initPage);
