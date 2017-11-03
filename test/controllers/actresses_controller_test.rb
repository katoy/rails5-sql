require 'test_helper'

class ActressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @actress = actresses(:one)
  end

  test "should get index" do
    get actresses_url, as: :json
    assert_response :success
  end

  test "should create actress" do
    assert_difference('Actress.count') do
      post actresses_url, params: { actress: { name: @actress.name } }, as: :json
    end

    assert_response 201
  end

  test "should show actress" do
    get actress_url(@actress), as: :json
    assert_response :success
  end

  test "should update actress" do
    patch actress_url(@actress), params: { actress: { name: @actress.name } }, as: :json
    assert_response 200
  end

  test "should destroy actress" do
    assert_difference('Actress.count', -1) do
      delete actress_url(@actress), as: :json
    end

    assert_response 204
  end
end
