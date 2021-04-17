require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user[:id] = @user.id + 1
    @tip = FactoryBot.create(:tip)
  end
  context 'マイページにアクセスする' do
    it 'ログインした状態でマイページアクセスするとニックネーム、自己紹介、投稿数、投稿一覧が表示される。' do
      #ログイン
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[type="submit"]').click
      #マイページ
      visit user_path(@user[:id])
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
      #マイページ
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
