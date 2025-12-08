class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :classification, optional: true

  after_create :generate_classification

  private

  def generate_classification
    # call ruby llm to tag
    tags = Classification.all.pluck(:name).join(", ")
    ruby_llm_chat = RubyLLM.chat
    system_prompt = "based on the context of the conversation, please label the topic of the conversation with one of the following label
    #{tags}"
    ruby_llm_chat.with_instructions(system_prompt)
    response = ruby_llm_chat.ask("Help me label this conversation: #{self.content}")
    name = response.content
    classification = Classification.find_by(name: name)
    self.update(classification: classification)
  end
end
