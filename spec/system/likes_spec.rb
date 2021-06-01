require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @tip = FactoryBot.create(:tip)
    @tag = FactoryBot.create(:tag)
  end

  context 'いいいねができる' do
    it 'showページからいいいねを押すといいねが切り替わり数が１増えること', js: true do
      like(@tip)
    end

    it 'いいねボタンを押すとアイコンが変わり、いいねの数が増え、トップページのいいねしたものはアイコンが変わる', js: true do
      like(@tip)
      find('.logo-image').click
      expect(page).to have_css "div.like-index", text: '1'
    end

    it 'いいねされたボタンを押すとアイコンといいね数が元に戻る', js: true do
      like(@tip)
      find('.fas').click
      expect(page).to have_css ".like-show", text: '0'
    end

    it 'いいねを取り消すといいねの数が元に戻り、トップページも変更する', js: true do
      like(@tip)
      find('.logo-image').click
      expect(page).to have_css "div.like-index", text: '1'
      # 詳細2
      click_on @tip.title, match: :first
      # いいね2
      find('.fas').click
      expect(page).to have_css ".like-show", text: '0'
      find('.logo-image').click
      expect(page).to have_css "div.like-index", text: '0'
    end

    it 'いいねを押すとマイページのいいね数が増える', js: true do
      like(@tip)
      find('.logo-image').click
      # マイページ
      find('#my-page-btn').click
      expect(page).to have_css "div.plofile-status-contents", text: '1'
    end

    it 'いいねを取り消すとマイページのいいね数が減る', js: true do
      like(@tip)
      find('.logo-image').click
      # マイページ
      find('#my-page-btn').click
      expect(page).to have_css "div.plofile-status-contents", text: '1'
      find('.logo-image').click
      # 詳細2
      click_on @tip.title, match: :first
      # いいね2
      find('.fas').click
      expect(page).to have_css ".like-show", text: '0'
      find('.logo-image').click
      expect(page).to have_css "div.like-index", text: '0'
      find('.logo-image').click
      # マイページ2
      find('#my-page-btn').click
      expect(page).to have_css "div.plofile-status-contents", text: '0'
    end

    it 'マイページでいいね一覧を押すといいねした投稿一覧が表示される', js: true do
      like(@tip)
      find('.logo-image').click
      # マイページ
      find('#my-page-btn').click
      expect(page).to have_css "div.plofile-status-contents", text: '1'
      find('.like-appear-str').click
      expect(page).to have_content(@tip.title)
      expect(page).to have_content(Category.data[@tip.category_id - 1][:name])
      expect(page).to have_content(@tip.description)
      expect(page).to have_selector('img')
    end
  end

  context 'いいねができない' do
    it 'ログインしていないといいねボタンが押せない', js: true do
      # 詳細
      visit tip_path(@tip)
      expect do
        find('.far').click
      end.to change(Like, :count).by(0)
    end
  end
end
