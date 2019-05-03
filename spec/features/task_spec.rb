require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    user = User.new(user: "user1", email: 'user1@gmail.com', password: 'foobar', password_confirmation: 'foobar', admin: true)

    FactoryBot.create(:task, name:"test_task_01", deadline: DateTime.now + 1, priority: "高", user: user)
    FactoryBot.create(:task, name:"test_task_02", deadline: DateTime.now + 3, situation: "着手中", user: user)
    FactoryBot.create(:second_task, name:"test_task_03", deadline: DateTime.now + 2, user: user)

    visit login_path
    fill_in 'メールアドレス', with:'user1@gmail.com'
    fill_in 'パスワード', with: 'foobar'
    click_button 'ログインする'
  end

  context '各タスクの動作確認テスト' do
    scenario "タスク一覧のテスト" do
      visit tasks_path
      expect(page).to have_content 'test_task_01'
      expect(page).to have_content 'test_task_02'
    end

    scenario "タスク作成のテスト" do
      visit new_task_path

      fill_in 'task_name', with:'test_task_04'
      fill_in 'task_detail', with: 'testtesttest04'
      fill_in 'task_deadline', with: DateTime.now + 2
      select '着手中', from: 'task[situation]'
      select '高', from: 'task[priority]'
      click_button '保存'
      expect(page).to have_content 'testtesttest04'
    end

    scenario "タスクの詳細のテスト" do
      visit tasks_path
      click_link '詳細', match: :first
      expect(page).to have_content 'test_task_03'
    end

    scenario "タスク編集のテスト" do
      visit tasks_path
      click_link '編集', match: :first

      fill_in 'task_name', with: '編集のテスト'
      click_button '保存'

      expect(page).to have_content 'タスク「編集のテスト」を更新しました'
    end

    scenario "タスク削除のテスト" do
      visit tasks_path
      click_link '削除', match: :first

      expect(page).to have_content 'タスク「test_task_03」を削除しました'
    end

    scenario "タスクが作成日時の降順に並んでいるかのテスト" do
      visit tasks_path
      expect(first("tbody tr")).to have_content 'test_task_03'
    end

    scenario "タスクが終了期限に並ぶかのテスト" do
      visit tasks_path
      click_link "終了期限でソートする"
      expect(first("tbody tr")).to have_content 'test_task_02'
    end

    scenario "タスクが優先順位通りに並ぶかのテスト" do
      visit tasks_path
      click_link "優先順位を高い順にソートする"
      expect(first("tbody tr")).to have_content 'test_task_01'
    end
  end  

  context '入力検索の絞り込みテスト' do
    scenario "タスク名の入力検索でタスク名が表示するかの絞り込みテスト" do
      visit tasks_path
      fill_in 'name', with:'test_task_03'
      click_button '検索する'
      expect(page).to have_content 'samplesample'
    end

    scenario "ステータスの入力検索でステータスが表示するかの絞り込みテスト" do
      visit tasks_path
      fill_in 'name', with:''
      select '未着手', from: 'situation'
      expect(page).to have_content 'testtesttest'
    end

    scenario "タイトルとステータスで検索してタスクが正常に並ぶかのテスト" do
      visit tasks_path
      fill_in 'name', with: 'test_task_02'
      select '着手中', from: 'situation'
      click_button '検索する'
      expect(page).to have_content 'testtesttest'
    end
  end
end
