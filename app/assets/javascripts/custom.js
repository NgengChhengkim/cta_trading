$(document).on("page:update", function() {
  $(".flash-message").delay(6000).slideUp();

  $.validate({
    modules : "security"
  });
});

$(document).on("page:change", function() {
  new WOW().init();

  $("#slider").responsiveSlides({
    auto: true,
    speed: 500,
    namespace: "callbacks",
    pager: false,
  });

  $(".popup-with-zoom-anim").magnificPopup({
    type: "inline",
    fixedContentPos: false,
    fixedBgPos: true,
    overflowY: "auto",
    closeBtnInside: true,
    preloader: false,
    midClick: true,
    removalDelay: 300,
    mainClass: "my-mfp-zoom-in"
  });

  $("#carousel").flexslider({
    animation: "slide",
    controlNav: false,
    animationLoop: false,
    slideshow: false,
    itemWidth: 70,
    itemMargin: 5,
    asNavFor: "#slider",
    prevText: "",
    nextText: ""
  });

  $("#slider").flexslider({
    animation: "slide",
    controlNav: false,
    animationLoop: false,
    slideshow: false,
    sync: "#carousel",
    prevText: "",
    nextText: ""
  });

  $(".search-text").on("focus", function() {
    $(this).val("");
  });

  if($(".load-more").length > 0) {
    $(".btn-load-more").on("click", function() {
      var next_product_url = $(".pagination .next_page a").attr("href");
      if(next_product_url) {
        $(".loading").show();
        $(this).hide();
        $.getScript(next_product_url);
      }
      return;
    });
  }

});
