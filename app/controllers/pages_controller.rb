class PagesController < ApplicationController
  def home
    @admin_config = AdminConfig.instance
    @stories = Story.limit(10).order(created_at: :desc)
    @properties = Property.limit(6).order(created_at: :desc)
  end


  def offers
  end

  def about
    @admin_config = AdminConfig.instance
  end

  def contact
    @admin_config = AdminConfig.instance
  rescue => e
    Rails.logger.error "Error loading AdminConfig: #{e.message}"
    @admin_config = AdminConfig.new
  end

  def submit_contact
    Rails.logger.info "Contact form submitted: #{params.inspect}"
    Rails.logger.info "Contact form submitted from IP: #{request.remote_ip}"

    # Basic spam detection
    if spam_detected?
      Rails.logger.warn "Spam detected from IP: #{request.remote_ip}, Email: #{params[:email]}"
      redirect_to contact_path, alert: "Your message appears to be spam. Please try again with a genuine message."
      return
    end

    begin
      admin_config = AdminConfig.instance
      if admin_config.contact_email.present?
        # Send notification to admin (asynchronously)
        BookingMailer.contact_email(params[:email], params[:message], params[:subject]).deliver_later
        # Send confirmation to user (asynchronously)
        BookingMailer.contact_confirmation(params[:email], params[:message], params[:subject]).deliver_later

        Rails.logger.info "Contact form emails queued successfully from IP: #{request.remote_ip}"
        redirect_to contact_path, notice: "Thank you for contacting us. We will get back to you soon."
      else
        Rails.logger.error "Admin email not configured"
        redirect_to contact_path, alert: "Admin email is not set. Please contact the administrator."
      end
    rescue => e
      Rails.logger.error "Error processing contact form: #{e.message}"
      Rails.logger.error "Backtrace: #{e.backtrace.first(5).join("\n")}"
      redirect_to contact_path, alert: "Sorry, there was an error sending your message. Please try again later."
    end
  end

  private

  def spam_detected?
    email = params[:email]&.downcase
    message = params[:message]&.downcase
    subject = params[:subject]&.downcase

    # Check for known spam patterns
    spam_patterns = [
      /seagullelectronics\.com/i,
      /walkerandpaul\.com/i,
      /aloha.*price/i,
      /makemake wau/i,
      /γεια σου/i,
      /reseller/i
    ]

    # Check for suspicious email domains or patterns
    suspicious_domains = [
      "seagullelectronics.com",
      "walkerandpaul.com"
    ]

    # Check if email contains suspicious domains
    return true if email && suspicious_domains.any? { |domain| email.include?(domain) }

    # Check if message contains spam patterns
    return true if message && spam_patterns.any? { |pattern| message.match?(pattern) }

    # Check if subject contains spam patterns
    return true if subject && spam_patterns.any? { |pattern| subject.match?(pattern) }

    false
  end
end
