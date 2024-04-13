module StripePayment
  Stripe.api_key = "sk_test_4eC39HqLyjWDarjtT1zdp7dc"

  def self.prepare_attributes_to_fit_order_rows(params)
    service_id = params[:service_id]
    links_arr = params[:links].split(',').delete_if(&:empty?)
    amounts_arr = params[:amounts].split(',').delete_if(&:empty?).map(&:to_i)
    comments_2d_arr = params[:custom_comments].split('~~').map {|x| x.split('~')}.map {|x| x.delete_if(&:empty?)}
    total_amount = amounts_arr.reduce(&:+)
    service = Service.find_by(id: service_id)
    order_details_attrs = []
    links_arr.each_with_index do |link, idx|
      comments_attrs = []
      if service.service_family == 'custom_comments'
        comments_2d_arr[idx].each do |comment|
          comments_attrs.push({text: comment})
        end
      end
      order_details_attrs.push({link: link, amount: amounts_arr[idx], comments_attributes: comments_attrs})
    end
    {service_id: service_id, paid: Price.calculate_order_price(total_amount, service_id), order_details_attributes: order_details_attrs}
  end

  def self.execute_payment(amount, token)
    charge = Stripe::Charge.create({
                                       amount: amount,
                                       currency: 'usd',
                                       description: 'Example charge',
                                       source: token,
                                       capture: false,
                                   })
    charge.capture
  end
end