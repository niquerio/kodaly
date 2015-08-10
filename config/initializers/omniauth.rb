OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '641388164631-33jia7p6rcobnaci0clh0ni51a1ob61d.apps.googleusercontent.com', 'ab5Jpy5nD7KOwjMQFJiSAwLM', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  provider :facebook, '1640019402887928', '921e9770ac2d799d92ea82f528d96206', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end


#Rails.application.config.middleware.use OmniAuth::Builder do
#end
