class Api::StatisticsController < Api::ApiApplicationControllerController
  def index
    @clients_count = Client.all.count
    @orders_served = OrderDetail.all.count
    @likes = OrderRow.specify_service('likes').map(&:order_details).flatten.map(&:amount).map(&:to_i).sum
    @followers = OrderRow.specify_service('followers').map(&:order_details).flatten.map(&:amount).map(&:to_i).sum
  end
end
