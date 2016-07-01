class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.string :customer_type

      t.timestamps null: false
    end
  end
end
