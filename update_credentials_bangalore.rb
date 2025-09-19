#!/usr/bin/env ruby

require 'rails/all'
require 'active_support/encrypted_configuration'

Rails.application = Class.new(Rails::Application).new
Rails.application.config.load_defaults 8.0

key_path = Rails.root.join('config/credentials/production.key')
credentials_path = Rails.root.join('config/credentials/production.yml.enc')

# Read the key
key = File.read(key_path).strip

# Create the new credentials content with correct Bangalore region
new_content = <<~YAML
smtp:
  username: hello@maldivesbeachvacation.com
  password: rhnr nuxt rrzy uwau

digitalocean:
  access_key_id: DO0088U6T3TXPCD7DKAR
  secret_access_key: ghvwws2x8khAKpnq/0Gm0bOu3HJALllAcpipaDMNdus
  region: blr1
  bucket: maldives-vacation-production-storage
  endpoint: https://blr1.digitaloceanspaces.com

secret_key_base: 9793876a27433944451394315b1a4f2a6f380884a38e886fa8d33601a235d3ec60bcc3323ec3650febcd2e2f21b283d3e707012860d66d28e1ec70006aef9b74
YAML

# Encrypt and write the credentials
encryptor = ActiveSupport::MessageEncryptor.new([key].pack('H*'), cipher: 'aes-128-gcm')
encrypted_data = encryptor.encrypt_and_sign(new_content)
File.write(credentials_path, encrypted_data)

puts "✅ Production credentials updated with Bangalore region!"
puts "   - Region: blr1 (Bangalore)"
puts "   - Endpoint: https://blr1.digitaloceanspaces.com"
puts "   - Bucket: maldives-vacation-production-storage"
