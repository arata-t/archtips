class TipsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_tip, only: [:show, :edit, :update, :destroy]
  before_action :user_redirect, only: [:edit, :update, :destroy]
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
    @comment = Comment.new
    @comments = @tip.comments.includes(:user)
  end

  def edit
  end

  def update
    if @tip.update(tip_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @tip.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def search
    @tips = Tip.search(params[:keyword])
  end

  private

  def tip_params
    params.require(:tip).permit(:title, :category_id, :description, :image).merge(user_id: current_user.id)
  end

  def set_tip
    @tip = Tip.find(params[:id])
  end

  def user_redirect
    redirect_to action: :index unless current_user.id == @tip.user.id
  end
end
