# Resend API Configuration
require 'resend'

# Configure Resend API key
Resend.api_key = Rails.application.credentials.resend_api_key || ENV['RESEND_API_KEY'] || 're_RkiRrkpk_5Lp2qpM23qZgf235uizdZ9X5'

# Custom ActionMailer delivery method for Resend
class ResendDelivery
  def initialize(settings = {})
    @settings = settings
  end

  def deliver!(mail)
    Rails.logger.info "=== RESEND DELIVERY METHOD CALLED ==="
    Rails.logger.info "Mail from: #{mail.from}"
    Rails.logger.info "Mail to: #{mail.to}"
    Rails.logger.info "Mail subject: #{mail.subject}"
    
    # Convert mail object to Resend format
    resend_params = {
      from: mail.from.first,
      to: mail.to,
      subject: mail.subject
    }
    
    # Add HTML content if present
    if mail.html_part
      resend_params[:html] = mail.html_part.body.to_s
    elsif mail.content_type&.include?('text/html')
      resend_params[:html] = mail.body.to_s
    else
      # Default to HTML if no specific content type
      resend_params[:html] = mail.body.to_s
    end
    
    # Add text content if present
    if mail.text_part
      resend_params[:text] = mail.text_part.body.to_s
    elsif mail.content_type&.include?('text/plain')
      resend_params[:text] = mail.body.to_s
    end
    
    # Add CC if present
    resend_params[:cc] = mail.cc if mail.cc&.any?
    
    # Add BCC if present  
    resend_params[:bcc] = mail.bcc if mail.bcc&.any?
    
    Rails.logger.info "Resend params: #{resend_params.inspect}"
    
    # Send email via Resend API
    response = Resend::Emails.send(resend_params)
    
    # Log the response
    Rails.logger.info "=== RESEND API SUCCESS ==="
    Rails.logger.info "Resend API Response: #{response.inspect}"
    
    # Return the mail object as ActionMailer expects
    mail
  rescue => e
    Rails.logger.error "=== RESEND DELIVERY FAILED ==="
    Rails.logger.error "Error: #{e.message}"
    Rails.logger.error "Backtrace: #{e.backtrace.first(5).join("\n")}"
    raise e
  end
end

# Register the custom delivery method
ActionMailer::Base.add_delivery_method :resend, ResendDelivery
