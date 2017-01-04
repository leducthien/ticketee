class CommentsController < ApplicationController
  include ApplicationHelper

  before_action :require_signin!

  def create
    @ticket = Ticket.find(params[:ticket_id])
    sanitize_parameters!
    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user
    @project = @ticket.project
    if @comment.save
      flash[:info] = 'Comment saved'
      redirect_to project_ticket_path(@project, @ticket)
    else
      flash[:alert] = 'Failed to create comment'
      @states = State.all
      render 'tickets/show'
    end
  end

  private

  def comment_params
    permitted = params.require(:comment).permit(:text, :tag_names, :state_id)
    # authorize?("change states", @ticket.project) do
    #   permitted.merge!(params.require(:comment).permit(:state_id))
    # end
    # permitted
  end

  def sanitize_parameters!
    if cannot?(:tags, @ticket.project) && !current_user.admin?
      params[:comment].delete(:tag_names)
    end
    if cannot?("change states", @ticket.project) && !current_user.admin?
      params[:comment].delete(:state_id)
    end
  end
end
