require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do

  describe 'ユーザー新規登録' do
    describe '正常系' do
      context 'フォームの入力値が正常' do
        it 'ユーザー登録成功' do
          visit new_user_registration_path

          fill_in 'user_name', with: 'テストユーザー'
          fill_in 'user_email', with: 'test@example.com'
          fill_in 'user_password', with: 'password123'
          fill_in 'user_password_confirmation', with: 'password123'

          click_button "アカウント登録"

          expect(page).to have_content('アカウント登録が完了しました')
          expect(current_path).to eq root_path
        end
      end
    end

    describe '異常系' do
      context 'ユーザー名が未入力' do
        it 'ユーザー登録失敗' do
          visit new_user_registration_path

          fill_in 'user_name', with: ''
          fill_in 'user_email', with: 'test@example.com'
          fill_in 'user_password', with: 'password123'
          fill_in 'user_password_confirmation', with: 'password123'

          click_button "アカウント登録"

          expect(page).to have_content("アカウント名を入力してください")
          expect(current_path).to eq new_user_registration_path
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザー登録失敗' do
          visit new_user_registration_path

          fill_in 'user_name', with: 'テストユーザー'
          fill_in 'user_email', with: ''
          fill_in 'user_password', with: 'password123'
          fill_in 'user_password_confirmation', with: 'password123'

          click_button "アカウント登録"

          expect(page).to have_content("Eメールを入力してください")
          expect(current_path).to eq new_user_registration_path
        end
      end

      context '登録済みのメールアドレスを入力' do
        it 'ユーザー登録失敗' do
          existed_user = create(:user)

          visit new_user_registration_path

          fill_in 'user_name', with: 'テストユーザー'
          fill_in 'user_email', with: existed_user.email
          fill_in 'user_password', with: 'password123'
          fill_in 'user_password_confirmation', with: 'password123'

          click_button "アカウント登録"

          expect(page).to have_content('Eメールはすでに存在します')
          expect(current_path).to eq new_user_registration_path
        end
      end

      context 'パスワードが未入力' do
        it 'ユーザー登録失敗' do
          visit new_user_registration_path

          fill_in 'user_name', with: 'テストユーザー'
          fill_in 'user_email', with: 'test@example.com'
          fill_in 'user_password', with: ''
          fill_in 'user_password_confirmation', with: ''

          click_button "アカウント登録"

          expect(page).to have_content("パスワードを入力してください")
          expect(current_path).to eq new_user_registration_path
        end
      end

      context 'パスワードが短すぎる場合(5文字以下)' do
        it 'ユーザー登録失敗' do
          visit new_user_registration_path

          fill_in 'user_name', with: 'テストユーザー'
          fill_in 'user_email', with: 'test@example.com'
          fill_in 'user_password', with: '12345'
          fill_in 'user_password_confirmation', with: '12345'

          click_button "アカウント登録"

          expect(page).to have_content('パスワードは6文字以上で入力してください')
          expect(current_path).to eq new_user_registration_path
        end
      end

      context 'パスワード確認が一致しない場合' do
        it 'ユーザー登録失敗' do
          visit new_user_registration_path

          fill_in 'user_name', with: 'テストユーザー'
          fill_in 'user_email', with: 'test@example.com'
          fill_in 'user_password', with: 'password123'
          fill_in 'user_password_confirmation', with: 'different_password'

          click_button "アカウント登録"

          expect(page).to have_content("パスワード（確認用）とパスワードの入力が一致しません")
          expect(current_path).to eq new_user_registration_path
        end
      end
    end
  end
end