class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :questions
  scope :random, ->{order "RANDOM()"}
  has_many :lessons, through: :questions
  accepts_nested_attributes_for :answers, :allow_destroy => true
  default_scope -> {order(content: :desc)}
  validates :content, presence: true, length: {maximum: 50}


end
