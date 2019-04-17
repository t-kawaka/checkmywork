require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task, id: 1, name:"test_task_01")
    FactoryBot.create(:task, id: 2, name:"test_task_02")
    FactoryBot.create(:task, id: 3, name:"test_task_03")
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    expect(Task.order(created_at: "DESC").map(&:id)).to eq [3,2,1]
  end
end
