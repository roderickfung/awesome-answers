class WelcomeController < ApplicationController
  #by detault all action will render with
  #views/layouts/application.html.erb unless you specify something like
  #layout 'special'
  #by convention: the line above will use views/layouts/special.html.erb (aka name can be changed however we want)

  #this defines a controller 'action'
  def index

    #this will render 'index.html.erb'
    #index: this refers to the controller action
    #html: refers to the format
    #erb: refers to the templating system (erb is built-in)
  end

  def about

  end

end
