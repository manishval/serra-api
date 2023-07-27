require 'oauth2'

module SerraApi
  class Client
    attr_reader :base_url, :auth_base_url, :token_url,
      :client_id, :client_secret, :auth_token

    def initialize(arguments = {})
      @base_url = arguments[:base_url]
      @auth_base_url = arguments[:auth_base_url]
      @token_url = arguments[:token_url]

      @client_id = arguments[:client_id]
      @client_secret = arguments[:client_secret]

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
        @client_id, 
        @client_secret, 
        site: @auth_base_url,
        token_url: @token_url
      )
    end
  end
end