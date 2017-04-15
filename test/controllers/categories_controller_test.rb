require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = categories(:samsonite)
    sign_in_as(users(:ross))
    @new_category_data = {
      name: 'New Category',
      dimensions: '10x10x10',
      weight: 120,
      insurance_percent: 12.3,
      stock: 99
    }
  end

  test "should get index" do
    get categories_path
    assert_response :success
    assert_not_nil assigns(:categories)
    assert_equal Category.count, assigns(:categories).send(:count)
  end

  test "should get new category" do
    get new_category_path
    assert_response :success
    assert_not_nil assigns(:category)
  end

  test "should get edit" do
    get edit_category_path(@category), params: {id: @category}
    assert_response :success
    assert_equal @category.name, assigns(:category).send(:name)
  end

  test "should update category" do
    assert_record_differences(@category, @new_category_data) do
      put category_path(@category), params: { id: @category.id, category: @new_category_data}
    end

    assert_redirected_to categories_path
  end

  test "should create category" do
    assert_difference('Category.count', 1) do
      post categories_path, params: { category: @new_category_data }
    end

    category = Category.unscoped.last
    assert_redirected_to upload_category_photos_category_path(category)
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete category_path(@category), params: { id: @category.id }
    end

    assert_redirected_to categories_path
  end

end
