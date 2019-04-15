require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  scenario "タスク一覧のテスト" do
    Task.create!(name: 'test_task_01', detail: 'testtesttest')
    Task.create!(name: 'test_task_02', detail: 'samplesample')
    visit tasks_path
    expect(page).to have_content('testtesttest')
    expect(page).to have_content('samplesample')
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'task_name', with:'test_task_01'
    fill_in 'task_detail', with: 'testtesttest'
    click_button '登録する'
    expect(page).to have_content('testtesttest')
  end

  scenario "タスク詳細のテスト" do
    Task.create!(name: 'test_task_01', detail: 'testtesttest')
    visit '/tasks/4'
    expect(page).to have_content('testtesttest')
  end
end
