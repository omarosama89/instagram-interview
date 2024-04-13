class OrderRow < ApplicationRecord
  belongs_to :service
  belongs_to :client, optional: true
  has_many :order_details
  # attribute(:order_code, :string, default: 'order-code')
  attribute(:verified, :boolean, default: false)
  accepts_nested_attributes_for :order_details
  enum kind: {web: 0, mob: 1}

  after_create :set_default_values
  after_save :send_links_delayed, :send_receipt_email, if: ->{ self.saved_change_to_attribute?(:verified) && self.verified }



  def paid_iso
    (self.paid * 100).to_i
  end

  def web?
    self.kind == 'web'
  end

  def mob?
    self.kind == 'mob'
  end

  private

  def set_default_values
    self.order_code = "ord-#{set_order_code}"
    self.save!
  end

  def set_order_code
    sprintf('%07d',self.id)
  end

  def send_receipt_email
    ClientMailer.order_receipt_email(self).deliver_now
  end

  def send_links_delayed
    self.order_details.each do |order_detail|
      order_detail.delay.send_link
    end
  end
end
