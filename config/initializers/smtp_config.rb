# SMTP Configuration for Google Workspace Relay
if Rails.env.development?
  ActionMailer::Base.smtp_settings = {
    address: "smtp-relay.gmail.com",
    port: 587,
    domain: "summerdust.com", # Your verified domain
    enable_starttls_auto: true,
    open_timeout: 5,
    read_timeout: 5
  }

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
end
