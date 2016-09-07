class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :destroy, :update, :new]

  def create
    #we instantiate a new answer object based on the params we got from the user. we use: params.require(:answer).permit(:body) as it's required part of rails for security reason (strong parameters)

    #we fetch the question by its id which came from the URL. In the form in the question/show.html.erb we used a ur: question_answers_path(@question). This path includes a variable :question_id which comes as part of the params.

    #we associate the answer we defined above with the question we found above as well. This is because we need to associate the created answer with the question.

    @question = Question.find params[:question_id]
    @answer = Answer.new params.require(:answer).permit(:body)
    @answer.question = @question

    respond_to do |format|
      if @answer.save
        # THE LINE BELOW IS FOR EMAILING
        # AnswerMailer.notify_question_owner(@answer).deliver_later
        # @answer = Answer.create params.require(:answer).permit([:body,:question_id]).where(@question)
        format.html{
          redirect_to question_path(@question), notice: "Answer Created!"
        }
        format.js{
          render :create_success
        }
      else
        flash[:alert] = "Please fix errors"
        format.html{
          render '/questions/show'
        }
        format.js{
          render :create_failure
        }
      end
    end
  end

  def destroy
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:id]
    @answer.destroy
    respond_to do |format|
      format.html{
        redirect_to question_path(@question), notice: "Answer Destroyed"
      }
      format.js{
        render #it will automatically look for /app/views/answers/destroy.js.erb
      }
    end
  end

  private

  # def user_vote
  #   user_vote ||= @question.vote_for current_user
  # end
  # helper_method :user_vote

end
