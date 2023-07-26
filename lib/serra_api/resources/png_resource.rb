require 'json'

module SerraApi
  module Resources
    class PngResource
      def initialize(client)
        @client = client
      end

      private

      def get(path, params = {})
        @response = request.get(path, params)
      end

      def request
        @request ||= SerraApi::Request.new(@client)
      end

      def response_body
        @response.body
      end
    end
  end
end