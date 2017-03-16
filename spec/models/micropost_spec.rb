require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:micropost) {FactoryGirl.create(:micropost)}
  it "should be valid" do
    expect(micropost).to be_valid
  end

  it "should not be valid if no user_id" do
    micropost.user_id = nil
    expect(micropost).to_not be_valid
  end

  it "content must be present" do
    micropost.content = " "
    expect(micropost).to_not be_valid
  end

  it "content must not exceed 140 characters" do
    micropost.content = "a" * 141
    expect(micropost).to_not be_valid
  end
end
