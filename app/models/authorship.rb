class Authorship < ActiveRecord::Base
  belongs_to :book
  belongs_to :invitee, class_name: User.name
  belongs_to :invitor, class_name: User.name

  attr_accessor :invitee_email
end
