class OrderRowsController < InheritedResources::Base

  private

  def order_row_params
    params.require(:order_row).permit(:order_code, :verified, :service_id, :client_id)
  end
end

