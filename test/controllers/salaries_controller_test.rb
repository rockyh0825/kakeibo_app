require "test_helper"

class SalariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get salaries_index_url
    assert_response :success
  end

  test "should get edit" do
    get salaries_edit_url
    assert_response :success
  end

  test "should get show" do
    get salaries_show_url
    assert_response :success
  end
end
