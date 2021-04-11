class TipsController < ApplicationController
  def index
    @tips = Tip.order(updated_at: :DESC)
  end

  def new
    @tip = Tip.new
  end

  def create
    @tip = Tip.new(tip_params)
    if @tip.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @tip = Tip.find(params[:id])
  end

  def edit
    @tip = Tip.find(params[:id])
  end

  def update
    @tip = Tip.find(params[:id])
    if @tip.update(tip_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def tip_params
    params.require(:tip).permit(:title, :category_id, :description, :image).merge(user_id: current_user.id)
  end
end
