require 'rails_helper'

RSpec.feature "layout test", type: :feature do
  context "not logged in" do
    it "requires login" do
      visit root_path
      expect(page).to have_link("Home", href: root_path, count: 1)
      expect(page).to have_link("Help", href: help_path)
      expect(page).to have_link("About", href: about_path)
      expect(page).to have_link("Contact", href: contact_path)
      visit contact_path
      expect(page).to have_content("Contact the Ruby on Rails")
    end
  end
end
