class UsersController < ApplicationController

  before_action :ensure_current_user

  def index
    @users=User.all
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      flash[:notice]="User was successfully created"
      redirect_to users_path
    else
      render :new
    end
  end

  def show
    @user=User.find(params[:id])
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="User was successfully updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user=User.find(params[:id])
    @user.destroy
    flash[:notice]="User was successfully deleted"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)
  end

  def ensure_current_user
    unless current_user
      flash[:alert]="You must sign in"
      redirect_to sign_in_path
    end
  end

end
