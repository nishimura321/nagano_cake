class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash.now[:notice] = "新規登録が完了しました。"
      @genres = Genre.all
      render :index
    else
      flash.now[:notice] = "新規登録に失敗しました。"
      render :index
    end
  end

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "変更を保存しました。"
      redirect_to admin_genres_path
    else
      flash.now[:notice] = "変更の保存に失敗しました。"
      render :edit
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to admin_genres_path
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end

end
