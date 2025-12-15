class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def dashboard
    # --------------------------------------------------
    # 1️⃣ Date range (single source of truth)
    # --------------------------------------------------
    @start_date =
      params[:start_date]&.to_date ||
      Conversation.minimum(:occurred_on)

    @end_date =
      params[:end_date]&.to_date ||
      Conversation.maximum(:occurred_on)

    base_scope = Conversation.where(occurred_on: @start_date..@end_date)

    # --------------------------------------------------
    # 2️⃣ KPIs (still work exactly as before)
    # --------------------------------------------------
    @conversation_questions_count  = base_scope.count
    @conversation_complaints_count = base_scope.count
    @conversation_insights_count   = base_scope.count

    # --------------------------------------------------
    # 3️⃣ Button state (UNCHANGED behavior)
    # --------------------------------------------------
    range_type = params[:range_type]

    @active_preset =
      range_type == "preset" ? active_preset(@start_date, @end_date) : nil

    @custom_range_active =
      range_type == "custom"

    # --------------------------------------------------
    # 4️⃣ Decide chart grouping based on time span
    # --------------------------------------------------
    range_days = (@end_date - @start_date).to_i

    if range_days <= 14
      sql_group = "DATE(occurred_on)"
      label_format = "%a"            # Mon, Tue…
    elsif range_days <= 90
      sql_group = "DATE_TRUNC('week', occurred_on)"
      label_format = "W%U"            # Week number
    else
      sql_group = "DATE_TRUNC('month', occurred_on)"
      label_format = "%b %Y"          # Jan 2025
    end

    # --------------------------------------------------
    # 5️⃣ Chart data (dynamic + grouped)
    # --------------------------------------------------
    @chart_series = Conversation
      .where(occurred_on: @start_date..@end_date)
      .group(Arel.sql(sql_group))
      .order(Arel.sql(sql_group))
      .count
      .map do |period, count|
        {
          label: period.to_date.strftime(label_format),
          value: count
        }
      end
  end

  def home
  end

  private

  # --------------------------------------------------
  # 6️⃣ Preset detection (unchanged)
  # --------------------------------------------------
  def active_preset(start_date, end_date)
    today = Date.today

    return :last_7_days if end_date == today && start_date >= 7.days.ago.to_date
    return :last_month  if end_date == today && start_date >= 1.month.ago.to_date
    return :last_quarter if end_date == today && start_date >= 3.months.ago.to_date

    nil
  end
  def product_insights
    @conversations = Conversation
      .order(occurred_on: :desc)
      render "pages/product_insights_index"
  end

  def product_insight
    @conversation = Conversation.find(params[:id])
     render "pages/product_insight_show"
  end

end
