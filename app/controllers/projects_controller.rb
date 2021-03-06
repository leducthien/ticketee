class ProjectsController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :require_signin!, only: [:show, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.for(current_user)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = 'project created'
      redirect_to @project
    else
      flash[:alert] = 'Project has not been created'
      render 'new'
    end
  end

  def show

  end

  def edit

  end

  def update

    if @project.update(project_params)
      flash[:notice] = 'Project Updated'
      redirect_to @project
    else
      flash[:alert] = 'Fail to update project'
      render 'edit'
    end
  end

  def destroy

    @project.destroy
    flash[:notice] = 'Project deleted'
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = Project.for(current_user).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Project not exist'
    redirect_to projects_path
  end
end
