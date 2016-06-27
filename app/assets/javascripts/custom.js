$(document).on("page:change", function() {
  new WOW().init();
  $.validate();

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

  $(".flexslider").flexslider({
    animation: "slide",
    controlNav: "thumbnails"
  });
});
