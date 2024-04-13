class Api::Mob::NotificationsController < Api::ApiApplicationControllerController
  def index
    @notifications = Notification.All
  end

  def show
    id = params[:id]
    @notification = Notification.find_by(id: id)
  end
end
