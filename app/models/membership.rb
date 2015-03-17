
class Membership < ActiveRecord::Base

  belongs_to :project
  belongs_to :user

  validates :user, presence: true,
      uniqueness: {message: "has already been added to this project" }

end
