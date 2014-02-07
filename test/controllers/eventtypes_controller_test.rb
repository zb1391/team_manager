require 'test_helper'

class EventtypesControllerTest < ActionController::TestCase
  setup do
    @eventtype = eventtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eventtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eventtype" do
    assert_difference('Eventtype.count') do
      post :create, eventtype: { name: @eventtype.name }
    end

    assert_redirected_to eventtype_path(assigns(:eventtype))
  end

  test "should show eventtype" do
    get :show, id: @eventtype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eventtype
    assert_response :success
  end

  test "should update eventtype" do
    patch :update, id: @eventtype, eventtype: { name: @eventtype.name }
    assert_redirected_to eventtype_path(assigns(:eventtype))
  end

  test "should destroy eventtype" do
    assert_difference('Eventtype.count', -1) do
      delete :destroy, id: @eventtype
    end

    assert_redirected_to eventtypes_path
  end
end
