class TicketsController < ApplicationController
  # Order is important here. We need to find a project first before finding its ticket.
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update]

  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
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

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end
