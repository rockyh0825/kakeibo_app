class FoodstuffsController < ApplicationController
  def index
    @foodstuffs = Foodstuff.order(:created_at)
    @foodstuff = Foodstuff.new
  end

  def recognize
    image = params[:foodstuff][:image]
    File.binwrite("public/#{Date.today.to_s}.jpeg", image.read)
    image_test = RTesseract.new("public/#{Date.today.to_s}.jpeg", lang: "jpn")
    text = image_test.to_s
    check = text.chars
    @ans = []
    tmp = ""
    n_flag = false
    slash_flag = false
    check.each do |check|
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
      elsif n_flag && check != " "
        tmp += check
      end
    end
  end

  def confirm
    stuffs_old = JSON.parse(params[:foodstuff][:stuffs])
    if params[:commit] == "追加"
      stuff = current_user.foodstuffs.new(foodstuff_params)
      stuff.save
    end

    if stuffs_old.length == 0
      redirect_to foodstuffs_path
    else
      @stuff = Foodstuff.new
      @stuff.name = stuffs_old.first
      @stuffs_new = stuffs_old[1..]
    end
  end

  def create
    foodstuff = Foodstuff.new(foodstuff_params)
    foodstuff.user_id = current_user.id
    foodstuff.save
    redirect_to foodstuffs_path
  end

  def update
    foodstuff = Foodstuff.find(params[:id])
    foodstuff.update(foodstuff_params)
    redirect_to foodstuffs_path
  end

  def destroy
    foodstuff = Foodstuff.find(params[:id])
    foodstuff.destroy
    redirect_to foodstuffs_path
  end

  private
  def foodstuff_params
    params.require(:foodstuff).permit(:name, :amount)
  end
end
