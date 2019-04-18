require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task, name:"test_task_01")
    FactoryBot.create(:task, name:"test_task_02")
    FactoryBot.create(:second_task, name:"test_task_03")
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    expect(first('tr')).to have_content 'samplesample'
  end
end
