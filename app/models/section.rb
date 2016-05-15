class Section < ActiveRecord::Base
  belongs_to :chapter
  belongs_to :book
  validates :title, presence: true
end
