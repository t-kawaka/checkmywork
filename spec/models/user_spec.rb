require 'rails_helper'

RSpec.describe User, type: :model do

  it "userが空ならバリデーションが通りfalseになる" do
    user = User.new(user: nil, email: "test1@gmail.com", password: "foobar")
    expect(user).not_to be_valid
  end

  it "同じemailが２つ以上ならバリデーションが通りfalseになる" do
    User.create(user: "user01", email: "user01@gmail.com", password: "password")
    user = User.new(user: "user02", email: "user01@gmail.com", password: "password")
    expect(user).not_to be_valid
  end

  it "passwordが空ならバリデーションが通りfalseになる" do
    user = User.new(user: "test1", email: "test1@gmail.com", password: nil)
    expect(user).not_to be_valid
  end

  it "userとemailとpasswordを入力するとバリデーションが通りtrueになる" do
    user = User.new(user: "test1", email: "test1@gmail.com", password: "foobar")
    expect(user).to be_valid
  end

end
