class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:about]

  def top
    sign_out(current_user) if user_signed_in?
  end

  def about
  end
end
