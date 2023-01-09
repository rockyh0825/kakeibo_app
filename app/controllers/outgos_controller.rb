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
  end

  def edit
  end

  private
  def outgo_params
    params.require(:outgo).permit(:content, :cost, :genre_id, :start_time)
  end
end
