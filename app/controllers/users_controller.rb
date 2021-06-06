class UsersController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  before_action :set_user, only: [:show, :destroy]
  before_action :user_redirect, only: [:destroy]
  
  def show
    @tips = User.find(params[:id]).tips.order(updated_at: :DESC)
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to root_path
    else
      render:show
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_redirect
    redirect_to action: :index unless current_user.id == @user.id
  end

end
