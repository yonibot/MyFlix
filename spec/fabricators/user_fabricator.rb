# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  full_name       :string(255)
#  password        :string(255)
#  password_digest :string(255)
#  email           :string(255)
#  token           :string(255)
#  admin           :boolean
#

Fabricator(:user) do
  email { Faker::Internet.email }
  password 'password'
  full_name { Faker::Name.name }
end
