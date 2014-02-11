class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def movements_history
    if current_user.type_id == 1
      @movement_history = MovementHistory.all
    else
      redirect_to pockets_path
    end
  end

  def pockets_history
    if current_user.type_id == 1
      @pockets_history = PocketsHistory.all
    else
      redirect_to pockets_path
    end
  end
end
