class CommentsController < ApplicationController
  include ApplicationHelper

  before_action :require_signin!

  def create
    @ticket = Ticket.find(params[:ticket_id])
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
    permitted = params.require(:comment).permit(:text, :tag_names)
    authorize?("change states", @ticket.project) do
      permitted.merge!(params.require(:comment).permit(:state_id))
    end
    permitted
  end
end
