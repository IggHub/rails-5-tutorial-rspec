require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  it "should GET new session" do
    get :new
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end

end
