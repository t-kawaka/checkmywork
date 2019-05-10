if Rails.env == "development"
  (1..20).each do |i|
    name = Faker::Games::Pokemon.name
    email = Faker::Internet.email
    password = "foobar"
    User.create!(user: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 )
  end

  1.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "foobar"
  User.create!(user: name,
               email: email,
               admin: true,
               password: password,
               password_confirmation: password,
               )
end

  1.times do |n|
  Label.create!(title: "資料作成")
  Label.create!(title: "会議")
  Label.create!(title: "プレゼン")
  Label.create!(title: "打ち合わせ")
  end
end
