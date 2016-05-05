class Chapter < ActiveRecord::Base
  belongs_to :book
  has_many :sections
  default_scope {order(position: :asc)}
  validates :title, presence: true

  before_create :set_position

  private
      def set_position
        self.position = self.book.chapters[-2].position + 1        
      end
end
