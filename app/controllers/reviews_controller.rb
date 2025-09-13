class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :autocomplete ]
  before_action :set_review, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]
  before_action :setup_meta_tags, only: [ :show ]

  def index
    @q = Review.ransack(params[:q])
    @reviews = @q.result(distinct: true).includes([ :user, fragrance: :tags ]).order(created_at: :desc).page(params[:page])
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
  @comments = @review.comments.includes(:user).order(created_at: :desc)
  @comment = Comment.new
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

  def autocomplete
    term = params[:term]

    if term.blank? || term.length < 2
      render json: []
      return
    end

    fragrances = Fragrance.where(status: :published)
                          .where(
                            "name ILIKE ? OR brand ILIKE ?",
                            "%#{term}%", "%#{term}%"
                          )
                          .distinct
                          .limit(10)

    results = fragrances.map do |fragrance|
      {
        id: fragrance.id,
        perfume_name: fragrance.name,
        brand_name: fragrance.brand,
        value: "#{fragrance.brand} #{fragrance.name}"
      }
    end

    render json: results
  end

  private

  def set_review
    @review = Review.includes([ :user, fragrance: :tags ]).find(params[:id])
  end

  def review_params
    params.require(:review).permit(:fragrance_id, :body)
  end

  def authorize_user!
    redirect_to reviews_path, alert: t("defaults.flash_message.not_authorized") unless @review.user == current_user
  end

  def setup_meta_tags
    # レビュー本文を適切な長さに切り取り
    description = truncate_description(@review.body)

    # 香水名とブランド名を組み合わせ
    title = "#{@review.fragrance.name} - #{@review.fragrance.brand}"

    set_meta_tags(
      title: title,
      description: description,
      og: {
        title: title,
        description: description,
        image: fragrance_image_url(@review),
        url: request.original_url,
        type: "article"
      },
      twitter: {
        card: "summary_large_image",
        title: title,
        description: description,
        image: fragrance_image_url(@review)
      }
    )
  end

  def truncate_description(body)
    # レビュー本文を適切な長さに切り取り（100文字程度）
    body.present? ? body.truncate(100) : "香水レビューをチェック！"
  end

  def fragrance_image_url(review)
    if review.fragrance.image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(
        review.fragrance.image,
        host: request.host_with_port,
        protocol: request.protocol
      )
    else
      view_context.image_url("default_fragrance.png")
    end
  end
end
