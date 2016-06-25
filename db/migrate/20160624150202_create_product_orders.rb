class CreateProductOrders < ActiveRecord::Migration
  def change
    create_table :product_orders do |t|
      t.integer :quantity
      t.integer :customer_id
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
