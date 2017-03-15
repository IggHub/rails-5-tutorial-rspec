require 'rails_helper'

RSpec.feature "PasswordResets", type: :feature do
  let(:user) {FactoryGirl.create(:user)}

  before(:each) {user.reset_token = User.new_token}

  it "tests password reset" do
    ActionMailer::Base.deliveries.clear
    visit new_password_reset_path
    expect(page).to have_content("Password Reset")
    fill_in "password_reset_email", with: user.email
    click_button "Submit"
    expect(ActionMailer::Base.deliveries.size).to eq 1
    expect(current_path).to eq root_path

    visit edit_password_reset_path(user.reset_token, email: "")
    expect(current_path).to eq root_path

    user.toggle!(:activated)
    visit edit_password_reset_path(user.reset_token, email: user.email)
    expect(current_path).to eq root_path
    user.toggle!(:activated)

    visit edit_password_reset_path('wrong token, man!', email: user.email)
    expect(current_path).to eq root_path

    visit edit_password_reset_path(user.reset_token, email: user.email)
    expect(current_path).to eq root_path

  end

end
