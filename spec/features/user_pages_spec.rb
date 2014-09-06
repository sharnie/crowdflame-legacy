require "rails_helper"

feature "User Pages" do
  let(:user) { create(:user) }

  context "Registration" do
    scenario "Sign Up" do
      visit new_user_registration_url
      within "form" do
        fill_in "user_email",     with: "sharnieivery@gmail.com"
        fill_in "user_password",  with: "qwertyui"
        fill_in "user_post_code", with: "12345"
      end
      click_button "Sign Up"
      expect(page).to have_text("Welcome! You have signed up successfully.")
    end

    scenario "Edit Account" do
      visit new_user_session_url
      within "form" do
        fill_in "user_email",    with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log In"

      visit edit_user_registration_url
      within "form" do
        fill_in "user_first_name", with: user.first_name
        fill_in "user_last_name",  with: user.last_name
        fill_in "user_email",      with: user.email
        fill_in "user_post_code",  with: user.post_code
      end

      click_button "Save Changes"
      expect(page).to have_text("Your profile has been updated!")
      expect(User.find(user)).to eq(user)
    end
  end

  context "Sessions" do
    scenario "Sign In" do
      visit new_user_session_url
      within "form" do
        fill_in "user_email",    with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log In"
      expect(page).to have_text("Signed in successfully.")
    end
  end

  context "Passwords" do
    scenario "Forgot password" do
      visit new_user_password_url
      within "form" do
        fill_in "user_email", with: user.email
      end
      click_button "Send Password"
      expect(page).to have_text("You will receive an email with instructions on how to reset your password in a few minutes.")
    end
  end
end