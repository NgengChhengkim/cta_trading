class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :title
      t.string :content
      t.string :picture
      t.timestamps null: false
    end
  end
end
