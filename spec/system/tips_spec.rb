require 'rails_helper'

RSpec.describe '投稿する', type: :system do
  before do
    @tip = FactoryBot.create(:tip)
  end
  context '投稿に失敗した時' do
    it '送る値が空の為、メッセージの送信に失敗すること' do
      # ログイン
      sign_in(@tip.user)
      # 新規投稿
      expect(page).to have_content('新規投稿')
      click_on '新規投稿'
      expect do
        find('input[type="submit"]').click
      end.not_to change { Tip.count }
    end
  end
  context '投稿に成功した時' do
    it '投稿に成功し、トップページに投稿したタイトル、カテゴリー、説明が表示されていること' do
      # ログイン
      sign_in(@tip.user)
      # 新規投稿
      click_on '新規投稿'
      fill_in 'tip_title', with: @tip.title
      select Category.data[@tip.category_id - 1][:name], from: 'tip_category_id'
      fill_in 'tip_description', with: @tip.description
      expect  do
        find('input[type="submit"]').click
      end.to change { Tip.count }.by(1)
      expect(current_path).to eq(root_path)
      expect(page).to have_content(@tip.title)
      expect(page).to have_content(Category.data[@tip.category_id - 1][:name])
      expect(page).to have_content(@tip.description)
    end
    it ' 画像を含めた投稿が成功し、トップページに投稿した画像が表示されていること ' do
      # ログイン
      sign_in(@tip.user)
      # 新規投稿
      post(@tip)
    end
  end
end

RSpec.describe '詳細', type: :system do
  before do
    @tip = FactoryBot.create(:tip)
  end
  context '詳細ページに移動できる' do
    it '画像を含めた投稿が成功したら、投稿したタイトル。カテゴリー・説明・画像が詳細ページに表示されること' do
      # ログイン
      sign_in(@tip.user)
      # 新規投稿
      post(@tip)
      # 詳細
      click_on @tip.title, match: :first
      show(@tip)
    end
  end
  it 'ログインしていない状態で詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    visit tip_path(@tip)
    show(@tip)
    expect(page).not_to have_selector 'form'
    expect(page).to have_content 'コメントの投稿には新規登録/ログインが必要です'
  end
end

RSpec.describe '編集する', type: :system do
  before do
    @tip = FactoryBot.create(:tip)
  end
  context '編集に成功した時' do
    it '画像を含めた投稿が成功したら投稿が編集できる' do
      # ログイン
      sign_in(@tip.user)
      # 投稿
      post(@tip)
      # 詳細
      click_on @tip.title, match: :first
      # 編集
      click_on '編集'
      @tip[:id] = @tip.id + 1
      expect(current_path).to eq edit_tip_path(@tip)
      other_tip = FactoryBot.build(:tip)
      fill_in 'tip_title', with: other_tip.title
      select Category.data[other_tip.category_id - 1][:name], from: 'tip_category_id'
      after_image_path = Rails.root.join('public/images/after_image.png')
      attach_file 'tip-image-main-img', after_image_path, make_visible: true
      fill_in 'tip_description', with: other_tip.description
      expect  do
        find('input[type="submit"]').click
      end.to change { Tip.count }.by(0)
      expect(current_path).to eq root_path
      expect(page).to have_content(other_tip.title)
      expect(page).to have_content(Category.data[other_tip.category_id - 1][:name])
      expect(page).to have_content(other_tip.description)
      expect(page).to have_selector('img')
    end
  end
  context '編集に失敗した時' do
    it '自分以外の投稿は編集できない' do
      @tip2 = FactoryBot.create(:tip)
      # ログイン
      sign_in(@tip.user)
      # 詳細
      click_on @tip2.title
      expect(page).not_to have_content('編集')
    end
    it 'ログインしていないと編集できない' do
      visit root_path
      # 詳細
      click_on @tip.title
      expect(page).not_to have_content('編集')
    end
    it '自分以外の投稿編集ページに直接アクセスするとトップページにリダイレクトされる' do
      @tip2 = FactoryBot.create(:tip)
      # ログイン
      sign_in(@tip.user)
      # 詳細
      visit edit_tip_path(@tip2)
      expect(current_path).to eq root_path
    end
    it 'ログインせずに投稿編集ページに直接アクセスするとトップページにリダイレクトされる' do
      visit root_path
      # 詳細
      visit edit_tip_path(@tip)
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '削除する', type: :system do
  before do
    @tip = FactoryBot.create(:tip)
  end
  context '削除に成功する' do
    it '投稿をを正しく削除できる' do
      # ログイン
      sign_in(@tip.user)
      # 投稿
      other_tip = FactoryBot.build(:tip)
      post(other_tip)
      # 詳細
      click_on other_tip.title
      # 削除
      click_on '削除'
      expect(current_path).to eq root_path
      expect(page).not_to have_content(other_tip.title)
    end
  end
  context '削除に失敗する' do
    it '自分以外の投稿は削除できない' do
      @tip2 = FactoryBot.create(:tip)
      # ログイン
      sign_in(@tip.user)
      # 詳細
      click_on @tip2.title
      expect(page).not_to have_content('削除')
    end
    it 'ログインしていないと編集できない' do
      visit root_path
      # 詳細
      click_on @tip.title
      expect(page).not_to have_content('削除')
    end
  end
end

RSpec.describe '検索する', type: :system do
  before do
    @tip = FactoryBot.create(:tip)
  end
  context '検索に成功する' do
    it '正しく検索を行うと投稿した内容がトップページに検索結果が表示される' do
      # ログイン
      sign_in(@tip.user)
      # 投稿
      other_tip = FactoryBot.build(:tip)
      post(other_tip)
    end
  end
  context '検索に失敗する' do
    it '検索結果がない場合は投稿はありませんと表示される' do
      # ログイン
      sign_in(@tip.user)
      # 投稿
      other_tip = FactoryBot.build(:tip)
      post(other_tip)
      # 検索
      fill_in 'keyword', with: other_tip.description + 'abc'
      click_on('検索')
      expect(page).to have_content('投稿はありません')
    end
  end
end
