module ClientRecordService

  def self.create(client_id)
    order_rows = OrderRow.includes(:service).where(client_id: client_id)
    total_paid = order_rows.map(&:paid).map(&:to_f).sum
    total_net = order_rows.map(&:net).map(&:to_f).sum
    links = order_rows.map(&:order_details).flatten.count

    likes_orders = order_rows.select {|o| o.service.service_family == 'likes'}
    likes = likes_orders.count
    likes_count = likes_orders.map(&:order_details).flatten.map(&:amount).map(&:to_i).sum

    followers_orders = order_rows.select {|o| o.service.service_family == 'followers'}
    followers = followers_orders.count
    followers_count = followers_orders.map(&:order_details).flatten.map(&:amount).map(&:to_i).sum

    video_views_orders = order_rows.select {|o| o.service.service_family == 'video_views'}
    video_views = video_views_orders.count
    video_views_count = video_views_orders.map(&:order_details).flatten.map(&:amount).map(&:to_i).sum


    comments_orders = order_rows.select {|o| o.service.service_family == 'comments'}
    comments = comments_orders.count
    comments_count = comments_orders.map(&:order_details).flatten.map(&:amount).map(&:to_i).sum

    custom_comments_orders = order_rows.select {|o| o.service.service_family == 'custom_comments'}
    custom_comments = custom_comments_orders.count
    custom_comments_count = custom_comments_orders.map(&:order_details).flatten.map(&:amount).map(&:to_i).sum

    begin
      ClientRecord.create(links: links, likes: likes, likes_count: likes_count, followers: followers, followers_count: followers_count, video_views: video_views, video_views_count: video_views_count, comments: comments, comments_count: comments_count, custom_comments: custom_comments, custom_comments_count: custom_comments_count, total_paid: total_paid, total_net: total_net, client_id: client_id)
    rescue => exception
      Rails.logger.info "cant create client_record for client with id #{client_id}"
    end
  end

  def self.update(order_row)
    service_family = order_row.service.service_family
    client_record = ClientRecord.find_by(client_id: order_row.client_id)
    client_record.links += order_row.order_details.count
    case service_family
    when 'likes'
      client_record.likes += 1
      client_record.likes_count += order_row.order_details.map(&:amount).sum
    when 'followers'
      client_record.followers += 1
      client_record.followers_count += order_row.order_details.map(&:amount).sum
    when 'video_views'
      client_record.video_views += 1
      client_record.video_views_count += order_row.order_details.map(&:amount).sum
    when 'comments'
      client_record.comments += 1
      client_record.comments_count += order_row.order_details.map(&:amount).sum
    when 'custom_comments'
      client_record.custom_comments += 1
      client_record.custom_comments += order_row.order_details.map(&:amount).sum
    end
    client_record.total_paid += order_row.paid
    client_record.total_net += order_row.net
    begin
      client_record.save!
    rescue => exception
      Rails.logger.info "cant update client_record for client with id #{order_row.client_id}"
    end
  end

end