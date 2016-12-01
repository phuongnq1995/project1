class Word < ActiveRecord::Base
  belongs_to :category
  default_scope -> {order(content: :desc)}
  validates :category_id, presence: true
  validates :is_correct, presence: true
  validates :content, presence: true, length: {maximum: 50}
end
