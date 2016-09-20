class TicketsController < ApplicationController
  before_action :set_project

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
    @ticket = @project.tickets.find(params[:id])
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end
