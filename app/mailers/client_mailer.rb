class ClientMailer < ApplicationMailer
  def order_receipt_email(order_row)
    @client = order_row.client
    @order_row = order_row
    @order_details = order_row.order_details
    @service = order_row.service
    mail(to: @client.email, subject: 'Instajax Receipt Email')
  end

  def package_receipt_email(subscription)
    @client = subscription.client
    @subscription = subscription
    @subscription_service = subscription.subscription_service
    mail(to: @client.email, subject: 'Instajax Receipt Email')
  end

  def package_started_email(subscription)
    @client = subscription.client
    @subscription = subscription
    @subscription_service = subscription.subscription_service
    mail(to: @client.email, subject: 'Instajax Package Started')
  end

  def package_ended_email(subscription)
    @client = subscription.client
    @subscription = subscription
    @subscription_service = subscription.subscription_service
    mail(to: @client.email, subject: 'Instajax Package Ended')
  end

  def package_failed_email(subscription)
    @client = subscription.client
    @subscription = subscription
    @subscription_service = subscription.subscription_service
    mail(to: @client.email, subject: 'Instajax Package Failed')
  end
end
