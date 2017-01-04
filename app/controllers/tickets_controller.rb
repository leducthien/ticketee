class TicketsController < ApplicationController

  # Order is important here. We need to find a project first before finding its ticket.
  before_action :set_project
  before_action :require_signin!
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authorize_create!, only: [:new, :create]
  before_action :authorize_edit!, only: [:edit, :update]
  before_action :authorize_delete!, only: [:destroy]

  def new
    @ticket = @project.tickets.build
    create_empty_files
  end

  def create
    if cannot?(:tags, @project) && !current_user.admin?
      params[:ticket].delete(:tag_names)
    end
    @ticket = @project.tickets.build(ticket_params)
    @ticket.user = current_user
    # byebug
    if @ticket.save
      flash[:notice] = 'Ticket created'
      redirect_to [@project, @ticket]
    else
      flash[:alert] = 'Create ticket failed'
      unless @ticket.assets.present?
        create_empty_files
      end
      render 'new'
    end
  end

  def show
    @comment = @ticket.comments.build
    @states = State.all
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
    params.require(:ticket).permit(:title, :description, :tag_names, assets_attributes: [:asset])
  end

  def authorize_create!
    # byebug
    if !current_user.admin? && cannot?('create tickets'.to_sym, @project)
      flash[:alert] = 'You cannot create tickets for this project'
      redirect_to project_path(@project)
    end
  end

  def authorize_edit!
    if !current_user.admin? && cannot?('edit tickets'.to_sym, @project)
      flash[:alert] = 'You cannot edit tickets for this project'
      redirect_to @project
    end
  end

  def authorize_delete!
    if !current_user.admin? && cannot?('delete tickets'.to_sym, @project)
      flash[:alert] = 'You cannot delete tickets for this project'
      redirect_to @project
    end
  end

  def create_empty_files
    @ticket.assets.build
  end
end
