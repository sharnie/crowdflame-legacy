require "rails_helper"

feature "User Pages" do
  let(:user_form) do
    within("#new_user") do
      fill_in "user_email",    with: "sharnieivery@gmail.com"
      fill_in "user_password", with: "qwertyui"
    end
  end

  scenario "Register" do
    visit new_user_registration_url
    user_form
    click_button "Sign Up"
    expect(page).to have_text("Welcome! You have signed up successfully.")
  end

  scenario "Sign In" do
    create(:user)
    visit new_user_session_url
    user_form
    click_button "Log In" 
    expect(page).to have_text("Signed in successfully.")
  end
end