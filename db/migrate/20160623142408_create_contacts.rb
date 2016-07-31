class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :address
      t.string :email
      t.string :phone_number
      t.text :content
      t.timestamps null: false
    end
  end
end
