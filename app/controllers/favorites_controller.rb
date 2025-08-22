class FavoritesController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @favorite = current_user.favorites.build(review: @review)

    if @favorite.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to review_path(@review) }
      end
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @review = @favorite.review
    @favorite.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to review_path(@review) }
    end
  end
end
