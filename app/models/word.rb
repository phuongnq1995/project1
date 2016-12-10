class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, :allow_destroy => true
  default_scope -> {order(content: :desc)}
  validates :category_id, presence: true
  validates :content, presence: true, length: {maximum: 50}

end
