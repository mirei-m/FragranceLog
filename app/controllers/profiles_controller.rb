class ProfilesController < ApplicationController
  before_action :set_user, only: [ :show :edit, :update ]

  def show
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      redirect_to profile_path, success: t("defaults.flash_message.updated", item: User.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def profile_params
    params.require(:user).permit(:name, :email)
  end
end
