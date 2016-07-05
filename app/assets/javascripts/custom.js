$(document).on("page:update", function() {
  $(".flash-message").delay(3000).slideUp();
});

$(document).on("page:change", function() {
  new WOW().init();
  $.validate({
    modules : "security"
  });

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

});
