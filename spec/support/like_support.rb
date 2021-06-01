module LikeSupport
  def like(tip)
    # ログイン
    sign_in(tip.user)
    # 新規投稿
    post(tip)
    expect(page).to have_css "div.like-index", text: '0'
    # 詳細
    click_on tip.title, match: :first
    # いいね
    expect(page).to have_css "div.like-show", text: '0'
    find('.far').click
    expect(page).to have_css "div.like-show", text: '1'
  end
end
