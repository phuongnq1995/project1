class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :questions
  scope :random, ->{order "RANDOM()"}
  has_many :lessons, through: :questions
  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true
  default_scope -> {order(content: :desc)}
  validates :content, presence: true, length: {maximum: 50}

  scope :category, -> (category_id) { where category_id: category_id }
  scope :starts_with, -> (content) { where("content like ?", "#{content}%")}

  filter_by_word_all = "id in (select id from words
    where words.category_id in (?))"

  scope :by_all, ->(user_id, category_id) do
    where filter_by_word_all, category_id
  end

end
