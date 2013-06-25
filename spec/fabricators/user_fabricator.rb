# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  full_name       :string(255)
#  password        :string(255)
#  password_digest :string(255)
#  email           :string(255)
#

Fabricator(:user) do
  address = Faker::Internet.email
  email { address }
  email_confirmation { address }
  password 'password'
  full_name { Faker::Name.name }
end
