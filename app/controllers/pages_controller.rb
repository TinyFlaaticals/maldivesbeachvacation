class PagesController < ApplicationController
  def home
    @stories = Story.limit(10).order(created_at: :desc)
    @properties = Property.limit(6).order(created_at: :desc)
  end


  def offers
  end

  def about
    @admin_config = AdminConfig.instance
  end

  def contact
  end

  def submit_contact
    puts "Contact submitted"
    puts params.inspect
    if AdminConfig.instance.contact_email.present?
      BookingMailer.contact_email(params[:email], params[:message], params[:subject]).deliver_now
    else
      redirect_to contact_path, notice: "Admin email is not set. Please contact the administrator."
      return
    end
    redirect_to contact_path, notice: "Thank you for contacting us. We will get back to you soon."
  end
end
