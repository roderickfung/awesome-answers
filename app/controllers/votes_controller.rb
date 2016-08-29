class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :question, only: [:create, :update, :destroy]
  before_action :vote, only: [:update, :destroy]

  def create
    # vote = Vote.new params[:vote][:is_up]
    vote = Vote.new vote_params
    vote.user = current_user
    vote.question = question
    if vote.save
      redirect_to question_path(@question)
    else
      redirect_to question_path(@question), alert: "Cannot Vote"
    end
  end

  def update
    vote.update vote_params
    redirect_to question_path @question, notice: 'Vote Updated'
  end

  def destroy
    vote.destroy
    redirect_to question_path @question, notice: 'Unvoted'
  end

  private

  def question
    @question ||= Question.find params[:question_id]
  end

  def vote
    @vote ||= Vote.find params[:id]
  end

  def vote_params
    vote_params = params.require(:vote).permit(:is_up)
  end
end
