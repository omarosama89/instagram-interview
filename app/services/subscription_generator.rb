module SubscriptionGenerator
  def self.generate_subscription(params, client_ip)
    username = params[:username]
    subscription_service_id = params[:subscription_service_id]
    likes_count = params[:likes_count]
    posts_count = params[:posts_count]

    subscription = Subscription.new(username: username, likes_count: likes_count, posts_count: posts_count, paid: Price.calculate_sub_price(likes_count, posts_count, subscription_service_id), subscription_service_id: subscription_service_id)
    begin
      subscription.save!
    rescue Exception => e
      return nil
    end
    return subscription
  end
end