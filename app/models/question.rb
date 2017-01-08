class Question < ActiveRecord::Base
  belongs_to :word
  belongs_to :lesson
  belongs_to :user
  belongs_to :answer

  scope :correct_anwsers, -> do
    joins(:answer).where("answers.is_correct = ?", true)
  end
  scope :fail_answers, -> do
    joins(:answer).where("answers.is_correct = ?", false)
  end
  scope :null_answers, -> {where(answer: nil)}
end
