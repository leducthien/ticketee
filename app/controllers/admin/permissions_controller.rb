class Admin::PermissionsController < Admin::BaseController
  before_action :set_user

  def index
    @ability = Ability.new @user
    @projects = Project.all
  end

  def set
    @user.permissions.clear
    params[:permissions].each do |project_id, permissions|
      project = Project.find project_id
      permissions.each do |action, checked|
        if checked
          Permission.create!(user: @user, thing: project, action: action)
        end
      end
    end
    flash[:notice] = 'Permissions updated'
    redirect_to admin_user_permissions_path @user
  end
  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
