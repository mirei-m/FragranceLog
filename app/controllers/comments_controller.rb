class CommentsController < ApplicationController
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

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
