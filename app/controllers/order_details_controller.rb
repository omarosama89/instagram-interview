class OrderDetailsController < InheritedResources::Base

  private

  def order_detail_params
    params.require(:order_detail).permit(:link, :amount, :api_order_id, :status, :order_row_id)
  end
end

