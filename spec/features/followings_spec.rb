require 'rails_helper'

RSpec.feature "Followings", type: :feature do
  let(:user1) {FactoryGirl.build(:user)}
  let(:user2) {FactoryGirl.build(:user2)}

  context "test redirect" do
    it "redirects following when not logged in" do
      visit following_user_path(user2)
      expect(current_path).to eq login_path
    end

    it "redirects followers when not logged in" do
      visit followers_user_path(user2)
      expect(current_path).to eq login_path
    end
  end

  context "following and unfollowing" do
    it "follows a page" do
      login user1
      visit following_user_path(user1)
    end

    it "displays followers page" do
      login user1
      visit followers_user_path(user1)
    end
  end
end
