require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, user: { name: " ",
                               email: "user@invalid",
                               password: "1234",
                               password_confirmation: "123" }
    end
    assert_template "users/new"
    assert_select "div#<CSS id for error explaination>"
    assert_select "div.<CSS class for field with error>"
  end

  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post_via_redirect users_path, user: { name: "Example user",
                                            email: "user@example.com",
                                            password: "123456",
                                            password_confirmation: "123456" }
    end
    assert_template "users/show"
    assert is_logged_in?
    assert_not flash[:warning]
  end
end
