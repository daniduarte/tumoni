class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @movement_history = MovementHistory.all
  end
end
