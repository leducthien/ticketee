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
    if tags
      tags.split(' ').each do |name|
        tag = Tag.find_or_create_by(name: name)
        unless self.tags.exists?(tag.id)
          self.tags << tag
        end
      end
    end
  end

  private

  def associate_tags
    associate_tags_to_ticket(self.tag_names)
  end


end
