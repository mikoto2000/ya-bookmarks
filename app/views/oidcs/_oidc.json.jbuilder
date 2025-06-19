json.extract! oidc, :id, :issuer, :sub, :account_id, :created_at, :updated_at
json.url oidc_url(oidc, format: :json)
