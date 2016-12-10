class Answer < ActiveRecord::Base
  belongs_to :word
  validates :content, presence: true, length: {maximum: 40}
end
