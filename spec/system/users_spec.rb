require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:tip) {FactoryBot.create(:tip)}
  let!(:tag) {FactoryBot.create(:tag)}

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
    it '送る値が空のため新規登録に失敗すること' do
      visit new_user_registration_path
      find('input[type="submit"]').click
      expect(current_path).to eq(user_registration_path)
    end
  end

  context 'ログインする' do
    it 'ログインを成功させること' do
      sign_in(tip.user)
    end
    it '値が空のためログインに失敗すること' do
      visit new_user_session_path
      fill_in 'user_email', with: tip.user.email
      fill_in 'user_password', with: tip.user.password
      find('input[type="submit"]').click
      expect(current_path).to eq(root_path)
    end
  end

  context 'マイページにアクセスする' do
    it '投稿後にマイページアクセスすると投稿した内容が表示される。' do
      # ログイン
      sign_in(tip.user)
      # 新規投稿
      post(tip)
      # マイページ
      click_on('マイページ')
      mypage(tip)
    end
    it 'トップページの投稿者を選択すると投稿者のマイページに移動し、投稿者のニックネーム、自己紹介、投稿数、投稿一覧が表示される。' do
      visit root_path
      # マイページ
      click_on tip.user.nickname, match: :first
      mypage(tip)
    end
    it '詳細ページの投稿者を選択すると投稿者のマイページに移動し、投稿者のニックネーム、自己紹介、投稿数、投稿一覧が表示される。' do
      visit tip_path(tip.id)
      # マイページ
      click_on tip.user.nickname
      mypage(tip)
    end
  end

  context 'ユーザーを編集する' do
    it 'ユーザーの編集を行うとトップページの名前が修正されている' do
      # ログイン
      sign_in(tip.user)
      # マイページ
      click_on tip.user.nickname, match: :first
      # ユーザー編集
      find('.btn-edit-str').click
      fill_in 'user_nickname', with: '-c'
      fill_in 'user_introduction', with: '-c'
      find('input[type="submit"]').click
      expect(page).to have_css ".user-button", text: '-c'
    end
    it 'ユーザー編集を行うとマイページの内容が修正されている' do
      # ログイン
      sign_in(tip.user)
      # マイページ
      click_on tip.user.nickname, match: :first
      # ユーザー編集
      find('.btn-edit-str').click
      fill_in 'user_nickname', with: '-c'
      fill_in 'user_introduction', with: '-c'
      find('input[type="submit"]').click
      expect(page).to have_css ".user-button", text: '-c'
      # マイページ編集
      find('#my-page-btn').click
      expect(page).to have_css ".plofile-name", text: '-c'
      expect(page).to have_css ".plofile-introduction", text: '-c'
    end
  end

  context '退会する' do
    it '退会に成功し、退会したユーザーに付随した投稿も削除される' do
      # ログイン
      sign_in(tip.user)
      # マイページ
      click_on tip.user.nickname, match: :first
      # 退会
      find('.btn-delete-str').click
      expect(page.driver.browser.switch_to.alert.text).to eq "本当に退会しますか？"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_css ".new-user-button", text: 'ユーザー登録'
      expect(page).not_to have_content tip.title
      expect(page).not_to have_content tip.tags
      expect(page).not_to have_content tip.category
    end
  end
end
