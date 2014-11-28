require 'test_helper'

class Origin::UsersControllerTest < ActionController::TestCase
  setup do
    @origin_user = origin_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:origin_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create origin_user" do
    assert_difference('Origin::User.count') do
      post :create, origin_user: { hashed_password: @origin_user.hashed_password, name: @origin_user.name, salt: @origin_user.salt }
    end

    assert_redirected_to origin_user_path(assigns(:origin_user))
  end

  test "should show origin_user" do
    get :show, id: @origin_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @origin_user
    assert_response :success
  end

  test "should update origin_user" do
    patch :update, id: @origin_user, origin_user: { hashed_password: @origin_user.hashed_password, name: @origin_user.name, salt: @origin_user.salt }
    assert_redirected_to origin_user_path(assigns(:origin_user))
  end

  test "should destroy origin_user" do
    assert_difference('Origin::User.count', -1) do
      delete :destroy, id: @origin_user
    end

    assert_redirected_to origin_users_path
  end
end
