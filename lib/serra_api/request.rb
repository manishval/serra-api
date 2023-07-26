require 'net/http'

module SerraApi
  class Request
    def initialize(client)
      @client = client
    end

    def get(path, params = {})
      uri = uri(path)

      uri.query = URI.encode_www_form(params)

      request(uri, Net::HTTP::Get)
    end

    def post(path, params)
      uri = uri(path)
      request(uri, Net::HTTP::Post, params)
    end

    def put(path, params)
      uri = uri(path)
      request(uri, Net::HTTP::Put, params)
    end

    def delete(path, params = {})
      uri = uri(path)

      uri.query = URI.encode_www_form(params)

      request(uri, Net::HTTP::Delete, params)
    end

    private

    def uri(path)
      URI.parse(SerraApi::Client::BASE_URL + path)
    end

    def request(uri, klass, params = nil)
      request = klass.new(uri.request_uri)

      if params
        request.body = params.to_json
      end

      response = make_request(uri, request)

      ensure_success(response, uri, params)

      response
    end

    def make_request(uri, request)
      add_headers(request)
      http = http_object(uri)
      http.request(request)
    end

    def add_headers(request)
      request.add_field('Content-Type', 'application/json')
      request.add_field('Authorization', "Bearer #{@client.auth_token}")
    end

    def http_object(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.open_timeout = 30
      http.read_timeout = 30

      http
    end

    def ensure_success(response, uri, params = nil)
      if response.code != '200' && response.code != '201'
        message = "SerraApi error - uri: #{uri} - params: #{params}"
        raise SerraApi::RequestError.new(message, response.code, response.body)
      end
    end
  end
end