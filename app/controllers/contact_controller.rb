class ContactController < ApplicationController

  def new

  end

  def create
    @name = params[:name]
    @email = params[:email]
    @sub = params[:subject]
    @message = params[:message]
  end

end
