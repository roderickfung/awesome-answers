class Answer < ApplicationRecord
  belongs_to :question
  #this line assumes tha tthe answers table has a field called question_id
  #this gives us a handy method to fetch the associated question with an answer:
  # a = Answer.last
  # q = a.question
  validates :body, presence: true, uniqueness: {scope: :question_id}
end
