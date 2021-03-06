class Chapter < ActiveRecord::Base
  belongs_to :book
  has_many :sections, dependent: :destroy
  default_scope {order(position: :asc)}
  validates :title, presence: true

  before_create :set_position

  private
      def set_position
        self.position = (self.book.chapters[-2].try(:position) || 0) + 1        
      end
end
