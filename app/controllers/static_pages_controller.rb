class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :top ]

  def top
  end

  def terms_of_service
  end
end
