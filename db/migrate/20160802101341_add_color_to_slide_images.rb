class AddColorToSlideImages < ActiveRecord::Migration
  def change
    add_column :slide_images, :color_h1, :string, default: "#fa03bb"
    add_column :slide_images, :color_h2, :string, default: "#ffffff"
    add_column :slide_images, :color_h3, :string, default: "#ffffff"
    add_column :slide_images, :color_h4, :string, default: "#fa03bb"
  end
end
