class AboutController < ApplicationController
    def view
      @projects=Project.all
      @tasks=Task.all
      @memberships=Membership.all
      @users=User.all
      @comments=Comment.all
    end
end
