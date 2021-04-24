module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    fill_in 'user_email', with: @tip.user.email
    fill_in 'user_password', with: @tip.user.password
    find('input[type="submit"]').click
    expect(current_path).to eq(root_path)
  end
end