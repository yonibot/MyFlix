# == Schema Information
#
# Table name: queue_items
#
#  id         :integer          not null, primary key
#  video_id   :integer
#  user_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:queue_item) do

end
