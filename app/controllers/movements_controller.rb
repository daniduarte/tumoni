class MovementsController < ApplicationController
  before_action :set_movement, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /movements
  # GET /movements.json
  def index
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
  end

  # GET /movements/1/edit
  def edit
  end

  def movement_history(movement, action)
    @movement_history = MovementHistory.new(
      :description => movement.description,
      :amount => movement.amount, 
      :movement_id => movement.id,
      :pocket_id => movement.pocket_id,
      :user_id => movement.user_id,
      :movement_type_id => action)

    @movement_history.save
  end

  # POST /movements
  # POST /movements.json
  def create
    params = movement_params

    if params[:amount].blank?
      params[:amount] = 0
    end

    if params[:description].blank?
      params[:description] = 'Movimiento sin nombre'
    end

    @movement = Movement.new(params)

    respond_to do |format|
      if @movement.save
        format.html { redirect_to "/pockets/#{@movement.pocket_id}", notice: 'Movement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @movement }
        movement_history @movement, 1
      else
        format.html { render action: 'new' }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movements/1
  # PATCH/PUT /movements/1.json
  def update
    params = movement_params

    if params[:amount].blank?
      params[:amount] = 0
    end

    if params[:description].blank?
      params[:description] = 'Movimiento sin nombre'
    end

    respond_to do |format|
      if @movement.update(params)
        format.html { redirect_to @movement, notice: 'Movement was successfully updated.' }
        format.json { head :no_content }
        movement_history @movement, 2
      else
        format.html { render action: 'edit' }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movements/1
  # DELETE /movements/1.json
  def destroy
    movement_history @movement, 3

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
