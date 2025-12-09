class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :classification, optional: true

  after_create :generate_classification

  private

  def generate_classification
    # call ruby llm to tag
    tags = Classification.all.pluck(:tag).join(", ")

    ruby_llm_chat = RubyLLM.chat

    system_prompt = "You are a strict classifier of customer support conversations\n\nYour task: Read the conversation content.\n\nChoose ONLY ONE tag on the list below that best represents the MAIN issue of the conversation.\n\nAnswer the exactly one tag, with no extra words.\n\nAvalaible tags: #{tags}."
    ruby_llm_chat.with_instructions(system_prompt)

    response = ruby_llm_chat.ask(self.content)

    tag = response.content.to_s.strip
    classification = Classification.find_by(tag: tag)

    self.update(classification: classification) if classification.present?
  end
end
