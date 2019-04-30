require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    user = User.new(user: "user1", email: 'user1@gmail.com', password: 'foobar', password_confirmation: 'foobar')
    FactoryBot.create(:task, name:"test_task_01", deadline: DateTime.now + 1, priority: "高", user: user)
    # FactoryBot.create(:task, name:"test_task_02", deadline: DateTime.now + 3, situation: "着手中")
    # FactoryBot.create(:second_task, name:"test_task_03", deadline: DateTime.now + 2)
  end

    scenario "ユーザー「user1」がログインしているとき" do
      visit login_path
      fill_in 'メールアドレス', with:'user1@gmail.com'
      fill_in 'パスワード', with: 'foobar'
      click_button 'ログインする'
      expect(page).to have_content 'ログインに成功しました'
    end

  # scenario "タスク一覧のテスト" do
  #   visit tasks_path
  #   expect(page).to have_content 'testtest'
  #   expect(page).to have_content 'samplesample'
  # end
  #
  # scenario "タスク作成のテスト" do
  #   visit new_task_path
  #
  #   fill_in 'task_name', with:'test_task_04'
  #   fill_in 'task_detail', with: 'testtesttest04'
  #   fill_in 'task_deadline', with: DateTime.now + 2
  #   select '着手中', from: 'task[situation]'
  #   select '高', from: 'task[priority]'
  #   click_button '保存'
  #   expect(page).to have_content 'testtesttest04'
  # end
  #
  # scenario "タスクの詳細のテスト" do
  #   @task =Task.create!(name: 'test_task_05', detail: 'testtesttest05', deadline: DateTime.now + 2, situation: "着手中", priority: "中")
  #   visit task_path(@task)
  #   expect(page).to have_content 'testtesttest05'
  # end
  #
  # scenario "タスクが作成日時の降順に並んでいるかのテスト" do
  #   visit tasks_path
  #   expect(first("tbody tr")).to have_content 'test_task_03'
  # end
  #
  # scenario "タスクが終了期限に並ぶかのテスト" do
  #   visit tasks_path
  #   click_link "終了期限でソートする"
  #   expect(first("tbody tr")).to have_content 'test_task_02'
  # end
  #
  # context '入力検索の絞り込みテスト' do
  #   scenario "タスク名の入力検索でタスク名が表示するかの絞り込みテスト" do
  #     visit tasks_path
  #     fill_in 'name', with:'test_task_03'
  #     click_button '検索する'
  #     expect(page).to have_content 'samplesample'
  #   end
  #
  #   scenario "ステータスの入力検索でステータスが表示するかの絞り込みテスト" do
  #     visit tasks_path
  #     fill_in 'name', with:''
  #     select '未着手', from: 'situation'
  #     expect(page).to have_content 'testtesttest'
  #   end
  #
  #   scenario "タイトルとステータスで検索してタスクが正常に並ぶかのテスト" do
  #     visit tasks_path
  #     fill_in 'name', with: 'test_task_02'
  #     select '着手中', from: 'situation'
  #     click_button '検索する'
  #     expect(page).to have_content 'testtesttest'
  #   end
  # end
  #
  # scenario "タスクが優先順位通りに並ぶかのテスト" do
  #   visit tasks_path
  #   click_link "優先順位を高い順にソートする"
  #   expect(first("tbody tr")).to have_content 'test_task_01'
  # end
  #
  # scenario "ページネーションのテスト" do
  #   (1..50).each do |i|
  #     Task.create(name: "タスク名#{i}", detail: "コンテンツ#{i}",  deadline: "2019-04-29 15:00:00", situation: "未着手",  priority: "低")
  #   end
  #   visit tasks_path
  #   expect(page).to have_content '最後'
  # end
end
