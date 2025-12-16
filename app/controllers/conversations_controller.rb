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

  def insight_list

    @conversations = Conversation.order(occurred_on: :desc)
    @customer_names = [
      "Maria Silva", "Carlos Mendes", "João Santos",
      "Ana Costa", "Aline K.", "Diego Z.",
      "Eduardo N.", "Thiago B."
    ]

  end

   def insight
    @conversation = Conversation.find(params[:id])
  end

end
