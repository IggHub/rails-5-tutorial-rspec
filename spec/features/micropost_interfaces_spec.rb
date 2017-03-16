require 'rails_helper'

RSpec.feature "MicropostInterfaces", type: :feature do
  let(:user) {FactoryGirl.create(:user)}

  it "tests micropost interface" do
    login user
    visit root_path
    fill_in "micropost_content", with: ""
    click_button "Post"
    expect(page).to have_content("The form contains 1 error")
    content = "Lorem Ipsum Iggy Dimsum"
    fill_in "micropost_content", with: content
    click_button "Post"
    expect(page).to have_content("Micropost created!")
    click_link "delete", match: :first
    expect(page).to have_content("Micropost deleted")
    expect(current_path).to eq root_path
  end
end
