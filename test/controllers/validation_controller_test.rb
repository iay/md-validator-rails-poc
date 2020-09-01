require 'test_helper'

class ValidationControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get validation_new_url
    assert_response :success
  end

  test "should get validate" do
    get validation_validate_url
    assert_response :success
  end

end
