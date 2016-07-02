class CustomerMailer < ApplicationMailer
  def send_confirmation_order product_invoices, user, invoice
    @product_invoices = product_invoices
    @user = user
    @invoice = invoice
    @total_price = @invoice.product_invoices.total_price
    mail to: @user.email, subject: t("product_invoices.email.send_confirmation_order.subject")
  end
end
