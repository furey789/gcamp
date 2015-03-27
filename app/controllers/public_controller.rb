
class PublicController < ApplicationController

  skip_before_action :ensure_current_user
  skip_before_action :ensure_member

end
