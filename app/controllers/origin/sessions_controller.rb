# encoding: utf-8
class Origin::SessionsController < ApplicationController
  skip_before_filter :authorize
  layout 'login', :only => :new
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    if user = Origin::User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      redirect_to home_url
    else
      redirect_to origin_login_url, :alert => '用户名密码不正确'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_url, :notice => '您已经成功登出'
  end

  def ajax_authorize
    if Origin::User.authenticate_by_id(session[:user_id], params[:password])
      render json: 'success'
    else
      render json: 'failed'
    end
  end

  def ajax_changepass
    user = Origin::User.find(session[:user_id])
    user.password = params[:password]
    a = user.save!
    p a
  end
end
