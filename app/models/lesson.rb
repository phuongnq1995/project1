class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :words, through: :questions
  has_many :answers, through: :questions
  accepts_nested_attributes_for :questions

  default_scope -> {order(created_at: :desc)}
  validates :user, presence: true
  validates :category, presence: true

  before_create :delete_answer_false
  before_create :lesson_questions

  def lesson_questions
      self.category.words.by_unlearned(self.user_id, self.category_id).
        random.each do |word|
          self.questions.build word_id: word.id, user_id: user_id
      end
  end
  def delete_answer_false
    Question.answer_false.delete_all
  end
end
