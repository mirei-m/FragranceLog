module LoginMacros
  def login_as(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'ログイン'
  end

  def logout_from_dropdown
    # ドロップダウンメニューをクリックして開く
    find('.dropdown .btn-ghost').click
    # ログアウトリンクをクリック
    click_link 'ログアウト'
  end
end
