class GamesController < ApplicationController
  before_action :authenticate_user!, except: %i[show download latest]
  before_action :set_game, only: %i[show edit update destroy download publish]

  # GET /games or /games.json
  def index
    @games = Game.by_user(current_user)
  end

  def latest
    @games = Game.only_public.latest
    render action: :index
  end

  # GET /games/1 or /games/1.json
  def show
    set_grid_with_generation
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    grid_file = params[:game][:grid_file]

    @game = Game.new
    if grid_file&.path
      begin
        grid = Game::Utils.grid_from_file(grid_file.path)
        @game = Game::Utils.game_from_grid(grid)
      rescue ArgumentError => e
        @game.errors.add(:grid_file, e.message)
      end
    else
      @game.errors.add(:grid_file, 'missing')
    end

    @game.user = current_user
    @game.public = params[:game][:public]
    @game.name = params[:game][:name]
    @game.description = params[:game][:description]

    respond_to do |format|
      if @game.errors.blank? && @game.save
        format.html { redirect_to game_url(@game), notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_url(@game), notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def download
    set_grid_with_generation
    filename = "#{@game.code}-generation-#{@grid.generation}.txt"
    send_data Game::Utils.grid_to_string(@grid), filename: filename
  end

  def publish
    @game.update_attribute(:public, params[:public] == 'true')
    redirect_to action: :show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    games = current_user ? Game.by_user(current_user) : Game.only_public
    @game = games.find_by!(code: params[:code])
  end

  def set_grid_with_generation
    @grid = @game.grid
    generation = params[:generation].to_i
    @grid = @grid.goto(generation) if generation > @grid.generation
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:name, :description, :public)
  end
end
