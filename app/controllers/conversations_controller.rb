class ConversationsController < ApplicationController

  def show
    @conversation = Conversation.find(params[:id])
  end

  def index
    @conversations = Conversation.all
  end

  def edit
    @classification_id = Classification.all
  end

  def update

  end

end
