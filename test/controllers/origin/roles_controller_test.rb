require 'test_helper'

class Origin::RolesControllerTest < ActionController::TestCase
  setup do
    @origin_role = origin_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:origin_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create origin_role" do
    assert_difference('Origin::Role.count') do
      post :create, origin_role: { adminFlag: @origin_role.adminFlag, name: @origin_role.name }
    end

    assert_redirected_to origin_role_path(assigns(:origin_role))
  end

  test "should show origin_role" do
    get :show, id: @origin_role
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @origin_role
    assert_response :success
  end

  test "should update origin_role" do
    patch :update, id: @origin_role, origin_role: { adminFlag: @origin_role.adminFlag, name: @origin_role.name }
    assert_redirected_to origin_role_path(assigns(:origin_role))
  end

  test "should destroy origin_role" do
    assert_difference('Origin::Role.count', -1) do
      delete :destroy, id: @origin_role
    end

    assert_redirected_to origin_roles_path
  end
end
