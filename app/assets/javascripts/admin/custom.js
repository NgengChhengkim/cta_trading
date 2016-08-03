$(document).on("page:update", function(){
  if($(".list").length > 0) {
    $("input[type='checkbox']").unbind("change").on("change", function (e) {
      if(this.id == "select_all") {
        $(".check-box:enabled").prop("checked", this.checked);
      } else {
        $(".select-all input").prop("checked",
          $(".check-box:checked").length == $(".check-box").length);
      }

      if($(".check-box:checked").length > 0) {
        $(".btn-delete").attr("disabled", false);
      } else {
        $(".btn-delete").attr("disabled", true);
      }
    });
  }

  $(".navbar .menu").slimscroll({
    height: "200px",
    alwaysVisible: false,
    size: "5px"
  });
});

$(document).on("page:change", function(){
  $("#form-modal, #modal-cart").on("hidden.bs.modal", function () {
    $(".modal-content").html("<div class='modal-spinner'>" +
      "<i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i></div>");
  });

  $(".ckeditor").each(function() {
    CKEDITOR.replace($(this).attr("id"));
  });

  $(".color-header-picker").minicolors({theme: "bootstrap"});

  $(".btn-filter").unbind("click").on("click", function() {
    $(".filter-loading").show();
  });

  $(".input-daterange").datepicker({
    format: "dd-mm-yyyy",
    autoclose: true,
    todayHighlight: true
  });
});
