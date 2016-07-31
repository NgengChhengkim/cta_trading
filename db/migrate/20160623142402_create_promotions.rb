class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :title
      t.text :content
      t.string :picture
      t.integer :kind
      t.timestamps null: false
    end
  end
end
