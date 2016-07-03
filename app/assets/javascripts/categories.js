$(document).on("page:change", function() {
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
