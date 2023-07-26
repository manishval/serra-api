module SerraApi
  module Resources
    class UserResource < BaseResource
      def info
        get('/oauth/connect/userinfo')

        SerraApi::Models::UserModel.new(response_body)
      end
    end
  end
end