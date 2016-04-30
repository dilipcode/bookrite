class BooksController < ApplicationController
  before_action :fetch_book, only: [:show, :destroy]
  def index
    @books = Book.all    
  end

  def new
    @book= Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def show
    flash.now[:success] = "This is a flash message success"
    flash.now[:danger] = "This is a flash message failure"
    flash.now[:notice] = "This is a notice flash message"
    flash.now[:error] = "This is a error flash message"

  end

  def destroy
    if params[:title_confirm].downcase == @book.title.downcase
      @book.destroy
      redirect_to books_path, success: "Book #{@book.title} successfuly deleted"
    else
      redirect_to book_path(@book)
    end

  end


  private
      def fetch_book
        @book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title,:notes)
      end

end
