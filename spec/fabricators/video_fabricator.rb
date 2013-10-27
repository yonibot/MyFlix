# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  large_cover :string(255)
#  small_cover :string(255)
#  video_url   :string(255)
#

Fabricator(:video) do
  title { Faker::Lorem.words(5) }
  description { Faker::Lorem.paragraph(2) }
end
