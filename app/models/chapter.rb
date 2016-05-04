class Chapter < ActiveRecord::Base
  belongs_to :book
  has_many :sections
  validates :title, presence: true
end
