class ProjectsController < ApplicationController
  def index
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(required_params)

    if @project.save
      flash[:notice] = 'project created'
      redirect_to @project
    else
      # do something
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  private

  # Prevent security risks
  def required_params
    params.require(:project).permit(:name, :description)
  end
end
