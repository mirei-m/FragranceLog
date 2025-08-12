class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!, except: [ :health ]

  def health
    render json: { status: "ok", timestamp: Time.current }, status: :ok
  end
end
