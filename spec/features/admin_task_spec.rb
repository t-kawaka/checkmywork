require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    user1 = User.new(user: "user1", email: 'user1@gmail.com', password: 'foobar', password_confirmation: 'foobar', admin: true)
    user2 = User.new(user: "user2", email: 'user2@gmail.com', password: 'foobar', password_confirmation: 'foobar', admin: false)
    FactoryBot.create(:task, name:"test_task_01", deadline: DateTime.now + 1, priority: "高", user: user1)
    FactoryBot.create(:task, name:"test_task_02", deadline: DateTime.now + 3, situation: "着手中", user: user1)
    FactoryBot.create(:second_task, name:"test_task_03", deadline: DateTime.now + 2, user: user1)

    FactoryBot.create(:task, name:"sample_task_01", deadline: DateTime.now + 1, priority: "高", user: user2)
    FactoryBot.create(:task, name:"sample_task_02", deadline: DateTime.now + 3, situation: "着手中", user: user2)

    visit login_path
    fill_in 'メールアドレス', with:'user1@gmail.com'
    fill_in 'パスワード', with: 'foobar'
    click_button 'ログインする'
  end

  context '管理者の動作確認テスト' do
    scenario "ユーザー一覧のテスト" do
      visit tasks_path
      visit admin_users_path
      expect(page).to have_content 'user1@gmail.com'
      expect(page).to have_content 'user2@gmail.com'
    end

    scenario "ユーザーの詳細テスト" do
      visit admin_users_path
      click_link 'user2', match: :first
      expect(page).to have_content 'user2'
      expect(page).to have_content 'user2@gmail.com'
    end

    scenario "ユーザーの編集テスト" do
      visit admin_users_path
      click_link '編集', match: :first
      fill_in 'user_user', with: 'user3'
      fill_in 'user_email', with: 'user3@gmail.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button '登録する'

      expect(page).to have_content 'ユーザー「user3」を更新しました'
      expect(page).to have_content 'user3'
      expect(page).to have_content 'user3@gmail.com'

    end

    scenario "ユーザーの削除テスト" do
      visit admin_users_path
      click_link '削除', match: :first
      expect(current_path).to eq admin_users_path
      expect(page).to_not have_content 'user2@gmail.com'
      expect(page).to have_content "ユーザー「user2」を削除しました"
    end
  end
end
