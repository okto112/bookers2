class BooksController < ApplicationController
  def index
    @books = Book.all
    @user = User.find(current_user.id)
    @new = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      @new = @book
      render :index
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully deleted."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    user = User.find(book.user_id)
    unless user.id == current_user.id
      redirect_to users_path
    end
  end

end
