class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tips = User.find(params[:id]).tips.order(updated_at: :DESC)
    num = 0
    @tips.each do |tip|
      num += tip.comments.length
    end
    @commented_num = num
  end
end
