require 'test_helper'

class UserFilterTest < ActiveSupport::TestCase

  def setup
    @ross   = users(:ross)
    @rachel = users(:rachel)
  end

  test "should filter by name" do
    users = UserFilter.new({term: 'ross'}).call
    assert_includes users, @ross
    assert_not_includes users, @rachel
    
    users = UserFilter.new({term: 'rachel'}).call
    assert_includes users, @rachel
    assert_not_includes users, @ross
  end
  
  test "should filter by email" do
    users = UserFilter.new({term: 'ross@geller.com'}).call
    assert_includes users, @ross
    assert_not_includes users, @rachel
    
    users = UserFilter.new({term: 'rachel@green.com'}).call
    assert_includes users, @rachel
    assert_not_includes users, @ross
  end
end