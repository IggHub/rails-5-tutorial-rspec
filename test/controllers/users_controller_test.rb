require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @michael = users(:michael)
    @iggy = users(:iggy)
  end

  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "h1", "Sign Up"
  end

  test "should redirect when not logged in as the right user" do
    log_in_as(@iggy)
    get edit_user_path(@michael)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
    log_in_as(@iggy)
    patch user_path(@michael), params: {user: {name: @michael.name, email: @michael.email}}
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect from index if not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@iggy)
    assert_not @iggy.admin?
    patch user_path(@iggy), params: {
                                    user: { password:              'password',
                                            password_confirmation: 'password',
                                            admin: true } }
    assert_not @iggy.admin?
  end

  test "non admin user should be redirected to login_url when trying to delete user and not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@michael)
    end
    assert_redirected_to login_url
  end

  test "logged-in, non admin user should be redirected to root_url when trying to delete user" do
    log_in_as(@iggy)
    assert_no_difference 'User.count' do
      delete user_path(@michael)
    end
    assert_redirected_to root_url
  end

  test "should redirect following when not logged in" do
    get following_user_path(@michael)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@michael)
    assert_redirected_to login_url
  end
end
