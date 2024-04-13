class CommentsController < InheritedResources::Base

  private

  def comment_params
    params.require(:comment).permit(:text, :order_detail_id)
  end
end

