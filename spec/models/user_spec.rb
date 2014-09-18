require 'rails_helper'

describe User do
  let(:user)  { create(:user) }

  context 'Registration' do
    it { expect(user).to be_valid }
    
    it 'should create new users' do
      expect { create(:user) }.to change(User, :count).by(1)
    end
  end

  context 'Validations' do
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of   :password }
  end

  context "Association" do
    it { should have_many :socialconnections }
    it { should have_many :offers }
    it { should have_one  :payment }
  end

  context 'User payment info' do
    let(:payment) { create(:payment) }

    it 'should have payment info' do
      user.payment = payment
      expect(user.payment).to eq(payment)
    end
  end
end