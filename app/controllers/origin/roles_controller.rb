class Origin::RolesController < ApplicationController
  before_action :set_origin_role, only: [:show, :edit, :update, :destroy]
  before_action :init_sidebar_item, only: [:new, :edit]

  # GET /origin/roles
  # GET /origin/roles.json
  def index
    @origin_roles = Origin::Role.all
  end

  # GET /origin/roles/1
  # GET /origin/roles/1.json
  def show
  end

  # GET /origin/roles/new
  def new
    @origin_role = Origin::Role.new
  end

  # GET /origin/roles/1/edit
  def edit
  end

  # POST /origin/roles
  # POST /origin/roles.json
  def create
    @origin_role = Origin::Role.new(origin_role_params)

    respond_to do |format|
      set_sidebar_item(@origin_role)
      if @origin_role.save
        format.html { redirect_to @origin_role, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @origin_role }
      else
        format.html { render :new }
        format.json { render json: @origin_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /origin/roles/1
  # PATCH/PUT /origin/roles/1.json
  def update
    respond_to do |format|
      set_sidebar_item(@origin_role)
      if @origin_role.update(origin_role_params)
        format.html { redirect_to @origin_role, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @origin_role }
      else
        format.html { render :edit }
        format.json { render json: @origin_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /origin/roles/1
  # DELETE /origin/roles/1.json
  def destroy
    @origin_role.destroy
    respond_to do |format|
      format.html { redirect_to origin_roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_origin_role
    @origin_role = Origin::Role.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def origin_role_params
    params.require(:origin_role).permit(:name, :adminFlag)
  end

  def init_sidebar_item
    @sidebars = Origin::SidebarItem.where.not(:parent_id => nil)
  end

  def set_sidebar_item(role)
    role.role_item_ships.clear
    params[:item].each do |item|
      role.role_item_ships.build(:sidebar_item_id => item)
    end
  end
end
