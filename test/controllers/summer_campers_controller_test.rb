require 'test_helper'

class SummerCampersControllerTest < ActionController::TestCase
  setup do
    @summer_camper = summer_campers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:summer_campers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create summer_camper" do
    assert_difference('SummerCamper.count') do
      post :create, summer_camper: { address: @summer_camper.address, cell_phone: @summer_camper.cell_phone, city: @summer_camper.city, email: @summer_camper.email, first_name: @summer_camper.first_name, gender: @summer_camper.gender, grade: @summer_camper.grade, home_phone: @summer_camper.home_phone, last_name: @summer_camper.last_name, state: @summer_camper.state, waiver_date: @summer_camper.waiver_date, waiver_name: @summer_camper.waiver_name, zip: @summer_camper.zip }
    end

    assert_redirected_to summer_camper_path(assigns(:summer_camper))
  end

  test "should show summer_camper" do
    get :show, id: @summer_camper
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @summer_camper
    assert_response :success
  end

  test "should update summer_camper" do
    patch :update, id: @summer_camper, summer_camper: { address: @summer_camper.address, cell_phone: @summer_camper.cell_phone, city: @summer_camper.city, email: @summer_camper.email, first_name: @summer_camper.first_name, gender: @summer_camper.gender, grade: @summer_camper.grade, home_phone: @summer_camper.home_phone, last_name: @summer_camper.last_name, state: @summer_camper.state, waiver_date: @summer_camper.waiver_date, waiver_name: @summer_camper.waiver_name, zip: @summer_camper.zip }
    assert_redirected_to summer_camper_path(assigns(:summer_camper))
  end

  test "should destroy summer_camper" do
    assert_difference('SummerCamper.count', -1) do
      delete :destroy, id: @summer_camper
    end

    assert_redirected_to summer_campers_path
  end
end
