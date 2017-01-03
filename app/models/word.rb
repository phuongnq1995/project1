class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy

  has_many :questions
  scope :random, ->{order "RANDOM()"}
  has_many :lessons, through: :questions

  default_scope -> {order(content: :desc)}
  validates :content, presence: true, length: {maximum: 50}

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true
  validates :answers, length: {minimum: 2,
  maximum: 6}

  filter_byword_learned = "id in (select questions.word_id from lessons
    join questions on lessons.id = questions.lesson_id
    where lessons.user_id = ? and lessons.category_id
    in (?) and questions.word_id is not null)"

  filter_byword_unlearned = "id not in (select questions.word_id from lessons
    join questions on lessons.id = questions.lesson_id
    where lessons.user_id = ? and questions.word_id is not null)
    and category_id in (?)"

  filter_by_word_all = "id in (select id from words
    where words.category_id in (?))"

  scope :by_learned,-> (user_id, category_id) do
    where filter_byword_learned,user_id, category_id
  end

  scope :by_unlearned, ->(user_id, category_id) do
    where filter_byword_unlearned, user_id, category_id
  end

  scope :by_all, ->(user_id, category_id) do
    where filter_by_word_all, category_id
  end

  validate :just_one_answer_true

  def just_one_answer_true
    if self.answers.select {|answer| answer.is_correct == true}.size != 1
      errors.add(:base, 'Just one answer is true')
    end
  end

end
