class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :edit]
  before_action :check_user, only: [:update, :edit, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(content: params[:content], user: current_user, gossip_id: params[:gossip_id])
    if @comment.save
      flash[:success] = "Ton commentaire a été ajouté !"
      redirect_to gossip_path(@comment.gossip.id)
    else
      flash[:danger] = "Ton commentaire n'est pas valide !"
      render :new
    end
  end

  def show
  end

  def edit
    @comment = Comment.find(params[:gossip_id])
  end

  def update
    @comment = Comment.find(params[:gossip_id])
    gossip_params = params.require(:comment).permit(:content)

    if @comment.update(gossip_params)
      flash[:success] = "Ton commentaire a été modifié !"
      redirect_to gossip_path(@comment.gossip.id)
    else
      flash[:danger] = "Ton commentaire n'est pas valide !"
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:gossip_id])
    @comment.destroy
    redirect_to gossip_path(@comment.gossip.id)
  end

  private

  def check_user
    unless current_user == Comment.find(params[:gossip_id]).user
      flash[:danger] = "Vous n'êtes pas l'auteur de ce commmentaire"
      redirect_to gossip_path(params[:id])
    end
  end

  def authenticate_user
    unless current_user
      flash[:danger] = "Veuillez tout d'abord vous connecter"
      redirect_to new_session_path
    end
  end
end
