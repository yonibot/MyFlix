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

require 'spec_helper'

describe Invitation do
  it { should validate_presence_of :recipient_name} 
  it { should validate_presence_of :recipient_email}
  it { should validate_presence_of :message }  

  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:invitation) }
  end
  
end
