require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do
  context "user signs up" do
    it "signup page submission without user info" do
      visit signup_path
      expect do
        click_button "Create Account"
      end.to_not change{User.count}
      expect(current_path).to eq '/users'
      expect(page).to have_content('Log in')
    end

    it "signup page submission with valid user info" do
      user = FactoryGirl.build(:user)
      visit signup_path
      fill_in "user_name", with: user.name
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password_confirmation
      click_button "Create Account"
      expect(current_path).to eq root_path
    end

  end
end
