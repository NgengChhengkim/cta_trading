module ApplicationHelper

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-error"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end

  def number_cart
    number = 0
    if user_signed_in?
      number = current_user.product_carts.sum :quantity
    elsif cookies[:product_cart]
      product_cookies = JSON.parse cookies[:product_cart]
      number = product_cookies.inject(0) {|sum, product| sum + product["quantity"]}
    end
    number
  end

  def product_quantity object, id
    product = object.detect {|data| data["id"] == id}
    quantity = product["quantity"]
  end

  def percentage_format number
    number_to_percentage number, precision: 1, strip_insignificant_zeros: true
  end

  def image_product_list image
    image_tag image, width: Settings.image.size150, class: "img-responsive"
  end

  def image_product_table image
    image_tag image, width: Settings.image.size100, class: "img-responsive"
  end

  def media_image image
    image_tag image, width: Settings.image.size60, class: "media-object"
  end

  def text_truncate content, length
    truncate content, length: length, omission: ""
  end
end
