class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def dashboard
  end

  def home
  end

  def product_insights
    @conversations = Conversation
      .order(occurred_on: :desc)
  end

  def product_insight
    @conversation = Conversation.find(params[:id])
  end

end
