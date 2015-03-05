
class AuthenticationsController < ApplicationController

  def destroy
    session[:user_id]=nil
    flash[:notice]="You have successfully logged out"
    redirect_to root_path
  end

  def new
    @user=User.new
  end

  def create
    @user=User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      flash[:notice]="You have successfully signed in"
      redirect_to root_path
    else
      render :new
    end
  end

end
