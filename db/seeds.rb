User.create! name: "Nguyen Quang Vinh",
  email: "vinhnq@railstutorial.org", password: "123456vinh",
  password_confirmation: "123456vinh", admin: true, activated: true,
  activated_at: Time.zone.now

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name:  name, email: email, password: password,
    password_confirmation: password, activated: true,
    activated_at: Time.zone.now
end
