class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.string :customer_type
      t.boolean :seen, default: 0

      t.timestamps null: false
    end
  end
end
