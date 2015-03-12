class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :memberships

  def full_name
    self.first_name + ' ' + self.last_name
  end

end
