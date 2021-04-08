require 'rails_helper'

RSpec.describe '投稿する', type: :system do
  before do
    @tip =  FactoryBot.create(:tip)
    @user = FactoryBot.create(:user)
  end

  context '投稿に成功した時' do
    it '投稿に成功すること' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[type="submit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content('新規投稿')
      visit new_tip_path
      fill_in 'tip_title', with: @tip.title
      select Category.data[@tip.category_id][:name], from: 'tip_category_id'
      fill_in 'tip_description', with: @tip.description
      expect  do
        find('input[type="submit"]').click
      end.to change { Tip.count }.by(1)
      expect(current_path).to eq(root_path)
      expect(page).to have_content(@tip.title)
      expect(page).to have_content(Category.data[@tip.category_id][:name])
      expect(page).to have_content(@tip.description)
    end

    it ' 画像を含めた投稿が成功すること ' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[type="submit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content('新規投稿')
      visit new_tip_path
      fill_in 'tip_title', with: @tip.title
      select Category.data[@tip.category_id][:name], from: 'tip_category_id'
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('tip-image-main-img', image_path, make_visible: true)
      fill_in 'tip_description', with: @tip.description
      expect  do
        find('input[type="submit"]').click
      end.to change { Tip.count }.by(1)
      expect(current_path).to eq root_path
      expect(page).to have_selector('img')
    end
  end

  context '投稿に失敗した時' do
    it '送る値が空の為、メッセージの送信に失敗すること' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[type="submit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content('新規投稿')
      visit new_tip_path
      expect do
        find('input[type="submit"]').click
      end.not_to change { Tip.count }
    end
  end
end
