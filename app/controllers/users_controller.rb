class UsersController < ApplicationController
  before_action :admin_only
  def index
    @user = User.all
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.all
  end

  def update
    @user = User.find(params[:id])
    @user.roles = Role.where(id: params[:user][:role_ids])
    if @user.update(user_params)
      redirect_to users_path, notice: 'User updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User deleted successfully.'
  end

  private

  def user_params
    params.require(:user).permit(:email, role_ids: [])
  end
  def admin_only
    unless current_user.has_role?(:admin)
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end
