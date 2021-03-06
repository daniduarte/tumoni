class PocketsController < ApplicationController
  before_action :set_pocket, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /pockets
  # GET /pockets.json
  def index
    @pockets = Pocket.where user_id: current_user.id
    @movements = Movement.where user_id: current_user.id
  end

  # GET /pockets/1
  # GET /pockets/1.json
  def show
    @movements = Movement.where user_id: current_user.id
  end

  # GET /pockets/new
  def new
    @pocket = Pocket.new
  end

  # GET /pockets/1/edit
  def edit
  end

  def pocket_history(pocket, action)
    @pocket_history = PocketsHistory.new(
      :name => pocket.name,
      :pocket_id => pocket.id,
      :user_id => pocket.user_id,
      :action_id => action)

    @pocket_history.save
  end

  # POST /pockets
  # POST /pockets.json
  def create
    params = pocket_params

    if params[:name].blank?
      params[:name] = 'Bolsillo sin nombre'
    end

    @pocket = Pocket.new(params)

    respond_to do |format|
      if @pocket.save
        format.html { redirect_to pockets_url, notice: 'Pocket was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pocket }
        pocket_history @pocket, 1
      else
        format.html { render action: 'new' }
        format.json { render json: @pocket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pockets/1
  # PATCH/PUT /pockets/1.json
  def update
    params = pocket_params

    if params[:name].blank?
      params[:name] = 'Bolsillo sin nombre'
    end
    
    respond_to do |format|
      if @pocket.update(params)
        format.html { redirect_to @pocket, notice: 'Pocket was successfully updated.' }
        format.json { head :no_content }
        pocket_history @pocket, 2
      else
        format.html { render action: 'edit' }
        format.json { render json: @pocket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pockets/1
  # DELETE /pockets/1.json
  def destroy
    pocket_history @pocket, 3

    @pocket.destroy

    respond_to do |format|
      format.html { redirect_to pockets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pocket
      @pocket = Pocket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pocket_params
      params.require(:pocket).permit(:name, :user_id, :pocket_id)
    end
end
