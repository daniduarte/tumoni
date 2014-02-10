class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to pockets_path
    end 
  end
end
