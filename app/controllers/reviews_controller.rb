class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_review, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def index
    @q = Review.ransack(params[:q])
    @reviews = @q.result(distinct: true).includes(:fragrance, :user).order(created_at: :desc).page(params[:page])
  end

  def new
    @review = Review.new
    if params[:fragrance_id]
      @review.fragrance_id = params[:fragrance_id]
    end
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to reviews_path, notice: t("defaults.flash_message.created", item: Review.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Review.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: t("defaults.flash_message.updated", item: Review.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Review.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path, notice: t("defaults.flash_message.deleted", item: Review.model_name.human)
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
