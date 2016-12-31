class Ticket < ActiveRecord::Base
  attr_accessor :tag_names

  before_create :associate_tags

  belongs_to :project
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  has_many :assets
  accepts_nested_attributes_for :assets
  has_many :comments
  belongs_to :state

  has_and_belongs_to_many :tags

  def associate_tags_to_ticket(tags)
    names = []
    if tags
      tags.split(' ').each do |name|
        unless Tag.find_by(name: name)
          names << Tag.create(name: name)
        end
      end
    end
    self.tags << names
  end

  private

  def associate_tags
    associate_tags_to_ticket(self.tag_names)
  end


end
