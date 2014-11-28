class Origin::SitesController < ApplicationController
  before_action :set_origin_site, only: [:show, :edit, :update, :destroy]

  # GET /origin/sites
  # GET /origin/sites.json
  def index
    redirect_to :action => :new
  end

  # GET /origin/sites/1
  # GET /origin/sites/1.json
  def show
  end

  # GET /origin/sites/new
  def new
    if @origin_site = Origin::Site.first
      redirect_to @origin_site
      return
    else
      @origin_site = Origin::Site.new
    end
  end

  # GET /origin/sites/1/edit
  def edit
  end

  # POST /origin/sites
  # POST /origin/sites.json
  def create
    @origin_site = Origin::Site.new(origin_site_params)

    respond_to do |format|
      if @origin_site.save
        format.html { redirect_to @origin_site, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @origin_site }
      else
        format.html { render :new }
        format.json { render json: @origin_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /origin/sites/1
  # PATCH/PUT /origin/sites/1.json
  def update
    respond_to do |format|
      if @origin_site.update(origin_site_params)
        format.html { redirect_to origin_site_path, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @origin_site }
      else
        format.html { render :edit }
        format.json { render json: @origin_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /origin/sites/1
  # DELETE /origin/sites/1.json
  def destroy
    @origin_site.destroy
    respond_to do |format|
      format.html { redirect_to origin_sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_origin_site
    @origin_site = Origin::Site.first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def origin_site_params
    params.require(:origin_site).permit(:logo, :title, :isAuthorize, :isRole, :isSidebar, :isTopbar, :isNavbar)
  end
end
