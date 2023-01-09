class OutgosController < ApplicationController
  def new
    @outgo = Outgo.new
  end

  def create
    @outgo = Outgo.new(outgo_params)
    @outgo.user_id = current_user.id
    @outgo.save
    redirect_to outgos_path
  end

  def index
    @outgos = current_user.outgos
    @cost = 0
    @asset = 0
    @outgos.each do |outgo|
      @asset -= outgo.cost
    end
    if params[:that_day]
      @outgo_day = Outgo.where(start_time: params[:that_day])
    end
  end

  def show
    @outgo = Outgo.find(params[:id])
  end

  def edit
    @outgo = Outgo.find(params[:id])
  end

  def update
    @outgo = Outgo.find(params[:id])
    @outgo.update(outgo_params)
    redirect_to outgos_path
  end

  private
  def outgo_params
    params.require(:outgo).permit(:content, :cost, :genre_id, :start_time)
  end
end
