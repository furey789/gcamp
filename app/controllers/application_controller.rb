class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    if session[:user_id].present?
      User.find(session[:user_id])
    end
  end

  before_action :ensure_current_user

  def ensure_current_user
    unless current_user
      flash[:alert]="You must sign in"
      rp = request.path
      session[:previous_url] = nil
      if (request.path != "/sign-in" && request.path != "/sign-up" &&
          request.path != "/about" && request.path != "/terms" &&
          request.path != "/faq" && request.path != "/sign-out" &&
          !request.xhr?) # don't store ajax calls
        session[:previous_url] = request.fullpath
      end
      redirect_to sign_in_path
    end
    @projects=Project.all
  end

  #------------------

  def ensure_member
    unless @project.memberships.pluck(:user_id).include?(current_user.id) || current_user.admin == true
      flash[:alert]="You do not have access to that project"
      redirect_to projects_path
    end
  end

  def ensure_owner
    project_owner = @project.memberships.find_by(role: 'owner')
    unless current_user.id == project_owner.user_id || current_user.admin == true
      flash[:alert]="You do not have access"
      redirect_to project_path(@project)
    end
  end

  def ensure_owner_or_memberself
    project_owner = @project.memberships.find_by(role: 'owner')
    unless ( current_user.id == project_owner.user_id && defined?(params)!=nil && current_user.id != Membership.find(params[:id]).user_id ) || current_user.admin == true
      flash[:alert]="You do not have access"
      redirect_to project_path(@project)
    end
  end

  def ensure_user
    unless current_user.id == params[:id].to_i || current_user.admin == true
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

end
