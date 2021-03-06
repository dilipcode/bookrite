class AuthorshipsController < ApplicationController
  before_action :fetch_book
  before_action :fetch_authorship, only: [:update, :destroy]
  def create
    @new_authorship = @book.authorships.new
    authorize! :create, @new_authorship  
    invitee_email = params[:authorship][:invitee_email]
    if ValidateEmail.validate(invitee_email)
      @invitee = User.where(email: invitee_email).first
      if @invitee.nil?
        # flash.now[:danger] = I18n.t'flash_messages.authorships.non_existing_user'
        @invitee = User.invite!({:email => invitee_email}, current_user) do |usr|
          usr.invited_book = @book
        end
        @invitee.skip_authorship_invitation_email = true
        create_invitation
      elsif @invitee.contributing_to(@book)
        flash.now[:danger] = I18n.t'flash_messages.authorships.already_contributor'
      else 
        create_invitation 
      end
    else
      @invalid_email = true
    end
  end

  def update
    authorize! :update, @authorship
    @authorship.accept!
    flash[:success] = I18n.t('flash_messages.authorships.accepted')
    redirect_to root_path

  end

  def destroy    
    authorize! :destroy, @authorship
    @authorship.destroy
    flash[:success] = I18n.t('flash_messages.authorships.rejected')
    redirect_to root_path

  end


  private
      def fetch_book
        @book = Book.find(params[:book_id])
      end

      def fetch_authorship
        @authorship = @book.authorships.find(params[:id])
      end

      def create_invitation        
        @new_authorship.invitee = @invitee
        @new_authorship.invitor = current_user
        @new_authorship.save!
        flash.now[:success] = I18n.t'flash_messages.authorships.invite_success'
      end     

end
