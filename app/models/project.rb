class Project < ActiveRecord::Base
  validates :name, presence: true

  # When a project is deleted, all its tickets are automatically deleted.
  has_many :tickets, dependent: :delete_all

  has_many :permissions, as: :thing

  scope :viewable_by, -> (user) do
    joins(:permissions).where(permissions: {action: 'view', user_id: user.id})
  end
end
