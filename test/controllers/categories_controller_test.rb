require 'test_helper'

class CategoriesControllerTest  <  ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "sports")
  end

  test "should get categories index" do
      get categories_path
    #  get "/categories/index"
      assert_response :success
  end

  test "should get new" do
    get new_category_path
  #  get "/categories/new"
    assert_response :success
  end

  test "should get show" do
    get category_path(@category)
  #  get "/categories/show"
    assert_response :success
  end

end
