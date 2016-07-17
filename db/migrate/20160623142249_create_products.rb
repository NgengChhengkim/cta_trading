class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.decimal :retail_sale_price, precision: 15, scale: 2
      t.float :discount, default: 0
      t.decimal :discount_price, precision: 15, scale: 2
      t.text :description
      t.string :cover_image

      t.references :category, index: true, foreign_key: true
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
