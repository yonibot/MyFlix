# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  leader_id   :integer
#  follower_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :leader, class_name: "User"
end
