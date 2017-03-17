require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user1) {FactoryGirl.create(:user)}
  let(:user2) {FactoryGirl.create(:user2)}
  let(:relationship) {Relationship.new(follower_id: user1.id, followed_id: user2.id)}

  it "should be valid" do
    expect(relationship).to be_valid
  end

  it "should require follower_id" do
    relationship.follower_id = nil
    expect(relationship).to_not be_valid
  end

  it "should require followed_id" do
    relationship.followed_id = nil
    expect(relationship).to_not be_valid
  end
end
