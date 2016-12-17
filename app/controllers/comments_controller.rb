class CommentsController < ApplicationController
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
    params.require(:comment).permit(:text, :state_id)
  end
end
