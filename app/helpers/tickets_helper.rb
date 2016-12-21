module TicketsHelper
  def state_for(comment)
    content_tag(:div, {class: 'state'}, false) do
      previous_state = comment.previous_state
      if comment.state
        if previous_state && comment.state != previous_state
          "#{render previous_state} &rarr; #{render comment.state}"
        else
          render comment.state
        end
      else
        ''
      end
    end
  end
end
