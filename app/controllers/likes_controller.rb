class LikesController < ApplicationController
  def create
    @like = Like.create(user_id: current_user.id, tip_id: params[:tip_id])
    @tip = Tip.find_by(id: params[:tip_id])
  end

  def destroy
    @like = Like.find_by(tip_id: params[:tip_id], user_id: current_user.id)
    @tip = Tip.find_by(id: params[:tip_id])
    @like.destroy
  end
end
