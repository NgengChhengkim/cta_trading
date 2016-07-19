class CreateSlideImages < ActiveRecord::Migration
  def change
    create_table :slide_images do |t|
      t.string :picture
      t.string :heading1
      t.string :heading2
      t.string :heading3
      t.string :heading4
      t.timestamps null: false
    end
  end
end
