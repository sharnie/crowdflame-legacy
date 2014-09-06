require 'rails_helper'

describe Socialconnection do
  context "Validations" do
    it { should validate_presence_of :user_id }

    it { should validate_presence_of   :uid }
    it { should validate_uniqueness_of :uid }

    it { should validate_presence_of :provider }
  end

  context "Association" do
    it { should belong_to :user }
  end

  context "CRUD" do
    it 'Create new social connection' do
      expect { create(:socialconnection) }.to change(Socialconnection, :count).by(1)
    end
  end
end