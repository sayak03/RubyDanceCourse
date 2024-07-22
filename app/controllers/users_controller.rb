class UsersController < ApplicationController
  before_action :admin_only
  def index
    @user = User.with_any_role(:newuser)
    @admins_and_moderators = User.with_any_role(:admin, :moderate)
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
