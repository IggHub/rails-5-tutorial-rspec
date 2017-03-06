require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'iggy', email: 'iggy@email.com', password: 'password', password_confirmation: 'password')
  end

  test "user must be valid" do
    assert @user.valid?
  end

  test "user must not be valid" do
    @user.name = ' '
    assert_not @user.valid?
  end

  test "email must be present" do
    @user.email = ''
    assert_not @user.valid?
  end

  test "name cannot be over 50 characters" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email cannot be over 50 characters" do
    @user.email = "a" * 51 + @user.email
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                        first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{@user.email.inspect} should be valid"
    end
  end

  test "email validation should reject valid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                       foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{@user.email.inspect} should be valid"
    end
  end

  test "email addressess should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase()
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved downcase" do
    mixed_case_email = "rAnDom_CASe_Email@email.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present/ non-blank" do
    @user.password = @user.password_confirmation = ' '
    assert_not @user.valid?
  end

  test "password should have a minimum length of 5" do
    @user.password = @user.password_confirmation = 'a' * 4
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed when user is destroyed" do
    @user.save
    @user.microposts.create!(content: "Micro ipsum")
    assert_difference "Micropost.count", -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    michael = users(:michael)
    archer  = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end
end
