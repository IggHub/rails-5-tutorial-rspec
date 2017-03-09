require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it "GET new" do
    get :new
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end
end
