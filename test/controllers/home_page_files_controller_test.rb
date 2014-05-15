require 'test_helper'

class HomePageFilesControllerTest < ActionController::TestCase
  setup do
    @home_page_file = home_page_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:home_page_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create home_page_file" do
    assert_difference('HomePageFile.count') do
      post :create, home_page_file: { name: @home_page_file.name }
    end

    assert_redirected_to home_page_file_path(assigns(:home_page_file))
  end

  test "should show home_page_file" do
    get :show, id: @home_page_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @home_page_file
    assert_response :success
  end

  test "should update home_page_file" do
    patch :update, id: @home_page_file, home_page_file: { name: @home_page_file.name }
    assert_redirected_to home_page_file_path(assigns(:home_page_file))
  end

  test "should destroy home_page_file" do
    assert_difference('HomePageFile.count', -1) do
      delete :destroy, id: @home_page_file
    end

    assert_redirected_to home_page_files_path
  end
end
