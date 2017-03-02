require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "invalid user signup" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: '', email: 'user@invalid', password: 'foo', password_confirmation: 'bar'}}
    end
    assert_template 'users/new'
  end

  test "valid user signup" do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: {user: {name: 'testuser', email: 'testuser@email.com', password: 'foobar', password_confirmation: 'foobar'}}
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
