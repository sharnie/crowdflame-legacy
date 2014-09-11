require 'rails_helper'

describe Category do

  context 'Validations' do
    it { should validate_presence_of   :name }
    it { should validate_uniqueness_of :name }
  end

  context 'CRUD' do
    it 'Create' do
      expect{ create(:category) }.to change(Category, :count).by(1)
    end

    it 'Read' do
      category = create(:category)
      expect(Category.find(category).name).to eq(category.name)
    end

    it 'Update' do
      category = create(:category)
      category.name = "new name"
      category.save
      expect(category.name).to eq("new name")
    end

    it 'Destroy' do
      # category = Category.last
      # expect{ category.delete }.to change(Category, :count).by(-1)
    end
  end

end