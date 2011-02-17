require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    (@user = Factory(:user)).confirm!
    sign_in @user
    @item = @user.items.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show item" do
    get :show, :id => @item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @item.to_param
    assert_response :success
  end

  test "should update item" do
    put :update, :id => @item.to_param, :item => @item.attributes
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, :id => @item.to_param
    end

    assert_redirected_to items_path
  end

  context "on POST :create" do
    context "valid case" do
      should "create item" do
        assert_difference('Item.count') do
          post :create, :item => {:title => 'title'}
        end

        assert_redirected_to item_path(assigns(:item))
        assert_equal @user.id, assigns(:item).user_id
        assert_equal 'Item was successfully created', flash[:notice]
      end
    end
    context "invalid case" do
      setup do
        Item.any_instance.stubs(:save).returns(false)
        post :create, :item => {:title => 'title'}
      end
      should "redirect index"do
        assert_redirected_to items_path
      end
      should "display alert message" do
        assert_equal 'Failed to delete', flash[:alert]
      end
    end
  end
end
