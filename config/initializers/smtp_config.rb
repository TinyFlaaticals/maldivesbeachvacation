# Gmail SMTP Configuration - Disabled for development
# Using test delivery method in development to avoid SMTP authentication issues
# 
# if Rails.env.development?
#   ActionMailer::Base.smtp_settings = {
#     address: "smtp.gmail.com",
#     port: 587,
#     domain: "summerdust.com",
#     user_name: ENV['GMAIL_USERNAME'], # Set via environment variable
#     password: ENV['GMAIL_APP_PASSWORD'], # Set via environment variable  
#     authentication: :plain,
#     enable_starttls_auto: true,
#     open_timeout: 5,
#     read_timeout: 5
#   }
#
#   ActionMailer::Base.delivery_method = :smtp
#   ActionMailer::Base.perform_deliveries = true
#   ActionMailer::Base.raise_delivery_errors = true
# end
