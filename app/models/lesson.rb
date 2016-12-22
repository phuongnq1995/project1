class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :words, through: :questions
  has_many :answers, through: :questions
  accepts_nested_attributes_for :questions

  scope :uniq_by_category, ->{select "DISTINCT category_id"}
  default_scope -> {order(created_at: :desc)}
  validates :user, presence: true
  validates :category, presence: true

  before_create :lesson_questions



  private

  def lesson_questions
      self.category.words.random.each do |word|
          self.questions.build word_id: word.id, user_id: user_id
      end
  end



end
