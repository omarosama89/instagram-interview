class Api::Mob::ReviewsController < Api::ApiApplicationControllerController

  def create
    @review = Review.new(review_params)

    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def review_params
    params.require(:review).permit(:message, :rate, :client_id)
  end

end
