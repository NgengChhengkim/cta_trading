class Admin::ContactsController < ApplicationController
  load_and_authorize_resource

  def index
    @contact = Contact.first
  end

  def edit
  end

  def update
    if @contact.update_attributes contact_params
      flash[:success] = flash_message "updated"
      redirect_to admin_contacts_path
    else
      render :edit
    end
  end

  def contact_params
    params.require(:contact).permit :address, :email, :phone_number, :content
  end
end
