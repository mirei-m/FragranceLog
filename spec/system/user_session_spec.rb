require 'rails_helper'

RSpec.describe 'ユーザーセッション', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン' do
    describe '正常系' do
      context 'フォームの入力値が正常' do
        it 'ログイン処理が成功する' do
          visit new_user_session_path

          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: user.password

          click_button 'ログイン'

          expect(page).to have_content('ログインしました')
          expect(current_path).to eq reviews_path
        end
      end
    end

    describe '異常系' do
      context 'メールアドレスが未入力' do
        it 'ログイン失敗' do
          visit new_user_session_path

          fill_in 'user_email', with: ''
          fill_in 'user_password', with: 'password123'

          click_button 'ログイン'

          expect(page).to have_content('Eメールまたはパスワードが違います')
          expect(current_path).to eq new_user_session_path
        end
      end

      context 'パスワードが未入力' do
        it 'ログイン失敗' do
          visit new_user_session_path

          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: ''

          click_button 'ログイン'

          expect(page).to have_content('Eメールまたはパスワードが違います')
          expect(current_path).to eq new_user_session_path
        end
      end

      context '存在しないメールアドレスを入力' do
        it 'ログイン失敗' do
          visit new_user_session_path

          fill_in 'user_email', with: 'nonexistent@example.com'
          fill_in 'user_password', with: 'password123'

          click_button 'ログイン'

          expect(page).to have_content('Eメールまたはパスワードが違います')
          expect(current_path).to eq new_user_session_path
        end
      end

      context '間違ったパスワードを入力' do
        it 'ログイン失敗' do
          visit new_user_session_path

          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: 'wrong_password'

          click_button 'ログイン'

          expect(page).to have_content('Eメールまたはパスワードが違います')
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe 'ログアウト' do
    #login_macrosに書いたログイン処理を先に行う
    before { login_as(user) }

    context 'ドロップダウンメニューからログアウト' do
      it 'ログアウトされる' do
        logout_from_dropdown

        expect(page).to have_content('ログアウトしました')
        expect(current_path).to eq root_path
        expect(page).to have_link('ログイン')
      end
    end
  end
end