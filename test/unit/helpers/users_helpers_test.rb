require 'test_helper'

class UsersHelperTest < ActiveSupport::TestCase
  fixtures :users

  # if a user exists, you cannot create the same user again
  def test_create_user_when_user_exists
    attrs = {"name", "student1"}
    expectedUser = users(:student1)
    session = session_for expectedUser
    user = UsersHelper.create_user attrs, session
    assert_not_nil user
    assert_equal expectedUser, user
  end

  #
  def test_create_user_when_user_exists
    attrs = {"name", "student"}
    currentUser = User.new
    currentUser.id= 2345
    session = {}
    session[:user]= currentUser
    user = UsersHelper.create_user attrs, session
    assert_not_nil user
  end

  def test_store_item
    line = "dlm=;\n"
    config = {}
    UsersHelper.store_item(line, "dlm", config)
    assert_equal ";", config["dlm"]
  end

  #test define attributes methods
  def test_define_attributes
    config = {}
    config["dlm"]=";"
    config["name"]= 0
    config["fullname"]= "student_fullname"
    config["email"] = 1
    lines = ["student", "student@gmail.com"]
    attributes = UsersHelper.define_attributes lines, config

    assert_equal "student",  attributes["name"]
    assert_equal "student_fullname",  attributes["fullname"]
    assert_equal "student@gmail.com",  attributes["email"]
    assert_equal 1, attributes["email_on_submission"]
    assert_equal 1, attributes["email_on_review"]
    assert_equal 1, attributes["email_on_review_of_review"]
    assert_equal Role.find_by_name("Student"),attributes["role_id"]
  end
end