class FavoritesController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @favorite = current_user.favorites.build(review: @review)

    if @favorite.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to review_path(@review) }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "favorite_button_#{@review.id}",
            partial: "shared/favorite_button",
            locals: { review: @review }
          ), status: :unprocessable_entity
        end
        format.html do
          redirect_to review_path(@review),
                      alert: "お気に入りに追加できませんでした。"
        end
      end
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    @favorite = current_user.favorites.find_by(review: @review)

    if @favorite&.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to review_path(@review) }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "favorite_button_#{@review.id}",
            partial: "shared/favorite_button",
            locals: { review: @review }
          ), status: :unprocessable_entity
        end
        format.html do
          redirect_to review_path(@review),
                      alert: "お気に入りの削除に失敗しました。"
        end
      end
    end
  end
end
