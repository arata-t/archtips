class TipsController < ApplicationController
  def index
    @tips = Tip.order('created_at DESC')
  end

  def new
    @tip = Tip.new
  end

  def create
    @tip = Tip.create(tip_params)
    if @tip.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def tip_params
    params.require(:tip).permit(:title, :category_id, :description, :image).merge(user_id: current_user.id)
  end
end
