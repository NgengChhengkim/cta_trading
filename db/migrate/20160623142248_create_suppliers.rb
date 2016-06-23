class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :description
      t.timestamps null: false

      t.references :country, index: true, foreign_key: true
    end
  end
end
