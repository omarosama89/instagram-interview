class Api::OrderRowsController < Api::ApiApplicationControllerController
  before_action :set_order_row, only: [:show]

  def show
  end

  def create_stripe
    attrs = StripePayment.prepare_attributes_to_fit_order_rows(params)
    order_row = OrderRow.new(attrs)
    if order_row.save
      res = StripePayment.execute_payment(order_row.paid_iso, params['stripeToken'])
      if res.status == "succeeded"
        order_row.update(verified: true)
        redirect_to "#{APP_CONFIG['host']}/#{order_row.class.to_s.underscore.gsub('_', '-')}/#{order_row.id}"
      else
        redirect_to "#{APP_CONFIG['host']}/#{order_row.class.to_s.underscore.gsub('_', '-')}/-2"
      end
    end
  end

  def create
    order_row = OrderGenerator.generate_order(params)
    order_row = OrderRow.includes(:service, :order_details).find(order_row.id)
    payment = PaymentGenerator.generate_order_payment(order_row)
    if payment.create
      order_row.update(payment_id: payment.id)
      redirect_to payment.links.find {|v| v.method == "REDIRECT"}.href
    else
      redirect_to "#{APP_CONFIG['host']}/#{order_row.class.to_s.underscore.gsub('_', '-')}/-1"
    end
  end

  def approve
    payment_id = params["paymentId"]
    payer_id = params["PayerID"]
    payment = PaymentGenerator.get_payment(payment_id)
    order_row = OrderRow.find_by(payment_id: payment_id)
    client = ClientService.add_client_if_not_exist(payer_id, payment)
    if !client.nil?
      if payment.state == 'created'
        payment.execute(payer_id: payer_id)
        if payment.state == 'approved'
          net = order_row.paid - payment.transactions[0].related_resources[0].sale.transaction_fee.value.to_f
          transaction_id = payment.transactions[0].related_resources[0].sale.id if PayPal::SDK::Core::Config.configure.mode == 'live'
          order_row.update(verified: true, net: net, transaction_id: transaction_id, client_id: client.id)
          redirect_to "#{APP_CONFIG['host']}/#{order_row.class.to_s.underscore.gsub('_', '-')}/#{order_row.id}"
        else
          redirect_to "#{APP_CONFIG['host']}/#{order_row.class.to_s.underscore.gsub('_', '-')}/-2"
        end
      else
        redirect_to "#{APP_CONFIG['host']}/#{order_row.class.to_s.underscore.gsub('_', '-')}/-1"
      end
    end

  end

  def cancel
    redirect_to "#{APP_CONFIG['host']}/#{OrderRow.to_s.underscore.gsub('_', '-')}/-3"
  end

  def get_price
    service_id = params[:service_id]
    amount = params[:amounts].split(',').map(&:to_i).sum
    @price = Price.calculate_order_price(amount, service_id)
  end

  def get_status
    order_code = params[:order_code]
    order_row = OrderRow.find_by(order_code: order_code)
    @service_family = order_row.try(:service).try(:service_family)
    @service_description = order_row.try(:service).try(:description)
    @order_details = order_row.try(:order_details)
    unless @order_details.nil?
      render action: '/order_details/index', status: :ok
    else
      render action: '/get_status/error', status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order_row
    @order_row = OrderRow.find(params[:id])
  end
end
