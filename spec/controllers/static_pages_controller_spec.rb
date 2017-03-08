require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views

  before :all do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  it "GET root" do
    expect(get: root_url).to route_to(
      controller: "static_pages",
      action: "home"
    )
  end

  it "GET home" do
    get :home
    expect(response).to be_success
    expect(response).to have_http_status(200)
    assert_select "title", "#{@base_title}"
  end

  it "GET help" do
    get :help
    expect(response).to be_success
    expect(response).to have_http_status(200)
    assert_select "title", "Help | #{@base_title}"
  end

  it "GET about" do
    get :about
    expect(response).to be_success
    expect(response).to have_http_status(200)
    assert_select "title", "About | #{@base_title}"
  end

  it "GET contact" do
    get :contact
    expect(response).to be_success
    expect(response).to have_http_status(200)
    assert_select "title", "Contact | #{@base_title}"
  end

  it "GET hey" do
    get :hey
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end
end
