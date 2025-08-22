class ProfilesController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update ]

  def show
    # プロフィールページでは最新のお気に入り数件を表示
    @recent_favorites = current_user.favorite_reviews.includes(:fragrance, :user).limit(6).order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      redirect_to profile_path, notice: t("defaults.flash_message.updated", item: User.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def favorites
    # お気に入り一覧の全件表示
    @favorite_reviews = current_user.favorite_reviews.includes(:fragrance, :user).order(created_at: :desc)
  end

  private

  def set_user
    @user = current_user
  end

  def profile_params
    params.require(:user).permit(:name, :email, :profile_image)
  end
end
