require 'rails_helper'

RSpec.feature "UserProfiles", type: :feature do

  let(:user) {FactoryGirl.create(:user)}

  it "displays profile" do
    visit user_path(user)
    expect(current_path).to eq("/users/#{user.id}")
    expect(page).to have_content user.name
  end
end
