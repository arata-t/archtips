class TipsController < ApplicationController
  def index
    @tips = Tip.all
  end

  def new
    @tip = Tip.new
  end

  def create
    @tip = Tip.create(tip_params)
  end
  

  private
  def tip_params
    params.require(:tip).permit(:title, :category_id, :description)
  end
end
