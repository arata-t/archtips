class UsersController < ApplicationController
  def show
    @user = current_user.nickname
    @tip = current_user.tips
  end
end
