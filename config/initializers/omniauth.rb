# config/initializers/omniauth.rb
require 'openssl'

# TODO: 外部化
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid_connect, {
    discovery: true,
    issuer: "https://keycloak:8443/realms/myrealm",
    client_auth_method: 'jwks',
    client_options: {
      identifier: "myrealm-id",
      redirect_uri: "http://localhost:3001/auth/openid_connect/callback",
    }
  }
end
