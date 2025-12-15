class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :classification, optional: true
  belongs_to :category, optional: true

  before_validation :set_default_occurred_on, on: :create
  after_create :generate_classification_and_category

  private

  def set_default_occurred_on
    self.occurred_on ||= Date.current
  end

  def generate_classification_and_category
    return if self.content.blank?

    tags = Classification.pluck(:tag).join(", ")

    categories_prompt = Category.pluck(:name, :description)
                                .map { |name, description| "#{name}: #{description}" }
                                .join("\n")

    ruby_llm_chat = RubyLLM.chat

    system_prompt = <<~PROMPT
      You are a strict classifier of customer support conversations.

      Task:
      - Read the conversation content.
      - Choose ONLY ONE tag that represents the MAIN issue.
      - Choose ONLY ONE category that represents the TYPE of the conversation.

      Available tags:
      #{tags}

      Available categories (name: description):
      #{categories_prompt}

      Output JSON only (no extra text), exactly:
      {"tag":"<tag>","category":"<category>"}
    PROMPT

    ruby_llm_chat.with_instructions(system_prompt)

    raw = ruby_llm_chat.ask(self.content.to_s).content.to_s.strip

    data =
      begin
        JSON.parse(raw)
      rescue JSON::ParserError
        json = raw[/\{.*\}/m]
        json ? JSON.parse(json) : {}
      end

    tag_value      = data["tag"].to_s.strip
    category_value = data["category"].to_s.strip

    classification = Classification.find_by(tag: tag_value)
    category       = Category.find_by(name: category_value)

    update(classification: classification, category: category)
  end
end
