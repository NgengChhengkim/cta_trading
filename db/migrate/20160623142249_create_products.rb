class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.float :weight
      t.integer :number_per_case
      t.decimal :whole_sale_price
      t.decimal :retail_sale_price
      t.decimal :price_per_case
      t.float :discount
      t.decimal :discount_price
      t.string :smell
      t.text :description
      t.text :usage

      t.references :category, index: true, foreign_key: true
      t.references :supplier, index: true, foreign_key: true
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
