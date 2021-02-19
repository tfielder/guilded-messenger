require 'rails_helper'

describe Message, type: :model do
  describe 'validations' do
    it { should validate_presence_of :subject}
    it { should validate_presence_of :body}
    it { should validate_presence_of :sender_id}
    it { should validate_presence_of :receiver_id}
  end
end