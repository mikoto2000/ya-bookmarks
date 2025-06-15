require 'faraday'

# TODO: 開発環境でのみ verify を OFF にする仕組みを追加
Faraday.default_connection_options = Faraday::ConnectionOptions.new(
  ssl: { verify: false }
)

