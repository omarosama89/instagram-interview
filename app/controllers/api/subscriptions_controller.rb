class Api::SubscriptionsController < Api::ApiApplicationControllerController
  before_action :set_subscription, only: [:show]

  def show
  end

  def create
    subscription = SubscriptionGenerator.generate_subscription(params, request.remote_ip)
    subscription = Subscription.includes(:subscription_service).find(subscription.id)
    payment = PaymentGenerator.generate_sub_payment(subscription)
    if payment.create
      subscription.update(payment_id: payment.id)
      redirect_to payment.links.find {|v| v.method == "REDIRECT"}.href
    else
      redirect_to "#{APP_CONFIG['host']}/#{subscription.class.to_s.underscore.gsub('_', '-')}/-1"
    end
  end

  def approve
    payment_id = params["paymentId"]
    payer_id = params["PayerID"]
    payment = PaymentGenerator.get_payment(payment_id)
    subscription = Subscription.find_by(payment_id: payment_id)
    client = ClientService.add_client_if_not_exist(payer_id, payment)
    if !client.nil?
      if payment.state == 'created'
        payment.execute(payer_id: payer_id)
        if payment.state == 'approved'
          subscription.update(verified: true, client_id: client.id)
          redirect_to "#{APP_CONFIG['host']}/#{subscription.class.to_s.underscore.gsub('_', '-')}/#{subscription.id}"
        else
          redirect_to "#{APP_CONFIG['host']}/#{subscription.class.to_s.underscore.gsub('_', '-')}/-2"
        end
      else
        redirect_to "#{APP_CONFIG['host']}/#{subscription.class.to_s.underscore.gsub('_', '-')}/-1"
      end
    end
  end

  def cancel
    redirect_to "#{APP_CONFIG['host']}/#{Subscription.to_s.underscore.gsub('_', '-')}/-3"
  end

  def get_price
    service_id = params[:service_id]
    posts_coount = params[:posts_count]
    likes_count = params[:likes_count]
    @price = Price.calculate_sub_price(likes_count, posts_coount, service_id)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
