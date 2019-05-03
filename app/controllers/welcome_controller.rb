class WelcomeController < ApplicationController
  def message

    @first_name = params[:first_name]

  end
end
