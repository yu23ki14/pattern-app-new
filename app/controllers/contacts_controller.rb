class ContactsController < ApplicationController
  def index
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if contact_params[:message] != ""
      @contact.save
      redirect_to root_path, notice: 'ご意見、ご要望、ご感想ありがとうございます。'
      else
        redirect_to contacts_path, alert: '内容は必須です。'
    end
  end
  
  private
    
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
