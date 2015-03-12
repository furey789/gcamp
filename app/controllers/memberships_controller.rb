
class MembershipsController < ApplicationController

  before_action do
    @project=Project.find(params[:project_id])
  end

  def index
    @memberships=@project.memberships
    @membership=Membership.new
    @membership_types=['member','owner']
  end



  def create
    # @membership=@project.membership.new(params.require(:membership).permit(:user_id,:role,:project_id))
    @membership=Membership.new(params.require(:membership).permit(:user_id,:role).merge(project_id: params[:project_id]))
    if @membership.save
      flash[:notice]= @membership.user.full_name + " was successfully added"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

end
