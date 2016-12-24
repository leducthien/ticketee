class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true

  has_many :permissions

  def to_s
    "#{name} - #{email} (#{admin? ? 'Admin' : 'User'})"
  end
end
