require 'rails_helper'

feature "User Profile" do
  let(:user) { create(:user) }

  context "Profile" do
    scenario "Show Profile" do
      user = create(:user)
      login_as(user, :scope => :user)
      visit user_profile_path(attributes_for(:user)[:username])

      expect(page).to have_content(attributes_for(:user)[:username])
    end
  end
end