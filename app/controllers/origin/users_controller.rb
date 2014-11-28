# encoding: utf-8
class Origin::UsersController < ApplicationController
  before_action :set_origin_user, only: [:show, :edit, :update, :destroy]

  # GET /origin/users
  # GET /origin/users.json
  def index
    @origin_users = Origin::User.order(:name)
  end

  # GET /origin/users/1
  # GET /origin/users/1.json
  def show
  end

  # GET /origin/users/new
  def new
    @origin_user = Origin::User.new
  end

  # GET /origin/users/1/edit
  def edit
  end

  # POST /origin/users
  # POST /origin/users.json
  def create
    @origin_user = Origin::User.new(origin_user_params)

    respond_to do |format|
      if @origin_user.save
        flash[:notice_type] = :success
        format.html { redirect_to @origin_user, notice: "用户 #{@origin_user.name} 已经成功创建！" }
        format.json { render :show, status: :created, location: @origin_user }
      else
        format.html { render :new }
        format.json { render json: @origin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /origin/users/1
  # PATCH/PUT /origin/users/1.json
  def update
    respond_to do |format|
      if @origin_user.update(origin_user_params)
        flash[:notice_type] = :success
        format.html { redirect_to origin_users_url, notice: "用户 #{@origin_user.name} 已经修改完成！" }
        format.json { render :show, status: :ok, location: @origin_user }
      else
        format.html { render :edit }
        format.json { render json: @origin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /origin/users/1
  # DELETE /origin/users/1.json
  def destroy
    begin
      @origin_user.destroy
      flash[:notice] = "用户 #{@user.name} 已经被删除"
    rescue Exception => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to origin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_origin_user
    @origin_user = Origin::User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def origin_user_params
    params.require(:origin_user).permit(:name, :pname, :hashed_password, :salt, :password, :password_confirmation, :role_id)
  end
end
