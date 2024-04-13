module NetIncomeService
  def self.create_document(period, date = nil)
    amount_net = get_amount_net(period, date)
    total_orders = get_total_orders(period, date)
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
    average = (amount_net / total_orders).round(2)
    average = average.nan? ? 0 : average
    NetIncome.create(start_at: start_at, end_at: end_at, period: period, total: amount_net, average: average, number_of_orders: total_orders)
  end


  private

  def self.get_amount_net(period, date)

    case period
    when 'day'
      order_rows = OrderRow.verified.where(created_at: date ? date.beginning_of_day..date.to_date.next_day.beginning_of_day : 1.day.ago.beginning_of_day..0.day.ago.beginning_of_day)
    when 'week'
      order_rows = OrderRow.verified.where(created_at: date ? date.beginning_of_day..date.to_date.next_week.beginning_of_day : 1.week.ago.beginning_of_day..0.week.ago.beginning_of_day)
    when 'month'
      order_rows = OrderRow.verified.where(created_at: date ? date.beginning_of_day..date.to_date.next_month.beginning_of_day : 1.month.ago.beginning_of_day..0.month.ago.beginning_of_day)
    when 'year'
      order_rows = OrderRow.verified.where(created_at: date ? date.beginning_of_day..date.to_date.next_year.beginning_of_day : 1.year.ago.beginning_of_day..0.year.ago.beginning_of_day)
    end
    order_rows.map(&:net).sum.round(2)
  end

  def self.get_total_orders(period, date)
    case period
    when 'day'
      order_rows = OrderRow.verified.where(created_at: date ? date.beginning_of_day..date.to_date.next_day.beginning_of_day : 1.day.ago.beginning_of_day..0.day.ago.beginning_of_day)
    when 'week'
      order_rows = OrderRow.verified.where(created_at: date ? date.beginning_of_day..date.to_date.next_week.beginning_of_day : 1.week.ago.beginning_of_day..0.week.ago.beginning_of_day)
    when 'month'
      order_rows = OrderRow.verified.where(created_at: date ? date.beginning_of_day..date.to_date.next_month.beginning_of_day : 1.month.ago.beginning_of_day..0.month.ago.beginning_of_day)
    when 'year'
      order_rows = OrderRow.verified.where(created_at: date ? date.beginning_of_day..date.to_date.next_year.beginning_of_day : 1.year.ago.beginning_of_day..0.year.ago.beginning_of_day)
    end
    order_rows.count
  end
end
