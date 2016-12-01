class Question < ActiveRecord::Base
  belongs_to :word
  belongs_to :lesson
  belongs_to :answer
  validates :word_id, presence: true
  validates :lesson_id, presence: true
  validates :answer_id, presence: true
end
