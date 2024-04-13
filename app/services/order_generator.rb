module OrderGenerator
  def self.generate_order(params)
    kind = params[:kind] || 'web'
    service_id = params[:service_id]
    links_arr = params[:links].split(',').delete_if(&:empty?)
    amounts_arr = params[:amounts].split(',').delete_if(&:empty?).map(&:to_i)
    comments_2d_arr = params[:custom_comments].split('~~').map {|x| x.split('~')}.map {|x| x.delete_if(&:empty?)}
    total_amount = amounts_arr.reduce(&:+)
    service = Service.find_by(id: service_id)
    begin
      order_row = OrderRow.create(service_id: service_id, paid: Price.calculate_order_price(total_amount, service_id), kind: kind)
    rescue Exception => e
      order_row.errors[:order_row] << "#{e.message}"
      return order_row
    end

    links_arr.each_with_index do |link, idx|
      begin
        order_detail = order_row.order_details.create(link: link, amount: amounts_arr[idx])
      rescue Exception => e
        order_row.errors[:order_detail] << "#{e.message}"
        return order_row
      end
      if service.service_family == 'custom_comments'
        comments_2d_arr[idx].each do |comment|
          begin
            order_detail.comments.create(text: comment)
          rescue Exception => e
            order_row.errors[:commment] << "#{e.message}"
            return order_row
          end
        end
      end
    end
    return order_row
  end
end