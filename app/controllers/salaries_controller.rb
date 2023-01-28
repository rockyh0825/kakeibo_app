class SalariesController < ApplicationController
  def index
    @salary = Salary.new
    @salaries = current_user.salaries
  end

  def create
    @salary = Salary.new(salary_params)
    @salary.user_id = current_user.id
    params[:year].class
    @salary.day = (params[:year].to_s + "-" + params[:month].to_s + "-01").to_date
    if @salary.save
      redirect_to salaries_path
    else
      @salaries = current_user.salaries
      render :index
    end
  end

  def edit
  end

  def show
  end

  private
  def salary_params
    params.require(:salary).permit(:price, :day)
  end
end
