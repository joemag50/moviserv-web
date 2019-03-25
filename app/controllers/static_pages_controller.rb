class StaticPagesController < ApplicationController
  def home
    redirect_to app_path if user_signed_in?
  end

  def app
  end
end
