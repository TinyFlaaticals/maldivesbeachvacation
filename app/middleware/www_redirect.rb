class WwwRedirect
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    
    # Only redirect in production
    if Rails.env.production? && request.host.start_with?('www.')
      # Redirect www to non-www
      non_www_url = "#{request.scheme}://#{request.host.sub(/^www\./, '')}#{request.fullpath}"
      [301, { 'Location' => non_www_url }, ['Moved Permanently']]
    else
      @app.call(env)
    end
  end
end
