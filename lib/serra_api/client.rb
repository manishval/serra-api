require 'oauth2'

module SerraApi
  class Client
    BASE_URL = ENV['SERRA_API_BASE_URL'].freeze
    AUTH_BASE_URL = ENV['SERRA_AUTH_BASE_URL'].freeze
    TOKEN_URL = ENV['SERRA_TOKEN_URL'].freeze

    attr_reader :auth_token

    def initialize
      @auth_token = fetch_token
    end

    def user
      @user ||= Resources::UserResource.new(self)
    end

    def payment_requests
      @payment_requests ||= Resources::PaymentRequestResource.new(self)
    end

    def payment_requests_qrcode
      @qrcodes ||= Resources::PaymentRequestQrcodeResource.new(self)
    end

    private

    def fetch_token
      token = oauth_client.client_credentials.get_token
      token.token
    end

    def oauth_client
      OAuth2::Client.new(
        ENV['SERRA_CLIENT_ID'], 
        ENV['SERRA_CLIENT_SECRET'], 
        site: AUTH_BASE_URL,
        token_url: TOKEN_URL
      )
    end
  end
end