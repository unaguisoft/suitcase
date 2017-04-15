require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @ross = users(:ross)
  end

  test "should not be valid without email" do
    @ross.email = nil
    @ross.valid?

    assert_includes @ross.errors[:email], "can't be blank"
  end

  test "should not be valid without name" do
    @ross.name = nil
    @ross.valid?

    assert_includes @ross.errors[:name], "can't be blank"
  end

  test "should not be valid without role or with invalid role" do
    @ross.role = nil
    @ross.valid?
    assert_includes @ross.errors[:role], "is not included in the list" 
  end

  test "should set role to normal when creating a user" do
    romeo = User.new
    assert_equal 'normal', romeo.role
  end
end

