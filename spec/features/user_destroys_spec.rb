require 'rails_helper'

RSpec.feature "UserDestroys", type: :feature do
  context "only admin can destroy user" do
    let(:user) {FactoryGirl.create(:user)}
    let(:admin) {FactoryGirl.create(:user2)}

    it "does not allow average user to destroy" do
      login user
      visit '/users'
      expect(page).to_not have_content('delete')
    end

    it "allows admin to destroy" do
      login admin
      visit '/users'
      expect(page).to have_content('delete')
      click_link 'delete', match: :first
      expect(page).to have_content('User deleted')
    end
  end
end
