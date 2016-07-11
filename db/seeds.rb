facial = Category.create! name: "Facial"
hair = Category.create! name: "Hair"
body = Category.create! name: "Body"

robeca = Brand.create! name: "Robeca"
baschi = Brand.create! name: "Baschi"

100.times do
  facial.products.create! name: "Robeca", retail_sale_price: 10, discount: 50,
    discount_price: 5, brand_id: 1
end
10.times do
  body.products.create! name: "Baschi", retail_sale_price: 20, discount: 0,
    discount_price: 20, brand_id: 2
end
User.create! name: "Admin", email: "admin@gmail.com", password: "12345678",
  password_confirmation: "12345678", role: 0, phone_number: "02939458"
