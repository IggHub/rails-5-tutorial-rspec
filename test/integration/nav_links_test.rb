require 'test_helper'

class NavLinksTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "home page link works as logged in users" do
    log_in_as @user
    get root_path
    assert_select "a[href=?]", root_path
    assert_template "static_pages/home"
  end

  test "about page link works as logged in users" do
    log_in_as @user
    get help_path
    assert_select "h1", "Help"
    assert_template "static_pages/help"
  end

  test "home page link works as non-logged in users" do
    get root_path
    assert_select "a[href=?]", root_path
    assert_template "static_pages/home"
  end

  test "about page link works as non-logged in users" do
    get help_path
    assert_select "h1", "Help"
    assert_template "static_pages/help"
  end

  test "Users page link works for logged in users" do
    log_in_as @user
    get users_path
    assert_template "users/index"
  end

  test "Users page link redirects for non-logged in users" do
    get users_path
    follow_redirect!
    assert_template "sessions/new"
  end
end
