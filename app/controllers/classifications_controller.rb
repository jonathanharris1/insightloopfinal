class ClassificationsController < ApplicationController

  def index
    @classifications = Classification.all
    @pareto = pareto_classifications
  end

  def show
    @classification = Classification.find(params[:id])
    @conversations = @classification.conversations.order("RANDOM()")


  if @classification.improvements.empty?
    llm = RubyLLM.chat

    response = llm
      .with_instructions(Improvement::IMPROVEMENT_PROMPT)
      .ask(@classification.full_text_of_conversations)

    @improvement = Improvement.create!(
      user: current_user,
      classification: @classification,
      content: response.content
    )
  else
    @improvement = @classification.improvements.last
  end
end

  private

  def pareto_classifications
    rows = Conversation
      .joins(:classification)
      .select(
        "classifications.tag AS tag,
        COUNT(*) AS count,
        ROUND(
          100 * COUNT(*) / SUM(COUNT(*)) OVER ()
        ) AS pct,
        ROUND(
          100 * SUM(COUNT(*)) OVER (ORDER BY COUNT(*) DESC)
          / SUM(COUNT(*)) OVER ()
        ) AS cum_pct"
      )
      .group("classifications.tag")
      .order("count DESC")

    # Keep only classifications contributing to the first 80% of conversations
    rows.select { |r| r.cum_pct <= 80 }
  end

end
