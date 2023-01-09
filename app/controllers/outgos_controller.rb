class OutgosController < ApplicationController
  def new
    @outgo = Outgo.new
  end

  def create
    @outgo = Outgo.new(outgo_params)
    @outgo.user_id = current_user.id
    @outgo.start_time = @outgo.day
    @outgo.save
    redirect_to outgos_path
  end

  def index
    @outgos = current_user.outgos
  end

  def edit
  end

  private
  def outgo_params
    params.require(:outgo).permit(:content, :cost, :day, :genre_id)
  end
end
