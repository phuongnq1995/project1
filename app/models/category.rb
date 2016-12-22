class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy
  scope :newest, -> {order(name: :desc)}
  validates :name, presence: true, length: {maximum: 50},uniqueness: {case_sensitive: false}
  validates :discription, presence: true, length: {maximum: 140}

end
