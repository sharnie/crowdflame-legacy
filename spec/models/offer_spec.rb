require "rails_helper"

describe Offer do
  context "Validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :description }
    it { should validate_presence_of :delivery }
    it { should validate_presence_of :instructions }
    it { should validate_presence_of :user_id }

    it { should ensure_length_of(:title).is_at_least(10) }


    it { should validate_inclusion_of(:price).in_array([1,2,3,4,5]) }
    it { should_not allow_value(6).for(:price) }

    it { should belong_to :category }

    it 'should not create offer unless user have Social Connections' do
    end
  end
end