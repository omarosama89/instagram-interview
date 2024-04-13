class OrderDetail < ApplicationRecord
  belongs_to :order_row
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  enum status: {placed: 0, pending: 1, processing: 2, completed: 3, failed: 4, in_queue: 5, error: 6}
  enum api_status: {Pending: 'pending', Processing: 'processing', Completed: 'completed', Refunded: 'failed', 'Refunded Partial'.to_sym => 'failed' , Merged: 'processing', 'In Queue'.to_sym => 'pending', Error: 'error'}

  after_save :send_in_queue_link, if: ->{self.status_changed? && self.status == 'in_queue'}

  scope :verified_and_not_sent, -> {joins(:order_row).where('order_rows.verified = ? AND status = ?', true, OrderDetail.statuses[:placed])}
  scope :verified_and_sent, -> {joins(:order_row).where('order_rows.verified = ? AND status != ? AND status != ? AND status != ? AND status != ? AND status != ?', true, OrderDetail.statuses[:placed], OrderDetail.statuses[:completed], OrderDetail.statuses[:failed], OrderDetail.statuses[:in_queue], OrderDetail.statuses[:error])}
  scope :in_queue, -> {OrderDetail.where('status = ?', OrderDetail.statuses[:in_queue])}
  def url
    self.order_row.service.api.url
  end

  def send_body
    service = self.order_row.service
    api = service.api

    case service.service_family
    when 'likes'
      body = {
          api.key_attr.to_sym => api.key,
          api.action_attr.to_sym => 'add',
          api.type_attr.to_sym => service.s_type,
          api.amount_attr.to_sym => self.amount.to_s,
          api.link_attr.to_sym => self.link
      }
    when 'followers'
      body = {
          api.key_attr.to_sym => api.key,
          api.action_attr.to_sym => 'add',
          api.type_attr.to_sym => service.s_type,
          api.amount_attr.to_sym => self.amount.to_s,
          api.link_attr.to_sym => self.link
      }
    when 'video_views'
      body = {
          api.key_attr.to_sym => api.key,
          api.action_attr.to_sym => 'add',
          api.type_attr.to_sym => service.s_type,
          api.amount_attr.to_sym => self.amount.to_s,
          api.link_attr.to_sym => self.link
      }
    when 'comments'
      body = {
          api.key_attr.to_sym => api.key,
          api.action_attr.to_sym => 'add',
          api.type_attr.to_sym => service.s_type,
          api.amount_attr.to_sym => self.amount.to_s,
          api.link_attr.to_sym => self.link
      }
    when 'custom_comments'
      body = {
          api.key_attr.to_sym => api.key,
          api.action_attr.to_sym => 'add',
          api.type_attr.to_sym => service.s_type,
          api.link_attr.to_sym => self.link,
          api.custom_comments_attr.to_sym => comments_str
      }
    end
  end

  def status_body
    api = self.order_row.service.api
    {
        api.key_attr.to_sym => api.key,
        api.action_attr.to_sym => 'status',
        api.orderid_attr.to_sym => self.api_order_id
    }
  end

  def send_link
    req_method = self.order_row.service.req_method
    response = ApiOrderService.send_order(req_method, self.url, self.send_body)
    if response["status"].present?
      case response["status"]
      when 'ok'
        self.update(status: 'pending', api_order_id: response["order"])
      when '500'
      when 'fail'
        if response["message"] == "It looks like we already have an order processing in our system for your requested link. Please wait until its complete and then try again"
          self.update(status: 'in_queue')
        else
          self.update(status: 'failed')
        end
      end
    else
      if response["order"].present?
        self.update(status: 'pending', api_order_id: response["order"])
      else
        self.update(status: 'failed')
      end
    end

  end

  def update_status
    response = ApiOrderService.get_order_status(self.url, self.status_body)
    if response["status"] == 'ok'
      self.update(status: OrderDetail.api_statuses[response["order_status"]])
    end
  end

  def reset_order
    self.update(status: 'placed')
  end

  private
  def comments_str
    '[' + self.comments.map(&:text).join(',') + ']'
  end

  def send_in_queue_link
    self.delay(run_at: 10.minutes.from_now).send_link
  end
end
