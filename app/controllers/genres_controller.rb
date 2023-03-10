class GenresController < ApplicationController
  def create
    @genre = Genre.new(genre_params)
    @genre.user_id = current_user.id
    @genre.save
    redirect_to new_outgo_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to genres_path
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to new_outgo_path
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
