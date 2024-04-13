module ProductService

  def self.create_document(service_family, period, date = nil)
    amount_products = get_amount_products(service_family, period, date)
    total_products = get_total_products(period, date)
    service = Service.find_by(service_family: Service::service_families[service_family.to_sym])
    case period
    when 'day'
      start_at = date ? date.beginning_of_day : 1.day.ago.beginning_of_day
      end_at = date ? date.to_date.next_day.beginning_of_day : 0.day.ago.beginning_of_day
    when 'week'
      start_at = date ? date.beginning_of_day : 1.week.ago.beginning_of_day
      end_at = date ? date.to_date.next_week.beginning_of_day : 0.week.ago.beginning_of_day
    when 'month'
      start_at = date ? date.beginning_of_day : 1.month.ago.beginning_of_day
      end_at = date ? date.to_date.next_month.beginning_of_day : 0.month.ago.beginning_of_day
    when 'year'
      start_at = date ? date.beginning_of_day : 1.year.ago.beginning_of_day
      end_at = date ? date.to_date.next_year.beginning_of_day : 0.year.ago.beginning_of_day
    end
    percentage = ((amount_products.to_f / total_products) * 100).round(2)
    percentage = percentage.nan? ? 0 : percentage
    Product.create(start_at: start_at, end_at: end_at, period: period, product_type: service.description, service_family: service_family, amount: amount_products, percentage: percentage)
  end


  private

  def self.get_amount_products(service_family, period, date)

    case period
    when 'day'
      order_rows = OrderRow.specify_service(service_family).where(created_at: date ? date.beginning_of_day..date.to_date.next_day.beginning_of_day : 1.day.ago.beginning_of_day..0.day.ago.beginning_of_day)
    when 'week'
      order_rows = OrderRow.specify_service(service_family).where(created_at: date ? date.beginning_of_day..date.to_date.next_week.beginning_of_day : 1.week.ago.beginning_of_day..0.week.ago.beginning_of_day)
    when 'month'
      order_rows = OrderRow.specify_service(service_family).where(created_at: date ? date.beginning_of_day..date.to_date.next_month.beginning_of_day : 1.month.ago.beginning_of_day..0.month.ago.beginning_of_day)
    when 'year'
      order_rows = OrderRow.specify_service(service_family).where(created_at: date ? date.beginning_of_day..date.to_date.next_year.beginning_of_day : 1.year.ago.beginning_of_day..0.year.ago.beginning_of_day)
    end
    order_rows.count
  end

  def self.get_total_products(period, date)
    case period
    when 'day'
      order_rows = OrderRow.where(created_at: date ? date.beginning_of_day..date.to_date.next_day.beginning_of_day : 1.day.ago.beginning_of_day..0.day.ago.beginning_of_day)
    when 'week'
      order_rows = OrderRow.where(created_at: date ? date.beginning_of_day..date.to_date.next_week.beginning_of_day : 1.week.ago.beginning_of_day..0.week.ago.beginning_of_day)
    when 'month'
      order_rows = OrderRow.where(created_at: date ? date.beginning_of_day..date.to_date.next_month.beginning_of_day : 1.month.ago.beginning_of_day..0.month.ago.beginning_of_day)
    when 'year'
      order_rows = OrderRow.where(created_at: date ? date.beginning_of_day..date.to_date.next_year.beginning_of_day : 1.year.ago.beginning_of_day..0.year.ago.beginning_of_day)
    end
    order_rows.count
  end
end
