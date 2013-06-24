Fabricator(:user) do
  address = Faker::Internet.email
  email { address }
  email_confirmation { address }
  password 'password'
  full_name { Faker::Name.name }
end