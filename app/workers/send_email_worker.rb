class SendEmailWorker
  include Sidekiq::Worker

  def perform invoice_id
    invoice = Invoice.find invoice_id
    product_invoices = invoice.product_invoices.includes product: :category
    user = invoice.customer
    CustomerMailer.send_confirmation_order(product_invoices, user, invoice).deliver
  end
end
