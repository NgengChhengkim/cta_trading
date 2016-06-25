class CreateProductCarts < ActiveRecord::Migration
  def change
    create_table :product_carts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.integer :quantity, default: 1

      t.timestamps null: false
    end
  end
end
