class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  default_scope -> {order(name: :desc)}
  validates :name, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {maximum: 140}
end
