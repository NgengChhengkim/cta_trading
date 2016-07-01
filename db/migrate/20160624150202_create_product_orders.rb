class CreateProductOrders < ActiveRecord::Migration
  def change
    create_table :product_orders do |t|
      t.integer :order_code
      t.integer :customer_id
      t.string :customer_type
      t.references :product, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
