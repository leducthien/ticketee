class Comment < ActiveRecord::Base
  attr_accessor :tag_names

  before_create :set_previous_state
  after_create :set_ticket_state, :associate_tags_to_ticket

  belongs_to :ticket
  belongs_to :user
  belongs_to :state
  belongs_to :previous_state, class_name: 'State'
  validates :text, presence: true

  # Following line of code is the same as
  # def project
  # => ticket.project
  # end
  delegate :project, to: :ticket

  private

  def set_previous_state
    self.previous_state = self.ticket.state
  end


  def set_ticket_state
    self.ticket.state = self.state
    self.ticket.save!
  end

  def associate_tags_to_ticket
    self.ticket.associate_tags_to_ticket(tag_names)
  end
end
