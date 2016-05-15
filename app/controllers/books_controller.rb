class BooksController < ApplicationController
  # before_action :authenticate_user!, only: [:index]
  before_action :fetch_book, only: [:show, :destroy, :edit, :update]
  def index
    @new_book = current_user.owned_books.new
    @books = current_user.authoring_books
    @invitations = current_user.authorship_invitations
  end

  def new
    @book= current_user.owned_books.new
    authorize! :create, @book
  end

  def create
    @book = current_user.owned_books.new(book_params)
    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def show
    authorize! :read, @book
    # flash.now[:success] = "This is a flash message success"
    # flash.now[:danger] = "This is a flash message failure"
    # flash.now[:notice] = "This is a notice flash message"
    # flash.now[:error] = "This is a error flash message"
    @chapters = @book.chapters.includes(:sections).all
    @new_chapter = @chapters.new
    @new_sections = {}
    @chapters.each do |chapter|
      @new_sections[chapter.id] = chapter.sections.new
    end
    @new_authorship = @book.authorships.new
    
  end

  def edit
    authorize! :update, @book
  end

  def update
    authorize! :update, @book
    if @book.update_attributes(book_params)
      
      if params[:book][:sorted_chapter_ids]
        render nothing: true
      else
        flash[:success] = I18n.t 'flash_messages.books.updation_success'
        redirect_to book_path(@book)
      end
    else
      render :edit
    end
  end

  def destroy
    # unless @book.owner == current_user
    #   return deny_access!
    # end
    authorize! :destroy, @book
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
        @book =current_user.authoring_books.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title, :notes, :sorted_chapter_ids)
      end

end
