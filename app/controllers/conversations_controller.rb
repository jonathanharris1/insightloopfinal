class ConversationsController < ApplicationController

  def show
    @conversation = Conversation.find(params[:id])
  end

  def index
  conversations = Conversation
                    .includes(:classification)
                    .order(created_at: :desc)
                    .to_a

  grouped = conversations.group_by(&:classification_id)

  @conversations = []

  # enquanto ainda houver conversas em algum grupo
  while grouped.values.any?(&:any?)
    grouped.each_value do |list|
      @conversations << list.shift if list.any?
      end
    end
  end

  def edit
    @classification_id = Classification.all
  end

  def update

  end
end
