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
      t.string :smell
      t.text :description
      t.text :usage

      t.timestamps null: false
    end
  end
end
