require 'test_helper'

class SummerCampsControllerTest < ActionController::TestCase
  setup do
    @summer_camp = summer_camps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:summer_camps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create summer_camp" do
    assert_difference('SummerCamp.count') do
      post :create, summer_camp: { end_date: @summer_camp.end_date, price: @summer_camp.price, start_date: @summer_camp.start_date }
    end

    assert_redirected_to summer_camp_path(assigns(:summer_camp))
  end

  test "should show summer_camp" do
    get :show, id: @summer_camp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @summer_camp
    assert_response :success
  end

  test "should update summer_camp" do
    patch :update, id: @summer_camp, summer_camp: { end_date: @summer_camp.end_date, price: @summer_camp.price, start_date: @summer_camp.start_date }
    assert_redirected_to summer_camp_path(assigns(:summer_camp))
  end

  test "should destroy summer_camp" do
    assert_difference('SummerCamp.count', -1) do
      delete :destroy, id: @summer_camp
    end

    assert_redirected_to summer_camps_path
  end
end
