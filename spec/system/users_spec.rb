require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user[:id] = @user.id + 1
    @tip = FactoryBot.create(:tip)
  end
  context '新規登録をする' do
    it '新規登録を成功させること' do
      other_user = FactoryBot.build(:user)
      visit new_user_registration_path
      fill_in 'user_nickname', with: other_user.nickname
      fill_in 'user_email', with: other_user.email
      fill_in 'user_password', with: other_user.password
      fill_in 'user_password_confirmation', with: other_user.password
      fill_in 'user_last_name', with: other_user.last_name
      fill_in 'user_first_name', with: other_user.first_name
      fill_in 'user_introduction', with: other_user.introduction
      find('input[type="submit"]').click
      expect(current_path).to eq root_path
      expect(page).to have_content 'マイページ'
      expect(page).to have_content 'ログアウト'
      expect(page).to have_content other_user.nickname
    end
    it '送る値が空のため新規投稿に失敗すること' do
      visit new_user_registration_path
      find('input[type="submit"]').click
      expect do
        find('input[type="submit"]').click
      end.not_to change { User.count }
    end
  end
  context 'ログインする' do
    it 'ログインを成功させること' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[type="submit"]').click
      expect(current_path).to eq(root_path)
    end
    it '値が空のためログインに失敗すること' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[type="submit"]').click
      expect(current_path).to eq(root_path)
    end
  end
  context 'マイページにアクセスする' do
    it '投稿後にマイページアクセスすると投稿した内容が表示される。' do
      # ログイン
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[type="submit"]').click
      # 投稿
      visit new_tip_path
      fill_in 'tip_title', with: @tip.title
      select Category.data[@tip.category_id - 1][:name], from: 'tip_category_id'
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file 'tip-image-main-img', image_path, make_visible: true
      fill_in 'tip_description', with: @tip.description
      expect  do
        find('input[type="submit"]').click
      end.to change { Tip.count }.by(1)
      # マイページ
      click_on('マイページ')
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content(@tip.description)
      expect(page).to have_content(@user.tips.length)
      expect(page).to have_content(@tip.title)
      expect(page).to have_content(Category.data[@tip.category_id - 1][:name])
      expect(page).to have_content(@tip.description)
      expect(page).to have_selector('img')
    end
    it 'トップページの投稿者を選択すると投稿者のマイページに移動し、投稿者のニックネーム、自己紹介、投稿数、投稿一覧が表示される。' do
      visit root_path
      click_on @user.nickname, match: :first
      # マイページ
      expect(current_path).to eq user_path(@user.id)
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content(@tip.description)
      expect(page).to have_content(@user.tips.length)
      expect(page).to have_content(@tip.title)
      expect(page).to have_content(Category.data[@tip.category_id - 1][:name])
      expect(page).to have_content(@tip.description)
      expect(page).to have_selector('img')
    end
    it '詳細ページの投稿者を選択すると投稿者のマイページに移動し、投稿者のニックネーム、自己紹介、投稿数、投稿一覧が表示される。' do
      visit tip_path(@tip.id)
      click_on @user.nickname
      # マイページ
      expect(current_path).to eq user_path(@user.id)
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content(@tip.description)
      expect(page).to have_content(@user.tips.length)
      expect(page).to have_content(@tip.title)
      expect(page).to have_content(Category.data[@tip.category_id - 1][:name])
      expect(page).to have_content(@tip.description)
      expect(page).to have_selector('img')
    end
  end
end
