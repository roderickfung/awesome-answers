class AnswerMailer < ApplicationMailer

  def notify_question_owner(answer)
    @question_owner = answer.question.user
    @question = answer.question
    @answer = answer
    if @question_owner
      mail(to: @question_owner.email, subject: "You received a new answer to your question")
    end
  end
end
