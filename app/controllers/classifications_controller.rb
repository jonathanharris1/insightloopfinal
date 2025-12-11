class ClassificationsController < ApplicationController

  def index
    @classifications = Classification.all
    @pareto = pareto_classifications
    # inserir aqui tags que foram elegidas pelo pareto -> montar gráfico de tendência
    pareto_tags = @pareto.map(&:tag)
    @trend_series = conversation_trends_for(pareto_tags)
  end

   def show
    @classification = Classification.find(params[:id])

    trend_hash = conversation_trends_for([@classification.tag])
    trend      = trend_hash[@classification.tag] || { labels: [], values: [] }

    @labels = trend[:labels]
    raw_values = trend[:values]
    @values = smooth_values(raw_values)

        if @values.present?
      (1...@values.size).each do |i|
        prev = @values[i - 1]
        curr = @values[i]

        if curr == 0 && prev > 0
          @values[i] = (prev * 0.7).round
        end
      end
    end


  bucket_definitions = {
    "Dia 1"  => (0..3),   # índices 0,1,2,3
    "Dia 5"  => (4..8),
    "Dia 10" => (9..13),
    "Dia 15" => (14..18),
    "Dia 20" => (19..23),
    "Dia 25" => (24..28),
    "Dia 30" => (29..29)
  }

  @volume_points = bucket_definitions.map do |label, range|
    {
      label: label,
      count: raw_values[range].compact.sum
    }
  end

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


  private

  def smooth_values(values)
    return values if values.blank?

    smoothed = values.dup

    (1...smoothed.size).each do |i|
      prev = smoothed[i - 1]
      curr = smoothed[i]

      if curr == 0 && prev > 0
        smoothed[i] = (prev * 0.7).round
      end
    end

    smoothed
  end

  def conversation_trends_for(tags, days: 30)
    return {} if tags.blank?

    start_date = (days - 1).days.ago.to_date
    end_date   = Date.current

    raw_counts = Conversation
      .joins(:classification)
      .where(classifications: { tag: tags })
      .where(occurred_on: start_date..end_date)
      .group("classifications.tag", "conversations.occurred_on")
      .order("classifications.tag", "conversations.occurred_on")
      .count

    trends = Hash.new { |h, k| h[k] = Hash.new(0) }

    raw_counts.each do |(tag, date), count|
      trends[tag][date] = count
    end

    trends.transform_values do |per_day_hash|
    all_dates = (start_date..end_date).to_a

    {
      labels: all_dates.each_with_index.map { |_, idx| "Dia #{idx + 1}" },
      values: all_dates.map { |d| per_day_hash[d] || 0 }
    }
    end
  end
end
