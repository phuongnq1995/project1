class Question < ActiveRecord::Base
  belongs_to :word
  belongs_to :lesson
  belongs_to :user
  belongs_to :answer

  scope :correct_anwsers, -> do
    joins(:answer).where("answers.is_correct = ?", true)
  end

  scope :answer_false, -> do
    joins(:answer).where("answers.is_correct = ?", false)
  end
end
