require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @tip = FactoryBot.create(:tip)
    @comment = FactoryBot.create(:comment)
  end

  it 'コメントが投稿できること' do
    #ログイン
    visit new_user_session_path
    fill_in 'user_email', with: @tip.user.email
    fill_in 'user_password', with: @tip.user.password
    find('input[type="submit"]').click
    expect(current_path).to eq(root_path)
    #詳細
    click_on @tip.title
    #コメント
    fill_in 'comment_comment', with: @comment.comment
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    expect(current_path).to eq tip_path(@tip)
    expect(page).to have_content @comment.user.nickname
    expect(page).to have_content @comment.comment
  end
  it 'コメントが投稿できたらマイページのコメント数が変更していること' do
    #ログイン
    visit new_user_session_path
    fill_in 'user_email', with: @tip.user.email
    fill_in 'user_password', with: @tip.user.password
    find('input[type="submit"]').click
    expect(current_path).to eq(root_path)
    #詳細
    click_on @tip.title
    #コメント
    fill_in 'comment_comment', with: @comment.comment
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    #マイページ
    visit user_path(@tip.user.id)
    expect(page).to have_content(@tip.user.comments.length)
  end
end
