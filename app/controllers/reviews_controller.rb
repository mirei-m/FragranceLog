class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_calendar, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def index
    @reviews = Review.includes(:fragrance, :user).order(created_at: :desc)
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:fragrance_id, :body)
  end

  def authorize_user!
    redirect_to reviews_path, alert: t("defaults.flash_message.not_authorized") unless @review.user == current_user
  end
end
