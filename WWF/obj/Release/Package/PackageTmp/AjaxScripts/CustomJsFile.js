'use-strict';
$('#checkBoxAllGoods').click(function () {
    var checked = this.checked;
})
var td2 = $(".form_select_multiple_users")
td2.on("change",
    "tbody tr .checkboxes",
    function () {
        var t = jQuery(this).is(":checked"), selected_arr = [];
        t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
            : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
        // Read all checked checkboxes
        $("input:checkbox[class=checkboxes]:checked").each(function () {
            selected_arr.push($(this).val());
        });

        if (selected_arr.length > 0) {
            $("#rfiresponsefeedback").css("display", "block");

        } else {
            $("#rfiresponsefeedback").css("display", "none");
            selected_arr = [];
        }

    });
//var selected_arr = [];
var PrimaryInitiative = new Array();
$(".btn_assigntoevaluator").on("click",
    function (e) {
        e.preventDefault();
        PrimaryInitiative = [];
        var sc = '';
        var tevaltwo = '';
        var tevalthree = '';
        var tevalfour = '';
        var tevalfive = '';
        var evalmessage = '';
        $.each($(".form_select_multiple_users"), function () {
            sc = $('.evaluatormultiplec').val();
        });
        $.each($(".form_select_multiple_users"), function () {
            tevaltwo = $('.evaltwo').val();
        });
        $.each($(".form_select_multiple_users"), function () {
            tevalthree = $('.evalthree').val();
        });
        $.each($(".form_select_multiple_users"), function () {
            tevalfour = $('.evalfour').val();
        });
        $.each($(".form_select_multiple_users"), function () {
            tevalfive = $('.evalfive').val();
        });
        $.each($(".form_select_multiple_users"), function () {
            evalmessage = $('.messagetoeval').val();
        });
        $.each($(".table_select_multiple_users tr.active"), function () {
            var checkbox_value = $('#selectedactivityrecords1').val();
            var Targets = {};
            Targets.TargetNumber = ($(this).find('td').eq(2).text());
            Targets.SelectedUser = sc;
            Targets.SelectedUserTwo = tevaltwo;
            Targets.SelectedUserThree = tevalthree;
            Targets.SelectedUserFour = tevalfour;
            Targets.SelectedUserFive = tevalfive;
            Targets.MessageEval = evalmessage;
            PrimaryInitiative.push(Targets);
        });      
        var postData = {
            catgeories: PrimaryInitiative
        };
        console.log(JSON.stringify(PrimaryInitiative))
        Swal.fire({
            title: "Assigning...",
            text: "Please wait",
            imageUrl: "Images/Fidget-spinner.gif",
            showConfirmButton: false,
            allowOutsideClick: false

        })
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
            url: "AllSubmittedTenders.aspx/SubmitSelectedCoreInitiatives",
            dataType: "json",
            processData: false
        }).done(function (status) {
            var registerstatus = status.d;
            console.log(JSON.stringify(registerstatus))
            switch (registerstatus) {
                case "success":
                    Swal.fire
                    ({
                        title: "The Assignment was Successful",
                        showConfirmButton: true,
                        timer: 2000,
                    }).then(() => {
                        location.reload();
                        return false;
                    });
                    PrimaryInitiative = [];
                    break;
                default:
                    Swal.fire
                    ({
                        title: "The Assignment was unsuccessful, kindly try again.",
                        showConfirmButton: true,
                        timer: 2000,
                    }).then(() => {
                    });
                    PrimaryInitiative = [];
                    break;
            }
        }
        );

    });