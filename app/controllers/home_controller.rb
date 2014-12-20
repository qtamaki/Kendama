# -*- encoding: utf-8 -*-
class HomeController < ApplicationController
  before_action :login_check, :except => [:enter, :setup!]


  def login_check
    if session[:user]
      @user = session[:user]
    else
      redirect_to :action => :enter, :msg => 'ログインが必要です'
    end
  end

  def index
    @users = User.all
  end

  def enter
  end

  def match
  end

  def setup
  end

  def setup!
    @user = User.where(:nickname => params[:user_name]).first
    unless @user
      @user = User.new({:nickname => params[:user_name],
                        :login => params[:email],
                        :email => params[:email],
                        :image_number => params[:icon].to_i,
                        :access_level_type => 'normal',
                        :encrypted_password => 'dummy'})
      @user.save!
    end
    session[:user] = @user
    render :action => 'setup'
  rescue ActiveRecord::RecordInvalid
    redirect_to :action => :enter, :msg => '入力内容が間違ってるようです。。。'
  end

  def logout!
    session.delete(:user)
    redirect_to :action => :enter, :msg => 'ログアウトしました'
  end

end
