module Price
  def self.calculate_order_price(amount, service_id)
    service = Service.find(service_id)
    price = service.price
    unit = service.unit
    factor = service.factor
    power = service.power
    intercept = service.intercept
    sale = service.sale
    paid = [(((amount.to_f / unit) ** power) * price * factor + intercept) * (1 - sale), 1].max
    paid += (2.9/100)*paid + 0.3
    return paid.round(2)
  end

  def self.calculate_sub_price(amount, posts, subscription_service_id)
    service = SubscriptionService.find(subscription_service_id)
    price = service.price
    unit = service.unit
    factor = service.factor
    power = service.power
    intercept = service.intercept
    sale = service.sale
    if service.sub_type == 'limited'
      paid = [(((amount.to_f / unit) ** power) * price * factor + intercept) * (1 - sale), 1].max
      return (posts.to_i * paid).round(2)
    else
      paid = [(((amount.to_f / unit) ** power) * price * factor + intercept) * (1 - sale), 1].max
      return paid.round(2)
    end
  end
end