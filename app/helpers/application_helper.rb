module ApplicationHelper
  def title(*arg)
    unless arg.nil?
      content_for :title do
        (arg << 'Ticketee').join(' - ')
      end
    end
  end
end
