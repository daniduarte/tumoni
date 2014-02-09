class MovementsController < ApplicationController
  before_action :set_movement, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /movements
  # GET /movements.json
  def index
    # @movements = Movement.where user_id: current_user.id
    # @pockets = Pocket.all
    redirect_to pockets_url
  end

  # GET /movements/1
  # GET /movements/1.json
  def show
    redirect_to pockets_url
  end

  # GET /movements/new
  def new
    @movement = Movement.new
    # @pocket = Pocket.where id: params[:pocket_id]
  end

  # GET /movements/1/edit
  def edit
  end

  def movement_history_create
    last_movement = Movement.last

    @movement_history = MovementHistory.new(
      :description => last_movement.description,
      :amount => last_movement.amount, 
      :movement_id => last_movement.id,
      :pocket_id => last_movement.pocket_id,
      :user_id => last_movement.user_id)

    @movement_history.save
  end

  def movement_history_update
    last_movement = Movement.order(updated_at: :desc).take

    @movement_history = MovementHistory.new(
      :description => last_movement.description,
      :amount => last_movement.amount, 
      :movement_id => last_movement.id,
      :pocket_id => last_movement.pocket_id,
      :user_id => last_movement.user_id)

    @movement_history.save
  end

  # POST /movements
  # POST /movements.json
  def create
    @movement = Movement.new(movement_params)

    respond_to do |format|
      if @movement.save
        format.html { redirect_to "/pockets/#{@movement.pocket_id}", notice: 'Movement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @movement }
        movement_history_create
      else
        format.html { render action: 'new' }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movements/1
  # PATCH/PUT /movements/1.json
  def update
    respond_to do |format|
      if @movement.update(movement_params)
        format.html { redirect_to @movement, notice: 'Movement was successfully updated.' }
        format.json { head :no_content }
        movement_history_update
      else
        format.html { render action: 'edit' }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movements/1
  # DELETE /movements/1.json
  def destroy
    @movement.destroy
    respond_to do |format|
      format.html { redirect_to pockets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movement
      @movement = Movement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movement_params
      params.require(:movement).permit(:description, :amount, :created_at, :pocket_id, :user_id)
    end
end
