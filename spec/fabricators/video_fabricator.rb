# == Schema Information
#
# Table name: videos
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  description     :string(255)
#  large_cover_url :string(255)
#  small_cover_url :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :integer
#  user_id         :integer
#

Fabricator(:video) do
  title { Faker::Lorem.words(5) }
  description { Faker::Lorem.paragraph(2) }
end
