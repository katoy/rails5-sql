class ActressesController < ApplicationController
  before_action :set_actress, only: [:show, :update, :destroy]

  # GET /actresses
  def index
    @actresses = Actress.all

    render json: @actresses
  end

  # GET /actresses/1
  def show
    render json: @actress
  end

  # POST /actresses
  def create
    @actress = Actress.new(actress_params)

    if @actress.save
      render json: @actress, status: :created, location: @actress
    else
      render json: @actress.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /actresses/1
  def update
    if @actress.update(actress_params)
      render json: @actress
    else
      render json: @actress.errors, status: :unprocessable_entity
    end
  end

  # DELETE /actresses/1
  def destroy
    @actress.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actress
      @actress = Actress.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def actress_params
      params.require(:actress).permit(:name)
    end
end
