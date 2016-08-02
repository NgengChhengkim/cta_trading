class CreateSlideImages < ActiveRecord::Migration
  def change
    create_table :slide_images do |t|
      t.string :picture
      t.string :heading1
      t.string :color_h1, default: "#fa03bb"
      t.string :heading2
      t.string :color_h2, default: "#ffffff"
      t.string :heading3
      t.string :color_h3, default: "#ffffff"
      t.string :heading4
      t.string :color_h4, default: "#fa03bb"
      t.timestamps null: false
    end
  end
end
