require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:tip)      {FactoryBot.create(:tip)}
  let(:comment) {FactoryBot.create(:comment)}

  it 'コメントが投稿できること' do
    # ログイン
    sign_in(tip.user)
    # 詳細
    click_on tip.title
    # コメント
    comment
  end
  it 'コメントが投稿できたらマイページのコメント数が変更していること' do
    # ログイン
    sign_in(tip.user)
    # 詳細
    click_on tip.title
    # コメント
    comment
    # マイページ
    visit user_path(tip.user.id)
    expect(page).to have_content(tip.user.comments.length)
  end
end
