require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  before do
    @tip = FactoryBot.create(:tip)
    @comment = FactoryBot.create(:comment)
  end

  it 'コメントが投稿できること' do
    # ログイン
    sign_in(@tip.user)
    # 詳細
    click_on @tip.title
    # コメント
    fill_in 'comment_comment', with: @comment.comment
    expect  do
      find('input[name="commit"]').click
    end.to change { Comment.count }.by(1)
    expect(current_path).to eq tip_path(@tip)
    expect(page).to have_content @comment.user.nickname
    expect(page).to have_content @comment.comment
  end
  it 'コメントが投稿できたらマイページのコメント数が変更していること' do
    # ログイン
    sign_in(@tip.user)
    # 詳細
    click_on @tip.title
    # コメント
    fill_in 'comment_comment', with: @comment.comment
    expect  do
      find('input[name="commit"]').click
    end.to change { Comment.count }.by(1)
    # マイページ
    visit user_path(@tip.user.id)
    expect(page).to have_content(@tip.user.comments.length)
  end
end
