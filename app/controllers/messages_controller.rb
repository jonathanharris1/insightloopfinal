class MessagesController < ApplicationController

  SYSTEM_PROMPT = "You are a Teaching Assistant.\n\nI am a student at the Le Wagon AI Software Development Bootcamp, learning how to code.\n\nHelp me break down my problem into small, actionable steps, without giving away solutions.\n\nAnswer concisely in Markdown."

  def create
    @chat = current_user.chats.find(params[:chat_id])


    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
    ruby_llm_chat = RubyLLM.chat
    response = ruby_llm_chat.with_instructions(instructions).ask(@message.content)
    Message.create(role: "assistant", content: response.content, chat: @chat)

    redirect_to chat_path(@chat)

    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

   def categories_count
    Conversation
      .joins(:category)
      .group("categories.name")
      .count
   end

   def classifications_count
    Conversation
    .joins(:classification)
    .group("classifications.tag")
    .count
   end

   def generate_root_cause(conversations)
    texto = conversations.map { |c| c.content }.join("\n")
    prompt = <<~PROMPT
     Você é um analista sênior especializado em diagnóstico de causa raiz.
    Analise as conversas abaixo e gere um diagnóstico extremamente curto, direto e técnico.

    O resultado deve ter:
    • no máximo 2 frases
    • foco total na causa raiz
    • linguagem objetiva, sem floreios
    • mencionar de forma clara o mecanismo do erro (ex: falha de processo, atraso logístico, erro de sistema, política  inadequada, comunicação incorreta etc.)

    NÃO retorne lista, bullet points ou textos longos.
    NÃO explique o que está fazendo.

    Exemplo do estilo desejado:
    "Usuários com Android 14 estão enfrentando freeze no pagamento via PIX devido a incompatibilidade entre o WebView   atualizado e a biblioteca de pagamentos atual."

    Agora gere UM diagnóstico nesse mesmo estilo:

    Conversas analisadas:
    #{texto}
    PROMPT

    llm = RubyLLM.chat
    resposta = llm.ask(prompt)

    resposta.content
  end

  def instructions
    [SYSTEM_PROMPT, classifications_count, categories_count].compact.join("\n\n")
  end
end
