class AuthorshipsController < ApplicationController
  before_action :fetch_book
  def create    
    invitee_email = params[:authorship][:invitee_email]
    if ValidateEmail.validate(invitee_email)
      @invitee = User.where(email: invitee_email).first
      if @invitee.nil?
        flash.now[:danger] = I18n.t'flash_messages.authorships.non_existing_user'
      elsif @invitee.contributing_to(@book)
        flash.now[:danger] = I18n.t'flash_messages.authorships.already_contributor'
      else        
        @book.authorships.create(invitee: @invitee, invitor: current_user)
        flash.now[:success] = I18n.t'flash_messages.authorships.invite_success'
      end
    else
      @invalid_email = true
    end
  end


  private
      def fetch_book
        @book = Book.find(params[:book_id])
      end
end
