class CreateProductInvoices < ActiveRecord::Migration
  def change
    create_table :product_invoices do |t|
      t.references :invoice, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
