# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid_connect, {
    discovery: true,
    issuer: "http://keycloak:8080/realms/myrealm",
    client_auth_method: 'jwks',
  }
end
