class WhatsappService
  include HTTParty

  PHONE_NUMBER_ID = ENV["WHATSAPP_PHONE_NUMBER_ID"]
  ACCESS_TOKEN = ENV["WHATSAPP_ACCESS_TOKEN"]

  def initialize
    @base_url = "https://graph.facebook.com/v17.0/#{PHONE_NUMBER_ID}"
    @access_token = ACCESS_TOKEN
  end

  def send_message(to:, message:)
    body = {
      messaging_product: "whatsapp",
      to: to,
      type: "text",
      text: { body: message }
    }

    response = HTTParty.post(
      "#{@base_url}/messages",
      headers: {
        "Authorization" => "Bearer #{@access_token}",
        "Content-Type" => "application/json"
      },
      body: body.to_json
    )

    handle_response(response)
  end

  def send_template(to:, template_name:, language_code: "en", components: [])
    body = {
      messaging_product: "whatsapp",
      to: to,
      type: "template",
      template: {
        name: template_name,
        language: {
          code: language_code
        },
        components: components
      }
    }

    response = HTTParty.post(
      "#{@base_url}/messages",
      headers: {
        "Authorization" => "Bearer #{@access_token}",
        "Content-Type" => "application/json"
      },
      body: body.to_json
    )

    handle_response(response)
  end

  private

  def handle_response(response)
    case response.code
    when 200
      { success: true, data: response.parsed_response }
    else
      { success: false, error: response.parsed_response }
    end
  end
end
