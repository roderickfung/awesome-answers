class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    question = Question.find params[:question_id]
    like = Like.new user: current_user, question: question
    if cannot? :like, question
      redirect_to question_path(question), alert: "Can't like your own question"
    else
      if like.save
        redirect_to question_path(question), notice: "liked"
      else
        redirect_to question_path(question), alert: "You Fucked Up"
      end
    end
  end

  def destroy
    question = Question.find params[:question_id]
    like = Like.find params[:id]
    if can? :destroy, like
      like.destroy
      redirect_to question_path(question), notice: "Unliked"
    else
      redirect_to root_path, alert: "access denied!"
    end
  end
end
