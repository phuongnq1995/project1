class Answer < ActiveRecord::Base
  belongs_to :word
  has_many :questions
  has_many :lesson, through: :questions
  validates :content, presence: true, length: {maximum: 40}
  scope :random, ->{order "RANDOM()"}
end
