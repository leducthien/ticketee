class Project < ActiveRecord::Base
  validates :name, presence: true

  # When a project is deleted, all its tickets are automatically deleted.
  has_many :tickets, dependent: :delete_all
end
