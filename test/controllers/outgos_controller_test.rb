require "test_helper"

class OutgosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get outgos_new_url
    assert_response :success
  end

  test "should get index" do
    get outgos_index_url
    assert_response :success
  end

  test "should get edit" do
    get outgos_edit_url
    assert_response :success
  end
end
