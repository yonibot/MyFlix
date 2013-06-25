# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  video_id   :integer
#  rating     :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:review) do
  rating { (1..5).to_a.sample } #comes out as random number from 1-5
  content { Faker::Lorem.paragraph(3) }
end
