require 'rails_helper'

describe User do
  let(:user)  { create(:user) }

  context 'Registration' do
    it 'should create new user' do
      expect(User.find(user)).to_not be_nil
    end
  end
end