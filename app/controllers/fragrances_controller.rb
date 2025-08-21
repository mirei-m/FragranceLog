class FragrancesController < ApplicationController
  before_action :set_fragrance, only: [ :show, :edit, :update, :destroy ]

  def index
    @fragrances = current_user.fragrances.order(created_at: :desc).page(params[:page])
  end

  def new
    @fragrance = Fragrance.new
  end

  def create
    @fragrance = current_user.fragrances.build(fragrance_params)
    if @fragrance.save
      redirect_to fragrances_path, notice: t("defaults.flash_message.created", item: Fragrance.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Fragrance.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @fragrance.update(fragrance_params)
      redirect_to @fragrance, notice: t("defaults.flash_message.updated", item: Fragrance.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Fragrance.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @fragrance.destroy
    redirect_to fragrances_path, notice: t("defaults.flash_message.deleted", item: Fragrance.model_name.human)
  end

  private

  def fragrance_params
    params.require(:fragrance).permit(:name, :brand, :image, :sweetness, :freshness, :floral, :calm, :sexy, :spicy, tag_ids: [])
  end

  def set_fragrance
    @fragrance = current_user.fragrances.find(params[:id])
  end
end
