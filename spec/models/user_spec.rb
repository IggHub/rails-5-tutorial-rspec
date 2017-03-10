require 'rails_helper'

RSpec.describe User, type: :model do
  context "valid user" do
    it "tests user is valid" do
      user = FactoryGirl.build(:user)
      expect(user).to be_valid
    end

    it "tests invalid for user with blank name" do
      user = FactoryGirl.build(:user, name: '')
      expect(user).to_not be_valid
    end

    it "tests invalid for user with blank email" do
      user = FactoryGirl.build(:user, email: '')
      expect(user).to_not be_valid
    end

    it "tests user has maximum length of name" do
      user = FactoryGirl.build(:user, name: 'a'*51)
      expect(user).to_not be_valid
    end

    it "tests user has maximum length of email" do
      user = FactoryGirl.build(:user, email: 'a'*244 + '@email.com')
      expect(user).to_not be_valid
    end

    it "tests email regex" do
      user = FactoryGirl.build(:user)
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                        foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to_not be_valid
      end
    end

    it "test email address uniqueness" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.build(:user, email: user.email.upcase)
      expect(user2).to_not be_valid
    end

    it "email should be saved with lowercase" do
      mixed_case_email = "mixEDCaseEmail@email.com"
      user = FactoryGirl.create(:user, email: mixed_case_email)
      expect(user.email).to eq(user.email.downcase)
    end
  end

  context "password testing" do
    it "should have present/ non-blank password" do
      user = FactoryGirl.build(:user)
      user.password = user.password_confirmation = ''
      expect(user).to_not be_valid
    end

    it "should have minimum length password" do
      user = FactoryGirl.build(:user)
      user.password = user.password_confirmation = "a" * 4
      expect(user).to_not be_valid
    end
  end
end
