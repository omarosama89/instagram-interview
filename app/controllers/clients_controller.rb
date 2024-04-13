class ClientsController < InheritedResources::Base

  private

  def client_params
    params.require(:client).permit(:email, :phone_number, :first_name, :last_name)
  end
end

