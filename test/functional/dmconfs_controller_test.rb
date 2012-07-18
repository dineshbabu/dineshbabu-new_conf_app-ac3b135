require 'test_helper'

class DmconfsControllerTest < ActionController::TestCase
  setup do
    @dmconf = dmconfs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dmconfs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dmconf" do
    assert_difference('Dmconf.count') do
      post :create, dmconf: @dmconf.attributes
    end

    assert_redirected_to dmconf_path(assigns(:dmconf))
  end

  test "should show dmconf" do
    get :show, id: @dmconf
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dmconf
    assert_response :success
  end

  test "should update dmconf" do
    put :update, id: @dmconf, dmconf: @dmconf.attributes
    assert_redirected_to dmconf_path(assigns(:dmconf))
  end

  test "should destroy dmconf" do
    assert_difference('Dmconf.count', -1) do
      delete :destroy, id: @dmconf
    end

    assert_redirected_to dmconfs_path
  end
end
