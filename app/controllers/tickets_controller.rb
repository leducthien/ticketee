class TicketsController < ApplicationController

  # Order is important here. We need to find a project first before finding its ticket.
  before_action :set_project
  before_action :require_signin!
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.user = current_user
    if @ticket.save
      flash[:notice] = 'Ticket created'
      redirect_to [@project, @ticket]
    else
      flash[:alert] = 'Create ticket failed'
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      flash[:notice] = 'Ticket updated'
      redirect_to project_ticket_path(@project, @ticket)
      # or redirect_to [@project, @ticket]
    else
      flash[:alert] = 'Updating ticket failed'
      render 'edit'
      # or render action: "edit"
    end
  end

  def destroy
    @ticket.destroy

    flash[:notice] = 'Ticket Deleted'
    redirect_to @project
  end

  private

  def set_project
    @project = Project.for(current_user).find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Project not exist'
    redirect_to root_path
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end
