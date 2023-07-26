module SerraApi
  module Resources
    class PaymentRequestQrcodeResource < PngResource
      def qrcode(account_number, id)
        get("/exchange/accounts/#{account_number}/paymentrequests/#{id}/qrcode")

        response_body
      end
    end
  end
end