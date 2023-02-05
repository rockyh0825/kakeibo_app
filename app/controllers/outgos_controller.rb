class OutgosController < ApplicationController
  def new
    @text = ""
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
    @asset = current_user.salaries.sum(:price)
    @outgos.each do |outgo|
      @asset -= outgo.cost
    end
    @outgo_genres = Outgo.where('extract(year from start_time) = ? AND extract(month from start_time) = ?', Time.now.year, Time.now.month)
    if params[:that_day]
      @outgo_day = Outgo.where(start_time: params[:that_day])
      @outgo_genres = Outgo.where('extract(year from start_time) = ? AND extract(month from start_time) = ?', params[:that_day].to_date.year, params[:that_day].to_date.month)
    end
  end

  def ocr
    image = RTesseract.new("app/assets/images/test2.jpeg", lang: "jpn")
    @text = image.to_s
    @check = @text.chars
    @ans = []
    tmp = ""
    n_flag = false
    slash_flag = false
    @check.each do |check|
      if n_flag && check == "\n"
        tmp = ""
      elsif check == "\\"
        slash_flag = true
      elsif n_flag && slash_flag
        @ans << tmp
        tmp = ""
        n_flag = false
        slash_flag = false
      elsif check == "\n"
        n_flag = true
      elsif n_flag
        tmp += check
      end
    end
    @outgo = Outgo.new
    render :new
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

  def destroy
    @outgo = Outgo.find(params[:id])
    @outgo.destroy
    redirect_to outgos_path
  end

  private
  def outgo_params
    params.require(:outgo).permit(:content, :cost, :genre_id, :start_time)
  end
end
