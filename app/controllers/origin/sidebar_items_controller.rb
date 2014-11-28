class Origin::SidebarItemsController < ApplicationController
  before_action :set_origin_sidebar_item, only: [:show, :edit, :update, :destroy]

  # GET /origin/sidebar_items
  # GET /origin/sidebar_items.json
  def index
    @origin_sidebar_items = Origin::SidebarItem.all
  end

  # GET /origin/sidebar_items/1
  # GET /origin/sidebar_items/1.json
  def show
  end

  # GET /origin/sidebar_items/new
  def new
    @origin_sidebar_item = Origin::SidebarItem.new
  end

  # GET /origin/sidebar_items/1/edit
  def edit
  end

  # POST /origin/sidebar_items
  # POST /origin/sidebar_items.json
  def create
    @origin_sidebar_item = Origin::SidebarItem.new(origin_sidebar_item_params)

    respond_to do |format|
      if @origin_sidebar_item.save
        format.html { redirect_to @origin_sidebar_item, notice: 'Sidebar item was successfully created.' }
        format.json { render :show, status: :created, location: @origin_sidebar_item }
      else
        format.html { render :new }
        format.json { render json: @origin_sidebar_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /origin/sidebar_items/1
  # PATCH/PUT /origin/sidebar_items/1.json
  def update
    respond_to do |format|
      if @origin_sidebar_item.update(origin_sidebar_item_params)
        format.html { redirect_to @origin_sidebar_item, notice: 'Sidebar item was successfully updated.' }
        format.json { render :show, status: :ok, location: @origin_sidebar_item }
      else
        format.html { render :edit }
        format.json { render json: @origin_sidebar_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /origin/sidebar_items/1
  # DELETE /origin/sidebar_items/1.json
  def destroy
    @origin_sidebar_item.destroy
    respond_to do |format|
      format.html { redirect_to origin_sidebar_items_url, notice: 'Sidebar item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_origin_sidebar_item
    @origin_sidebar_item = Origin::SidebarItem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def origin_sidebar_item_params
    res = params.require(:origin_sidebar_item).permit(:name, :url, :site_id, :parent_id, :active_flag)
    if res[:parent_id].nil? || res[:parent_id] == ''
      res[:site_id] = Origin::Site.current_site.id
    else
      res[:site_id] = nil
    end
    res
  end
end
