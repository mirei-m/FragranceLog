class FragrancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fragrance, only: [:show, :edit, :update, :destroy]

  def index
    @fragrances = current_user.fragrances
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
  end

  def destroy
  end

  private

  def fragrance_params
    params.require(:fragrance).permit(:name, :brand)
  end

  def set_fragrance
    @fragrance = Fragrance.find(params[:id])
  end
end
