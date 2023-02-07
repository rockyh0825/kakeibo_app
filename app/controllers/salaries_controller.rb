class SalariesController < ApplicationController
  def index
    @salary = Salary.new
    d = Date.today
    @year = d.year.to_s
    @asset = 1030000 - current_user.salaries.where("day BETWEEN ? AND ?", (d.year.to_s + "-01-01").to_date, (d.year.to_s + "-12-31").to_date).sum(:price)
    if params[:search]
      @year = params[:search].to_s
      @salaries = current_user.salaries.where("day BETWEEN ? AND ?", (params[:search].to_s + "-01-01").to_date, (params[:search].to_s + "-12-31").to_date)
      @salaries_order = @salaries.order(:day)
    else  
      @salaries = current_user.salaries.where("day BETWEEN ? AND ?", (d.year.to_s + "-01-01").to_date, (d.year.to_s + "-12-31").to_date)
      @salaries_order = @salaries.order(:day)
    end
  end

  def create
    @salary = Salary.new(salary_params)
    @salary.user_id = current_user.id
    @salary.day = (params[:salary][:year].to_s + "-" + params[:salary][:month].to_s + "-01").to_date
    if @salary.save
      redirect_to salaries_path
    else
      @salaries = current_user.salaries
      render :index
    end
  end

  def update
    @salary = Salary.find(params[:id])
    @salary.update(salary_params)
    redirect_to salaries_path
  end

  def destroy
    @salary = Salary.find(params[:id])
    @salary.destroy
    redirect_to salaries_path
  end

  private
  def salary_params
    params.require(:salary).permit(:price, :day)
  end
end
