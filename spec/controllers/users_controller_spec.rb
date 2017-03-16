require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it "GET new" do
    get :new
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end


  context "user microposts" do
    let(:user) {FactoryGirl.create(:user)}

    it "should destroy associated microposts" do
      expect{
        micropost = user.microposts.create!(content: "Lorem user ipsum")
        delete :destroy, params: {id: micropost.id}
      }.to change(Micropost, :count).by(1)
    end
  end
end
