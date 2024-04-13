module ClientService
  def self.add_client_if_not_exist(payer_id, payment)
    if is_client_not_exist(payer_id)
      begin
        client = Client.create({payer_id: payer_id,
                                email: payment.payer.payer_info.email,
                                country: payment.payer.payer_info.billing_address.country_code,
                                state: payment.payer.payer_info.billing_address.state,
                                city: payment.payer.payer_info.billing_address.city,
                                postal_code: payment.payer.payer_info.billing_address.postal_code,
                                first_name: payment.payer.payer_info.first_name,
                                last_name: payment.payer.payer_info.last_name})
      rescue
        return nil
      end
      return client
    else
      client = Client.find_by(payer_id: payer_id)
      # client.touch
      return client
    end
  end

  private

  def self.is_client_not_exist(payer_id)
    client = Client.find_by(payer_id: payer_id)
    if client.nil?
      return true
    else
      return false
    end
  end
end