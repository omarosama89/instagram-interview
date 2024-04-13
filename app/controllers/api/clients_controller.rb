class Api::ClientsController < Api::ApiApplicationControllerController
  def index
    username = params[:username]
    @client = InstagramFetcherV3.get_user_hash(username)
    if @client[:code] == '0'
      render action: '/index', status: :ok
    else
      render action: '/error', status: :unprocessable_entity
    end
  end

  def check_username
    username = params[:username]
    @client = InstagramFetcherV3.get_user_hash(username)
    if @client[:code] == '0'
      render action: '/success', status: :ok
    else
      render action: '/error', status: :unprocessable_entity
    end
  end

  def set_locale
    @locale = params[:locale]
    I18n.locale = @locale.to_sym
  end
end
