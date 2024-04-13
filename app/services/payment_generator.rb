require 'paypal-sdk-rest'
include PayPal::SDK::REST

module PaymentGenerator
  def self.generate_order_payment(order_row)
    payment = Payment.new({
                              "intent" => "sale",
                              "redirect_urls" => {
                                  "return_url" => order_row.web? ? APP_CONFIG['order_paypal_return_url'] :  APP_CONFIG['mob_order_paypal_return_url'],
                                  "cancel_url" => order_row.web? ? APP_CONFIG['order_paypal_cancel_url']: APP_CONFIG['mob_order_paypal_cancel_url']
                              },
                              "payer" => {
                                  "payment_method" => "paypal"},
                              "transactions" => [{

                                                     "amount" => {
                                                         "total" => order_row.paid,
                                                         "currency" => "USD"},
                                                     "description" => "You are asking to use " + order_row.service.description + " service with amount " + order_row.order_details.map(&:amount).sum.to_s + ". This service will cost you " + order_row.paid.to_s + " $. Order's code is " + order_row.order_code}]})
  end

  def self.generate_sub_payment(subscription)
    if subscription.subscription_service.sub_type == 'limited'
      description = "You are asking to use #{subscription.subscription_service.description} service with amount #{subscription.likes_count.to_s} for #{subscription.posts_count.to_s} posts. This service will cost you #{subscription.paid.to_s} $. Order's code is #{subscription.order_code}"
    else
      description = "You are asking to use #{subscription.subscription_service.description} service with amount #{subscription.likes_count.to_s} for 1 month. This service will cost you #{subscription.paid.to_s} $. Order's code is #{subscription.order_code}"
    end
    payment = Payment.new({
                              "intent" => "sale",
                              "redirect_urls" => {
                                  "return_url" => APP_CONFIG['sub_paypal_return_url'],
                                  "cancel_url" => APP_CONFIG['sub_paypal_cancel_url']
                              },
                              "payer" => {
                                  "payment_method" => "paypal"},
                              "transactions" => [{

                                                     "amount" => {
                                                         "total" => subscription.paid,
                                                         "currency" => "USD"},
                                                     "description" => description}]})
  end

  def self.get_payment(payment_id)
    Payment.find(payment_id)
  end
end