require "rails_helper"

describe Offer do
  context "Validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :description }
    it { should validate_presence_of :delivery }
    it { should validate_presence_of :instructions }
    it { should validate_presence_of :socialconnection_id }

    it { should ensure_length_of(:title).is_at_least(8) }

    it { should validate_inclusion_of(:price).in_array([5]) }
    it { should_not allow_value(6).for(:price) }

    it { should belong_to :category }

    it 'should not create offer unless user have Social Connections' do
    end
  end

  context "Create" do
    before do
      @user             = create(:user)
      @socialconnection = @user.socialconnections.create(attributes_for(:socialconnection))
    end

    it "should create offer" do
      expect do
        offer             = @socialconnection.offers.create(attributes_for(:offer))
        offer.category_id = @socialconnection.category_id
        offer.save
      end.to change { Offer.count }.by(1)
    end
  end
end