class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(:email)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User created'
      redirect_to admin_users_path
    else
      flash[:alert] = 'Failed to create user'
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      flash[:notice] = 'User updated'
      redirect_to admin_users_path
    else
      flash[:alert] = 'Update failed'
      render 'edit'
    end
  end

  def destroy
    if @user == current_user
      flash[:alert] = 'You cannot delete yourself'
    else
      @user.destroy
      flash[:notice] = 'User deleted'
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
