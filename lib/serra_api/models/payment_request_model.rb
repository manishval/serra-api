module SerraApi
  module Models
    class PaymentRequestModel < BaseModel
      def qr_code_url
        _links['paymentRequestQrCode']['href']
      end
    end
  end
end