class CommentsController < ApplicationController
  before_action :set_comment, only: [ :destroy, :edit, :update ]
  before_action :authorize_user!, only: [ :destroy, :edit, :update ]

  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def edit
  end

  def update
    @comment.update(comment_params)
  end


  def destroy
    @review = @comment.review
    @comment.destroy!
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
