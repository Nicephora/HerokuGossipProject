class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    @gossips = Gossip.where(user: @city.users)
  end
end
