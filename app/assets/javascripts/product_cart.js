$(document).on("page:change", function() {
  if($("#product-cart").length > 0 || $("#product-order").length > 0) {
    total_price();
  }

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
    check_zero($(this));
    var product_cart_id = $(this).data("product-cart-id");
    var quantity = $(this).val();
    $.ajax({
      type: "PUT",
      data: {product_cart: {quantity: quantity}},
      url: "/product_carts/"+product_cart_id
    });
  });

  $(".guest-cart .product-quantity").unbind("change").on("change", function() {
    check_zero($(this));
    var product_id = $(this).data("product-id");
    var product_cart = Cookies.getJSON("product_cart");
    var quantity = parseInt($(this).val());

    var current_product = product_cart.filter(function(product) {
      return product.id == product_id;
    });
    current_product[0].quantity = quantity;
    Cookies.set("product_cart", product_cart, {expires: 3650});
    get_total_product_cart(product_cart);
    total_price();
  });

  $(".guest-cart .remove").unbind("click").on("click", function() {
    var product_id = $(this).data("product-id");
    var product_cart = Cookies.getJSON("product_cart");
    product_cart = product_cart.filter(function(product) {
      return product.id !== product_id;
    });
    Cookies.set("product_cart", product_cart, {expires: 3650});
    get_total_product_cart(product_cart);
    if(Cookies.getJSON("product_cart").length > 0) {
      $(".cart-"+product_id).remove();
      total_price();
    }else{
      $("#product-cart .row").html("<div class='empty-cart'>"+ I18n.t("cart.labels.no_cart") +"</div>")
    }
    return false;
  });

  function get_total_product_cart(product_cart_object) {
    var total_quantity = 0;
    $.each(product_cart_object, function() {
      total_quantity += this.quantity;
    });
    $(".number-cart").html(total_quantity);
  }

  $(document).on("keypress", ".product-quantity", function(event) {
    if ((event.which < 48 || event.which > 57) || event.which == 46) {
      event.preventDefault();
    }
  });

  function check_zero(dom) {
    if(dom.val() == "" || dom.val() == 0) {
      dom.val(1);
      return;
    }
  }
});

function total_price() {
  var sum = 0;
  $.each($(".product-cart"), function() {
    var price = parseFloat($(this).find(".discount-price").data("discount-price"));
    var quantity = parseInt($(this).find(".product-quantity").val());
    sum += price * quantity
  });
  $(".total").html("$"+ $.number(sum, 2));
}
