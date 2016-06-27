$(document).on("page:change", function() {

  $(".add-to-cart").unbind("click").on("click", function() {
    var product_id = $(this).data("product-id");
    var product_cart = Cookies.getJSON("product_cart");
    var current_product;

    if(product_cart) {
      current_product = product_cart.filter(function(product) {
        return product.id == product_id;
      });

      if(current_product.length > 0) {
        current_product[0].quantity = current_product[0].quantity + 1;
      }else{
        product_cart.push({id: product_id, quantity: 1});
      }

    }else{
      product_cart = [{id: product_id, quantity: 1}];
    }
    Cookies.set("product_cart", product_cart, {expires: 3650});
    get_total_product_cart(product_cart);
    return false;
  });

  $(".user-cart .product-quantity").unbind("change").on("change", function() {
    var product_cart_id = $(this).data("product-cart-id");
    var quantity = $(this).val();
    $.ajax({
      type: "PUT",
      data: {product_cart: {quantity: quantity}},
      url: "/product_carts/"+product_cart_id
    });
  });

  $(".guest-cart .product-quantity").unbind("change").on("change", function() {
    var product_id = $(this).data("product-id");
    var product_cart = Cookies.getJSON("product_cart");
    var quantity = parseInt($(this).val());

    var current_product = product_cart.filter(function(product) {
      return product.id == product_id;
    });
    current_product[0].quantity = quantity;
    Cookies.set("product_cart", product_cart, {expires: 3650});
    get_total_product_cart(product_cart);
  });

  $(".guest-cart .remove").unbind("click").on("click", function() {
    var product_id = $(this).data("product-id");
    var product_cart = Cookies.getJSON("product_cart");
    product_cart = product_cart.filter(function(product) {
      return product.id !== product_id;
    });
    Cookies.set("product_cart", product_cart, {expires: 3650});
    get_total_product_cart(product_cart);
    $(".cart-"+product_id).html("");
    return false;
  });

  function get_total_product_cart(product_cart_object) {
    var total_quantity = 0;
    $.each(product_cart_object, function() {
      total_quantity += this.quantity;
    });
    $(".number-cart").html(total_quantity);
  }

});
