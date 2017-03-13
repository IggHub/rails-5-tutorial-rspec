require 'rails_helper'

RSpec.feature "UserEdits", type: :feature do
  context "logged_in" do
    let (:user) {FactoryGirl.create(:user)}
    let (:user2) {FactoryGirl.create(:user2)}

    it "logs in successfully" do
      login user
    end

    it "unsuccessful edit for non logged-in user" do
      visit edit_user_path(user2)
      expect(page).to have_content("Please log in")
      expect(current_path).to eq login_path
    end

    it "successful edit for logged-in user" do
      login user
      visit edit_user_path(user)
      expect(current_path).to eq edit_user_path(user)
      name = "iggy"
      fill_in "user_name", with: name
      click_button "Submit Changes"
      user.reload
      expect(user.name).to eq name
    end

    it "redirects edit when logged in as wrong user" do
      login user2
      visit edit_user_path(user)
      expect(current_path).to eq root_path
    end
  end
end
