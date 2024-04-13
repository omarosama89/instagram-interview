module CustomerService

  def self.create_document(client_id, period, date = nil)
    amount_net = get_amount_net(client_id, period, date)
    total_net = get_total_net(period, date)

    amount_orders = get_amount_orders(client_id, period, date)
    total_orders = get_total_orders(period, date)

    amount_links = get_amount_links(client_id, period, date)
    total_links = get_total_links(period, date)

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
    percentage_net = (amount_net.to_f / total_net).round(2) * 100
    percentage_net = percentage_net.nan? ? 0 : percentage_net
    percentage_orders = (amount_orders.to_f / total_orders).round(2) * 100
    percentage_orders = percentage_orders.nan? ? 0 : percentage_orders
    percentage_links = (amount_links.to_f / total_links).round(2) * 100
    percentage_links = percentage_links.nan? ? 0 : percentage_links
    Customer.create(start_at: start_at, end_at: end_at, period: period, client_id: client_id, amount_net: amount_net, percentage_net: percentage_net, amount_orders: amount_orders, percentage_orders: percentage_orders, amount_links: amount_links, percentage_links: percentage_links)
  end


  private

  def self.get_amount_net(client_id, period, date)

    case period
    when 'day'
      order_rows = OrderRow.where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_day.beginning_of_day : 1.day.ago.beginning_of_day..0.day.ago.beginning_of_day)
    when 'week'
      order_rows = OrderRow.where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_week.beginning_of_day : 1.week.ago.beginning_of_day..0.week.ago.beginning_of_day)
    when 'month'
      order_rows = OrderRow.where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_month.beginning_of_day : 1.month.ago.beginning_of_day..0.month.ago.beginning_of_day)
    when 'year'
      order_rows = OrderRow.where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_year.beginning_of_day : 1.year.ago.beginning_of_day..0.year.ago.beginning_of_day)
    end
    order_rows.map(&:net).sum.round(2)
  end

  def self.get_total_net(period, date)
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
    order_rows.map(&:net).sum.round(2)
  end

  def self.get_amount_orders(client_id, period, date)

    case period
    when 'day'
      order_rows = OrderRow.where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_day.beginning_of_day : 1.day.ago.beginning_of_day..0.day.ago.beginning_of_day)
    when 'week'
      order_rows = OrderRow.where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_week.beginning_of_day : 1.week.ago.beginning_of_day..0.week.ago.beginning_of_day)
    when 'month'
      order_rows = OrderRow.where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_month.beginning_of_day : 1.month.ago.beginning_of_day..0.month.ago.beginning_of_day)
    when 'year'
      order_rows = OrderRow.where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_year.beginning_of_day : 1.year.ago.beginning_of_day..0.year.ago.beginning_of_day)
    end
    order_rows.count
  end

  def self.get_total_orders(period, date)
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

  def self.get_amount_links(client_id, period, date)

    case period
    when 'day'
      order_rows = OrderRow.includes(:order_details).where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_day.beginning_of_day : 1.day.ago.beginning_of_day..0.day.ago.beginning_of_day)
    when 'week'
      order_rows = OrderRow.includes(:order_details).where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_week.beginning_of_day : 1.week.ago.beginning_of_day..0.week.ago.beginning_of_day)
    when 'month'
      order_rows = OrderRow.includes(:order_details).where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_month.beginning_of_day : 1.month.ago.beginning_of_day..0.month.ago.beginning_of_day)
    when 'year'
      order_rows = OrderRow.includes(:order_details).where(client_id: client_id, created_at: date ? date.beginning_of_day..date.to_date.next_year.beginning_of_day : 1.year.ago.beginning_of_day..0.year.ago.beginning_of_day)
    end
    order_rows.map(&:order_details).flatten.count
  end

  def self.get_total_links(period, date)
    case period
    when 'day'
      order_rows = OrderRow.includes(:order_details).where(created_at: date ? date.beginning_of_day..date.to_date.next_day.beginning_of_day : 1.day.ago.beginning_of_day..0.day.ago.beginning_of_day)
    when 'week'
      order_rows = OrderRow.includes(:order_details).where(created_at: date ? date.beginning_of_day..date.to_date.next_week.beginning_of_day : 1.week.ago.beginning_of_day..0.week.ago.beginning_of_day)
    when 'month'
      order_rows = OrderRow.includes(:order_details).where(created_at: date ? date.beginning_of_day..date.to_date.next_month.beginning_of_day : 1.month.ago.beginning_of_day..0.month.ago.beginning_of_day)
    when 'year'
      order_rows = OrderRow.includes(:order_details).where(created_at: date ? date.beginning_of_day..date.to_date.next_year.beginning_of_day : 1.year.ago.beginning_of_day..0.year.ago.beginning_of_day)
    end
    order_rows.map(&:order_details).flatten.count
  end
end
