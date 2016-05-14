class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :owned_books, class_name: Book.name, foreign_key: :owner_id
  has_many :authorships, -> { where(accepted: true) }, foreign_key: :invitee_id
  has_many :authorship_invitations, -> { where(accepted: false) },class_name: Authorship.name, foreign_key: :invitee_id
  has_many :authoring_books, through: :authorships, source: :book
  

  attr_accessor :invited_book
  def contributing_to(bk)
    Authorship.where(book: bk, invitee: self.id).any?
  end  
end
