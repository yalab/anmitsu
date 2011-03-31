require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = Factory(:item)
    @user = @item.user
    @user.confirm!
    sign_in @user
  end
  context "on GET index" do
    context "no params" do
      setup do
        get :index
      end
      should "success" do
        assert_response :success
      end
      should "fetch objects" do
        assert_not_nil assigns(:items)
      end
    end

    context "search title" do
      context "existed" do
        setup do
          get :index, :item => {:title => @item.title[0..1] }
        end
        should "fetch objects" do
          assert assigns(:items).length > 0
        end
      end
      context "not existed" do
        setup do
          get :index, :item => {:title => @item.title[0..1] + "@"}
        end
        should "fetch nothing" do
          assert_equal 0, assigns(:items).length
        end
      end
    end

    context "appoint state" do
      context "existed" do
        setup do
          get :index, :item => {:state => @item.state}
        end
        should "fetch objects" do
          assert assigns(:items).length > 0
        end
      end
      context "not existed" do
        setup do
          not_existed_state = Item.machine.states.keys.select{|state| state.to_s != @item.state }.sample
          get :index, :item => {:state => not_existed_state }
        end
        should "fetch nothing" do
          assert_equal 0, assigns(:items).length
        end
      end
    end
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @item.to_param
    assert_response :success
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
        assert_equal 'Failed to create', flash[:alert]
      end
    end
  end

  context "on GET :show" do
    context "existed item " do
      setup do
        get :show, :id => @item.to_param
      end
      should "success" do
        assert_response :success
      end
    end

    context "new create item" do
      setup do
        item = @user.items.create(:title => 'new item')
        get :show, :id => item.to_param
      end
      should "success" do
        assert_response :success
      end
    end

    context "new users's item" do
      setup do
        pass = 'password'
        user = User.create(:email => Faker::Internet.email, :password => pass, :password_confirmation => pass)
        user.confirm!
        sign_in(user)
        item = user.items.create(:title => 'hogehoge')
        get :show, :id => item.to_param, :format => :pdf
      end
      should "success" do
        assert_response :success
      end
    end
  end

  context "on PUT :update" do
    context "owner" do
      should "update item" do
        put :update, :id => @item.to_param, :item => @item.attributes
        assert_redirected_to item_path(assigns(:item))
        assert_equal 'Item was successfully updated', flash[:notice]
      end
      context "database is abnormal" do
        setup do
          Item.any_instance.stubs(:update_attributes).returns(false)
          put :update, :id => @item.to_param, :item => @item.attributes
        end
        should "error message in flash" do
          assert_equal 'Failed to update', flash[:alert]
        end
      end
    end
    context "not a owner" do
      setup do
        pass = 'password'
        new_user = User.create(:email => Faker::Internet.email, :password => pass, :password_confirmation => pass)
        new_user.confirm!
        @new_item = new_user.items.create(:title => 'foobar')
      end
      should "ignore update" do
        assert_raise(Mongoid::Errors::DocumentNotFound){
          put :update, :id => @new_item.to_param, :item => @item.attributes
        }
      end
    end
  end
end
