class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :question, only: [:create, :update, :destroy]
  before_action :vote, only: [:update, :destroy]

  def create
    # vote = Vote.new params[:vote][:is_up]
    vote = Vote.new vote_params
    vote.user = current_user
    vote.question = @question
    respond_to do |format|
      if vote.save
        format.html{ redirect_to question_path(@question) }
        format.js{
          render :refresh_vote#this renders /votes/create.js.erb
        }
      else
        format.html{ redirect_to question_path(@question), alert: "Cannot Vote" }
        format.js{
          render :refresh_vote
        }
      end
    end

  end

  def update
    vote.update vote_params
    respond_to do |format|
      format.html{redirect_to question_path @question, notice: 'Vote Updated'}
      format.js{
        render :refresh_vote
      }
    end
  end

  def destroy
    vote.destroy
    respond_to do |format|
      format.html {
        redirect_to question_path @question, notice: 'Unvoted'
      }
      format.js {
        render :refresh_vote
      }
    end
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
