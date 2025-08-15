class CommentsController < ApplicationController
  before_action :set_comment, only: [ :destroy, :edit, :update ]
  before_action :authorize_user!, only: [ :destroy, :edit, :update ]

  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @review, notice: t("defaults.flash_message.created", item: Comment.model_name.human)
    else
      redirect_to @review, alert: t("defaults.flash_message.not_created", item: Comment.model_name.human)
    end
  end

  def edit
  end

  def update
    @comment.update(comment_params)
  end


  def destroy
    @comment.destroy!
    redirect_to @comment.review, notice: t("defaults.flash_message.deleted", item: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user!
    unless current_user.own?(@comment)
      redirect_to @comment.review, alert: t("defaults.flash_message.not_authorized")
    end
  end
end
