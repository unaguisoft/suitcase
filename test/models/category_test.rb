require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @samsonite = categories(:samsonite)
  end

  test "should hava a name" do
    @samsonite.name = nil
    @samsonite.valid?

    assert_includes @samsonite.errors[:name], "can't be blank"
  end

  test "should have dimensions" do
    @samsonite.dimensions = nil
    @samsonite.valid?

    assert_includes @samsonite.errors[:dimensions], "can't be blank"
  end

  test "should have weight" do
    @samsonite.weight = nil
    @samsonite.valid?

    assert_includes @samsonite.errors[:weight], "can't be blank"
  end

  test "should have stock" do
    @samsonite.stock = nil
    @samsonite.valid?

    assert_includes @samsonite.errors[:stock], "can't be blank"
  end

  test "should have insurance_percent" do
    @samsonite.insurance_percent = nil
    @samsonite.valid?

    assert_includes @samsonite.errors[:insurance_percent], "can't be blank"
  end

end
