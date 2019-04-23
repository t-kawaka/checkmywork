require 'rails_helper'

RSpec.describe Task, type: :model do

  it "titleが空ならバリデーションが通らない" do
    task = Task.new(name: '', detail: '失敗テスト', deadline: DateTime.now + 1, situation: "未着手")
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    task = Task.new(name: "失敗テスト", detail: "", deadline: DateTime.now + 1, situation: "着手中")
    expect(task).not_to be_valid
  end

  it "deadlineが空ならバリデーションが通らない" do
    task = Task.new(name: "失敗テスト", detail: "失敗テスト", deadline: nil, situation: "完了")
    expect(task).not_to be_valid
  end

  it "titleとcontentとdeadlineに内容が記載されていればバリデーションが通る" do
    task = Task.new(name:"成功テスト", detail: "成功テスト", deadline: DateTime.now + 1, situation: "未着手")
    expect(task).to be_valid
  end
end
