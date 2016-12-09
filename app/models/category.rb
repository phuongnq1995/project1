class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  default_scope -> {order(name: :desc)}
  validates :name, presence: true, length: {maximum: 50},uniqueness: {case_sensitive: false}
  validates :discription, presence: true, length: {maximum: 140}
  def feed
    Word.where("category_id = ?", id)
  end
end
