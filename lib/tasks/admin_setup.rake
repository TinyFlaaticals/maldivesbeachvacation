namespace :admin do
  desc "Create admin user with email and password"
  task :create, [ :email, :password ] => :environment do |task, args|
    email = args[:email]
    password = args[:password]

    if email.blank? || password.blank?
      puts "❌ Usage: rails admin:create[email,password]"
      puts "   Example: rails admin:create[admin@yourdomain.com,secure_password]"
      exit 1
    end

    if Admin.exists?(email: email)
      puts "⚠️  Admin with email '#{email}' already exists!"
      exit 1
    end

    admin = Admin.create!(
      email: email,
      password: password,
      password_confirmation: password
    )

    puts "✅ Admin user created successfully!"
    puts "   Email: #{admin.email}"
    puts "   Login at: #{Rails.application.routes.url_helpers.new_admin_session_url}"
    puts ""
    puts "🔐 Save these credentials securely:"
    puts "   Email: #{email}"
    puts "   Password: #{password}"
  rescue ActiveRecord::RecordInvalid => e
    puts "❌ Failed to create admin user:"
    puts "   #{e.message}"
    exit 1
  end

  desc "Reset admin password"
  task :reset_password, [ :email, :new_password ] => :environment do |task, args|
    email = args[:email]
    new_password = args[:new_password]

    if email.blank? || new_password.blank?
      puts "❌ Usage: rails admin:reset_password[email,new_password]"
      exit 1
    end

    admin = Admin.find_by(email: email)
    if admin.nil?
      puts "❌ Admin with email '#{email}' not found!"
      exit 1
    end

    admin.update!(
      password: new_password,
      password_confirmation: new_password
    )

    puts "✅ Admin password updated successfully!"
    puts "   Email: #{admin.email}"
    puts "   New Password: #{new_password}"
  rescue ActiveRecord::RecordInvalid => e
    puts "❌ Failed to update password:"
    puts "   #{e.message}"
    exit 1
  end

  desc "List all admin users"
  task list: :environment do
    admins = Admin.all

    if admins.empty?
      puts "📭 No admin users found."
      puts "   Create one with: rails admin:create[email,password]"
    else
      puts "👥 Admin Users:"
      admins.each_with_index do |admin, index|
        puts "   #{index + 1}. #{admin.email} (created: #{admin.created_at.strftime('%Y-%m-%d')})"
      end
    end
  end
end
