class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/tip/#{comment.tip.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tip_id: params[:tip_id])
  end
end