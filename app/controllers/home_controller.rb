# -*- encoding: utf-8 -*-
class HomeController < ApplicationController
  before_action :login_check, :except => [:enter, :enter!]


  def login_check
    if session[:user]
      @user = User.find(session[:user])
    else
      redirect_to :action => :enter, :msg => 'ログインが必要です'
    end
  end

  def index
    @users = User.where("id != ? and card_list is not null", @user.id)
  end

  def enter
  end

  def match
  end

  def match!
    @dst_user = User.find(params[:dst_user_id])

    render :action => 'match'
  end

  def setup
  end

  def setup!
    raise "Error" unless params[:hidden_card_list]
    @user.card_list = params[:hidden_card_list]
    @user.save!
    redirect_to :action => 'index'
  end

  def enter!
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
    session[:user] = @user.id
    render :action => 'setup'
  rescue ActiveRecord::RecordInvalid
    redirect_to :action => :enter, :msg => '入力内容が間違ってるようです。。。'
  end

  def logout!
    session.delete(:user)
    redirect_to :action => :enter, :msg => 'ログアウトしました'
  end

end
