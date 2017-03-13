require 'rails_helper'

RSpec.feature "UserIndices", type: :feature do
  context "viewing index" do
    let(:user) {FactoryGirl.create(:user)}

    it "index has pagination" do
      login user
      visit users_path
      expect(current_path).to eq '/users'
      expect(page).to have_content('Previous')
    end
  end
end
