class Question < ActiveRecord::Base
  self.per_page = 1
  belongs_to :word
  belongs_to :lesson
  belongs_to :user
  belongs_to :answer

  scope :correct_anwsers, -> do
    joins(:answer).where("answers.is_correct = ?", true)
  end


end
