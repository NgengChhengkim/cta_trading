class CreateProductCarts < ActiveRecord::Migration
  def change
    create_table :product_carts do |t|
      t.integer :quantity
      t.integer :customer_id
      t.string :customer_type
      t.timestamps null: false

      t.references :country, index: true, foreign_key: true
    end
  end
end
