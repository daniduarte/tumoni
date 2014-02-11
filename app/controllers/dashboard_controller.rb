class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def history_movements
    if current_user.type_id == 1
      @movement_history = MovementHistory.all
    else
      redirect_to pockets_path
    end
  end
end
