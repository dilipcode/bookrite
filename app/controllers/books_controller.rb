class BooksController < ApplicationController
  before_action :fetch_book, only: [:show, :destroy, :edit, :update]
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
    # flash.now[:success] = "This is a flash message success"
    # flash.now[:danger] = "This is a flash message failure"
    # flash.now[:notice] = "This is a notice flash message"
    # flash.now[:error] = "This is a error flash message"
    @chapters = @book.chapters.all
    @new_chapter = @chapters.new


  end
  def edit

  end

  def update
    if @book.update_attributes(book_params)
      flash[:success] = I18n.t 'flash_messages.books.updation_success'
      redirect_to books_path
    else
      render :edit
    end
  end

  def destroy
    if params[:title_confirm].downcase == @book.title.downcase
      @book.destroy
      flash[:success] = I18n.t'flash_messages.books.deletion_success'
      redirect_to books_path
           
    else
      flash[:error] = I18n.t 'flash_messages.books.deletion_error'
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
