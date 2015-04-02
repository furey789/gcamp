class UsersController < ApplicationController

  before_action :ensure_user, only: [:edit]

  def index
    @users=User.all
    @memberships=Membership.all
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
    @memberships=Membership.all
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if current_user.admin == true || ( current_user.admin == false && @user.admin == false )
      if @user.update(user_params)
        flash[:notice]="User was successfully updated"
        redirect_to users_path
      else
        render :edit
      end
    end
  end

  def destroy

    @user=User.find(params[:id])
    @comments=Comment.all
    @comments.each do |comment|
      if comment.user_id==@user.id
        comment.user_id=nil
        comment.save
      end
    end

    if @user.id == current_user.id
      session[:user_id]=nil
      @user.destroy
      redirect_to root_path
    else
      @user.destroy
      flash[:notice]="User was successfully deleted"
      redirect_to users_path
    end

  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation, :token)
  end

end
