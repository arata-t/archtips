require 'rails_helper'

RSpec.describe "投稿する", type: :system do
  before do
    @tip =  FactoryBot.create(:tip)
    @user = FactoryBot.create(:user)
  end



  context '投稿に成功した時' do
=begin 
    it 'テキストの投稿に成功すること' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[type="submit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content('新規投稿')
      visit new_tip_path
      fill_in 'tip_title', with: @tip.title
      select '仕上げ', from: 'tip_category_id'
      fill_in 'tip_description', with: @tip.description
      binding.pry
      expect{
        find('input[type="submit"]').click
      }.to change {Tip.count }.by(1)
      expect(current_path).to eq(root_path)
    end
=end

  end

=begin 

  context '投稿に失敗した時' do
    it '送る値が空の為、メッセージの送信に失敗すること' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[type="submit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content('新規投稿')
      visit new_tip_path
      expect {
        find('input[type="submit"]').click
      }.not_to change { Tip.count }
    end
  end
end

=end