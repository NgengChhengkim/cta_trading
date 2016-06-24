$(document).on("page:change", function() {
  $(".total").html("$"+$.number(Cookies.get("total_price"), 2));

  $(".add-to-cart").on("click", function() {
    var product_id = $(this).data("id");
    var price = parseFloat($(this).data("price"));
    var product_cart = Cookies.getJSON("product_cart");
    var total_price = Cookies.get("total_price");
    var sum_price;

    if(product_cart) {
      product_cart.push(product_id);
    }else{
      product_cart = [product_id]
    }
    Cookies.set("product_cart", product_cart, {expires: 3650});

    if(total_price) {
      sum_price = price + parseFloat(total_price);
    }else{
      sum_price = price;
    }
    Cookies.set("total_price", sum_price, {expires: 3650});
    $(".total").html("$"+$.number(sum_price, 2));
  });

});
