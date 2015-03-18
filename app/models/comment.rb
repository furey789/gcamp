
class Comment < ActiveRecord::Base

  validates :words, presence: true

  belongs_to :user
  belongs_to :task

end
