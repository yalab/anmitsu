require 'test_helper'

class BaseInfosControllerTest < ActionController::TestCase
  setup do
    @base_info = Factory(:base_info)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:base_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create base_info" do
    assert_difference('BaseInfo.count') do
      post :create, :base_info => @base_info.attributes.reject{|k, v| k == '_id'}
    end

    assert_redirected_to base_info_path(assigns(:base_info))
  end

  test "should show base_info" do
    get :show, :id => @base_info.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @base_info.to_param
    assert_response :success
  end

  test "should update base_info" do
    put :update, :id => @base_info.to_param, :base_info => @base_info.attributes
    assert_redirected_to base_info_path(assigns(:base_info))
  end

  test "should destroy base_info" do
    assert_difference('BaseInfo.count', -1) do
      delete :destroy, :id => @base_info.to_param
    end

    assert_redirected_to base_infos_path
  end
end
