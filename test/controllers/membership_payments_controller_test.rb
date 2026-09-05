require "test_helper"

class MembershipPaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get membership_payments_new_url
    assert_response :success
  end

  test "should get create" do
    get membership_payments_create_url
    assert_response :success
  end
end
