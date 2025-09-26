# Rack Attack Configuration for Email Security
class Rack::Attack
  # Enable rack-attack
  Rack::Attack.enabled = true

  # Cache store for rate limiting
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  ### Configure Cache ###
  # If you don't want to use Rails.cache (Rack::Attack's default), then
  # configure it here.
  #
  # Note: The store is only used for throttling (not blacklisting and
  # whitelisting). It must implement .read, .write, and .delete methods.
  # Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  ### Throttle Spammy Clients ###

  # Throttle all requests by IP (60rpm)
  throttle('req/ip', limit: 60, period: 1.minute) do |req|
    req.ip
  end

  # Throttle POST requests to /contact by IP address
  # Allow 3 contact form submissions per 5 minutes per IP
  throttle('contact_form/ip', limit: 3, period: 5.minutes) do |req|
    if req.path == '/contact' && req.post?
      req.ip
    end
  end

  # Throttle POST requests to booking forms by IP address
  # Allow 5 booking attempts per 10 minutes per IP
  throttle('booking_form/ip', limit: 5, period: 10.minutes) do |req|
    if req.path.include?('/bookings') && req.post?
      req.ip
    end
  end

  # Block suspicious IPs that are email bombing
  blocklist('block_email_bombers') do |req|
    # Block the specific IP that's attacking
    req.ip == '185.39.19.21'
  end

  # Throttle contact form submissions by email
  # Allow 2 submissions per hour from same email
  throttle('contact_form/email', limit: 2, period: 1.hour) do |req|
    if req.path == '/contact' && req.post?
      # Extract email from form params
      req.params['email'].presence
    end
  end

  ### Custom Throttle Response ###
  self.throttled_response = lambda do |env|
    retry_after = (env['rack.attack.match_data'] || {})[:period]
    [
      429,
      {
        'Content-Type' => 'application/json',
        'Retry-After' => retry_after.to_s
      },
      [{ error: "Too many requests. Please try again later.", retry_after: retry_after }.to_json]
    ]
  end

  ### Logging ###
  ActiveSupport::Notifications.subscribe('rack.attack') do |name, start, finish, request_id, req|
    Rails.logger.info "[Rack::Attack][Blocked] remote_ip: \"#{req.ip}\", path: \"#{req.path}\", matched: \"#{req.env['rack.attack.matched']}\""
  end
end
