class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.timestamps null: false

      t.references :product, index: true, foreign_key: true
    end
  end
end
