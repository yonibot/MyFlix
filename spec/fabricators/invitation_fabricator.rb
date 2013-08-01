# == Schema Information
#
# Table name: invitations
#
#  id              :integer          not null, primary key
#  inviter_id      :integer
#  recipient_name  :string(255)
#  recipient_email :string(255)
#  message         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  token           :string(255)
#

Fabricator(:invitation) do
  recipient_name { Faker::Name.name }
  recipient_email { Faker::Internet.email }
  message { Faker::Lorem.paragraphs(2) }
end
