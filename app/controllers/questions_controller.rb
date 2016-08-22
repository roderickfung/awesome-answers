class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :destroy, :update, :new]
  before_action :authorize, only: [:destriy, :update, :edit]

  def new
    #we are instantiating a new question object as it will help us build a form to create a question easily.
    @question = Question.new
    #when defining a method below is implied
    #render.new
    #render questions/new
  end

  def create
    #strong parameters feature of Rails to only let mass-assigning attributes that users are allowed to set.
    # questions_params = params.require(:question).permit([:title,:body])
    @question = Question.create params.require(:question).permit([:title,:body])
    @question.user = current_user
    # question.save ? render (json: params) : (render :new)
    if @question.save
      # render :show
      # redirect_to question_path({id: @question.id}) <- complicated way
      # redirect_to question_path ({id: @question})
      # redirect_to question_path(@question)
      redirect_to @question
    else
      render :new
    end
  end

  def show
    @question = Question.find params[:id]
    @answers = @question.answers
    @answer = Answer.new
  end

  def index
    @limit = 10
    @offset = 0
    @questions = Question.order(created_at: :desc)
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
    if @question.update params.require(:question).permit([:title,:body])
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    question = Question.find params[:id]
    question.destroy
    redirect_to questions_path
  end

  def authorize
    redirect_to root_path, alert: "access denied" unless can? :manage, @question
  end

  def find_question
    @question = Question.find params[:id]
  end

end
