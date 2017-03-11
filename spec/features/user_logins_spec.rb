require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  it 'user logs in with invalid information' do
    visit login_path
    fill_in 'session_email', with: ''
    fill_in 'session_password', with: ''
    click_button "Log in"
    expect(current_path).to eq login_path
  end

  it 'user logs in with valid information followed by log out' do
    user = FactoryGirl.create(:user)
    visit login_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_button "Log in"
    expect(current_path).to eq '/users/1'
    expect(page).to have_content('Log out')
    click_link "Log out"
    expect(current_path).to eq '/'
    expect(page).to have_content "Log in!"
  end
end
