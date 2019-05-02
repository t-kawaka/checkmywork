FactoryBot.define do
  factory :user do
    name { "user1" }
    email { "user1@gmail.com" }
    password { "foobar" }
    admin {true}
  end
  factory :user2 do
    name { "user2" }
    email { "user2@gmail.com" }
    password { "foobar" }
    admin {false}
  end

end
