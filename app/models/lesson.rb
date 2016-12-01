class Lesson < ActiveRecord::Base
  belongs_to :user
  has_many :questions dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :result, presence: true, length: {maximum: 140}
end
