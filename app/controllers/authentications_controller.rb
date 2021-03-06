
class AuthenticationsController < PublicController

  def destroy
    session[:user_id]=nil
    session[:previous_url]=nil
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
      if session[:previous_url] == nil
        redirect_to projects_path
      else
        redirect_to session[:previous_url]
      end
    else
      @sign_in_error="Email / Password combination is invalid"
      render :new
    end
  end

end
