require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task, name:"test_task_01", deadline: DateTime.now + 1)
    FactoryBot.create(:task, name:"test_task_02", deadline: DateTime.now + 3)
    FactoryBot.create(:second_task, name:"test_task_03", deadline: DateTime.now + 2)
  end

  scenario "タスク一覧のテスト" do
    visit tasks_path
    expect(page).to have_content 'testtest'
    expect(page).to have_content 'samplesample'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path

    fill_in 'task_name', with:'test_task_04'
    fill_in 'task_detail', with: 'testtesttest04'
    fill_in 'task_deadline', with: DateTime.now + 2
    click_button '登録する'
    expect(page).to have_content 'testtesttest04'
  end

  scenario "タスクの詳細のテスト" do
    @task =Task.create!(name: 'test_task_05', detail: 'testtesttest05', deadline: DateTime.now + 2)
    visit task_path(@task)
    expect(page).to have_content 'testtesttest05'
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
end
