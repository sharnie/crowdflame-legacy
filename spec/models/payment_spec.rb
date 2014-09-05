require 'rails_helper'

RSpec.describe Payment, :type => :model do

  let(:payment) { create(:payment) }

  it 'should create payment record' do
    expect(Payment.find(payment)).to eq(payment)
  end

  context 'Payment validations' do
    it { should validate_presence_of(:email) }
  end

  context 'Payment User association' do
    it { should belong_to(:user) }
  end

end
