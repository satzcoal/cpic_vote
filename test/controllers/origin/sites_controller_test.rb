require 'test_helper'

class Origin::SitesControllerTest < ActionController::TestCase
  setup do
    @origin_site = origin_sites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:origin_sites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create origin_site" do
    assert_difference('Origin::Site.count') do
      post :create, origin_site: { isAuthorize: @origin_site.isAuthorize, isNavbar: @origin_site.isNavbar, isRole: @origin_site.isRole, isSidebar: @origin_site.isSidebar, isTopbar: @origin_site.isTopbar, logo: @origin_site.logo, title: @origin_site.title }
    end

    assert_redirected_to origin_site_path(assigns(:origin_site))
  end

  test "should show origin_site" do
    get :show, id: @origin_site
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @origin_site
    assert_response :success
  end

  test "should update origin_site" do
    patch :update, id: @origin_site, origin_site: { isAuthorize: @origin_site.isAuthorize, isNavbar: @origin_site.isNavbar, isRole: @origin_site.isRole, isSidebar: @origin_site.isSidebar, isTopbar: @origin_site.isTopbar, logo: @origin_site.logo, title: @origin_site.title }
    assert_redirected_to origin_site_path(assigns(:origin_site))
  end

  test "should destroy origin_site" do
    assert_difference('Origin::Site.count', -1) do
      delete :destroy, id: @origin_site
    end

    assert_redirected_to origin_sites_path
  end
end
