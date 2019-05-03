class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :show]
  before_action :check_user, only: [:destroy, :edit, :update]

  def new
    @gossip = Gossip.new
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comments = Comment.where(gossip: @gossip)
  end

  def index
    @gossip_array = Gossip.all
  end

  def create
    @gossip = Gossip.new(content: params[:content], title: params[:title], user: current_user)
    if @gossip.save # essaie de sauvegarder en base @gossip
      flash[:success] = "Ton gossip a été ajouté !"
      redirect_to gossips_path
    else
      flash[:danger] = "Ton gossip n'est pas valide !"
      render new_gossip_path
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])

    if @gossip.update(gossip_params)
      flash[:success] = "Ton gossip a été modifié !"
      redirect_to @gossip
    else
      flash[:danger] = "Ton gossip n'est pas valide !"
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to gossips_path
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end

  def check_user
    unless current_user == Gossip.find(params[:id]).user
      flash[:danger] = "Vous n'êtes pas l'auteur de ce potin"
      redirect_to gossip_path(params[:id])
    end
  end
end
