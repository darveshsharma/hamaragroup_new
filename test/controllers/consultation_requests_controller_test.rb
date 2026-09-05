require "test_helper"

class ConsultationRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get consultation_requests_index_url
    assert_response :success
  end

  test "should get show" do
    get consultation_requests_show_url
    assert_response :success
  end

  test "should get new" do
    get consultation_requests_new_url
    assert_response :success
  end

  test "should get create" do
    get consultation_requests_create_url
    assert_response :success
  end

  test "should get update" do
    get consultation_requests_update_url
    assert_response :success
  end
end
