class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def dashboard
    @start_date =
      params[:start_date]&.to_date ||
      Conversation.minimum(:occurred_on)

    @end_date =
      params[:end_date]&.to_date ||
      Conversation.maximum(:occurred_on)

    scope = Conversation.where(occurred_on: @start_date..@end_date)

    @conversation_questions_count  = scope.count
    @conversation_complaints_count = scope.count
    @conversation_insights_count   = scope.count

    range_type = params[:range_type]

    # 🔵 Preset buttons active only when range_type == "preset"
    @active_preset =
      range_type == "preset" ? active_preset(@start_date, @end_date) : nil

    # 🔵 Aplicar button active only when range_type == "custom"
    @custom_range_active =
      range_type == "custom"
  end

  def home
  end

  private

  # 🔵 Determines which preset is currently applied
  def active_preset(start_date, end_date)
    today = Date.today

    return :last_7_days if end_date == today && start_date >= 7.days.ago.to_date
    return :last_month  if end_date == today && start_date >= 1.month.ago.to_date
    return :last_quarter if end_date == today && start_date >= 3.months.ago.to_date

    nil
  end
end
