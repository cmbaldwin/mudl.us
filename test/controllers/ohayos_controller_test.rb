require 'test_helper'

class OhayosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ohayo = ohayos(:one)
  end

  test "should get index" do
    get ohayos_url
    assert_response :success
  end

  test "should get new" do
    get new_ohayo_url
    assert_response :success
  end

  test "should create ohayo" do
    assert_difference('Ohayo.count') do
      post ohayos_url, params: { ohayo: {  } }
    end

    assert_redirected_to ohayo_url(Ohayo.last)
  end

  test "should show ohayo" do
    get ohayo_url(@ohayo)
    assert_response :success
  end

  test "should get edit" do
    get edit_ohayo_url(@ohayo)
    assert_response :success
  end

  test "should update ohayo" do
    patch ohayo_url(@ohayo), params: { ohayo: {  } }
    assert_redirected_to ohayo_url(@ohayo)
  end

  test "should destroy ohayo" do
    assert_difference('Ohayo.count', -1) do
      delete ohayo_url(@ohayo)
    end

    assert_redirected_to ohayos_url
  end
end
