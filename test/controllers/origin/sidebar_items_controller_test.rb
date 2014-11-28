require 'test_helper'

class Origin::SidebarItemsControllerTest < ActionController::TestCase
  setup do
    @origin_sidebar_item = origin_sidebar_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:origin_sidebar_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create origin_sidebar_item" do
    assert_difference('Origin::SidebarItem.count') do
      post :create, origin_sidebar_item: { name: @origin_sidebar_item.name, parent_id: @origin_sidebar_item.parent_id, site_id: @origin_sidebar_item.site_id, url: @origin_sidebar_item.url }
    end

    assert_redirected_to origin_sidebar_item_path(assigns(:origin_sidebar_item))
  end

  test "should show origin_sidebar_item" do
    get :show, id: @origin_sidebar_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @origin_sidebar_item
    assert_response :success
  end

  test "should update origin_sidebar_item" do
    patch :update, id: @origin_sidebar_item, origin_sidebar_item: { name: @origin_sidebar_item.name, parent_id: @origin_sidebar_item.parent_id, site_id: @origin_sidebar_item.site_id, url: @origin_sidebar_item.url }
    assert_redirected_to origin_sidebar_item_path(assigns(:origin_sidebar_item))
  end

  test "should destroy origin_sidebar_item" do
    assert_difference('Origin::SidebarItem.count', -1) do
      delete :destroy, id: @origin_sidebar_item
    end

    assert_redirected_to origin_sidebar_items_path
  end
end
