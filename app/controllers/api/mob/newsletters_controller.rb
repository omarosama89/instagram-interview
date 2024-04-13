class Api::Mob::NewslettersController < Api::ApiApplicationControllerController

  def create
    @newsletter = Newsletter.new(newsletter_params)

    respond_to do |format|
      if @newsletter.save
        format.html {redirect_to @newsletter, notice: 'Newsletter was successfully created.'}
        format.json {render :show, status: :created, location: @newsletter}
      else
        format.html {render :new}
        format.json {render json: @newsletter.errors, status: :unprocessable_entity}
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def newsletter_params
    params.require(:newsletter).permit(:email)
  end
end
