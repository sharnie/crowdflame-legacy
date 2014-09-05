require 'rails_helper'

describe User do
  let(:user)  { create(:user) }

  context 'Register new user' do
    it { expect(user).to be_valid }

    it 'should create new users' do
      expect { create(:user) }.to change(User, :count).by(1)
    end
  end

  context 'Validates user attributes' do
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of   :password }
    it { should validate_presence_of   :post_code }
  end

  context 'User payment info' do
    let(:payment) { create(:payment) }

    it 'should have payment info' do
      user.payment = payment
      expect(user.payment).to eq(payment)
    end
  end
end