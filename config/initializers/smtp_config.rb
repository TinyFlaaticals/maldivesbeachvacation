# SMTP Configuration for Development
if Rails.env.development?
  ActionMailer::Base.smtp_settings = {
    address: "smtppro.zoho.com",
    port: 587,
    domain: "summerdust.com",
    user_name: "contact@summerdust.com",
    password: "pMeHajZX3vYk",
    authentication: :plain,
    enable_starttls_auto: true,
    open_timeout: 5,
    read_timeout: 5
  }
  
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
end