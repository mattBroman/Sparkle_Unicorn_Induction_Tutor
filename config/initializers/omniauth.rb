OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '331194146660-cabm4n91qsvdhgjt9c1o55k1vepeg66v.apps.googleusercontent.com', 'rq76aj3FyDUSQIy0uwzRjEYJ
', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end