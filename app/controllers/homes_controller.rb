class HomesController < ApplicationController
  def top
    sign_out(current_user) if user_signed_in?
  end

  def about
  end
end
