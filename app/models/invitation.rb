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


class Invitation < ActiveRecord::Base

  include Tokenable

  belongs_to :inviter, class_name: "User"

  validates_presence_of :recipient_name, :recipient_email, :message


end
