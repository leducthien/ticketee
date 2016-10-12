module ApplicationHelper
  def title(*arg)
    unless arg.nil?
      content_for :title do
        (arg << 'Ticketee').join(' - ')
      end
    end
  end

  def admins_only(&block)
    # byebug
    block.call if current_user.try(:admin?)
  end
end
