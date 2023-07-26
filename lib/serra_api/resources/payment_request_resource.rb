module SerraApi
  module Resources
    class PaymentRequestResource < BaseResource
      def find(account_number, id)
        get("/exchange/accounts/#{account_number}/paymentrequests/#{id}")

        SerraApi::Models::PaymentRequestModel.new(response_body)
      end

      def create(account_number, currency, value)
        params = {
          currency: currency,
          value: value
        }

        post("/exchange/accounts/#{account_number}/paymentrequests", params)

        SerraApi::Models::PaymentRequestModel.new(response_body)
      end
    end
  end
end