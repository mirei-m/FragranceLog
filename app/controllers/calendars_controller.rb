class CalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_calendar, only: [ :show, :edit, :update, :destroy ]

  def index
    @calendars = current_user.calendars.includes(:fragrance)
  end

  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = current_user.calendars.build(calendar_params)
    if @calendar.save
      redirect_to calendars_path, notice: t("defaults.flash_message.created", item: Calendar.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Calendar.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @calendar.update(calendar_params)
      redirect_to @calendar, notice: t("defaults.flash_message.updated", item: Calendar.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Calendar.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_calendar
    @calendar = current_user.calendars.find(params[:id])
  end

  def calendar_params
    params.require(:calendar).permit(:start_time, :weather, :mood, :memo, :fragrance_id)
  end
end
