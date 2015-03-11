
class MembershipsController < ApplicationController

  before_action do
    @project=Project.find(params[:project_id])
  end

  def index
    @memberships=@project.memberships
    @membership=Membership.new
  end

end
