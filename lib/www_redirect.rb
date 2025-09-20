class WwwRedirect
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    
    # Don't redirect health check or internal requests
    return @app.call(env) if request.path == '/up' || request.user_agent&.include?('kamal-proxy')
    
    # Only redirect in production
    if Rails.env.production? && !request.host.start_with?('www.')
      # Redirect non-www to www
      www_url = "#{request.scheme}://www.#{request.host}#{request.fullpath}"
      [301, { 'Location' => www_url }, ['Moved Permanently']]
    else
      @app.call(env)
    end
  end
end
