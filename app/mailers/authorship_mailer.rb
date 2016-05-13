class AuthorshipMailer < ApplicationMailer
  def invite(user,authorship)
    @user = user
    @authorship = authorship
    @url  = root_url
    mail(to: @user.email, subject: 'CoAuthor a book')
  end
end
