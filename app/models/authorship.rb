class Authorship < ActiveRecord::Base
  belongs_to :book
  belongs_to :invitee, class_name: User.name
  belongs_to :invitor, class_name: User.name

  attr_accessor :invitee_email, :skip_email_invitation

  after_create :send_authorship_invitation_email

  def accept!
    self.update_attribute(:accepted, true)
  end

  private

      def send_authorship_invitation_email 
        return if skip_email_invitation      
        AuthorshipMailer.invite(invitee,self).deliver_now
      end


end
