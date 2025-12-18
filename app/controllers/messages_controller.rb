class MessagesController < ApplicationController

  SYSTEM_PROMPT = <<~PROMPT
   Você é um Analista Sênior de Produto e Customer Support integrado a um sistema de análise de atendimentos.

    Seu papel é ajudar o usuário a entender:
    - o que está acontecendo no atendimento ao cliente,
    - quais são os principais problemas,
    - onde está a maior concentração de impacto,
    - e onde focar esforços.

    REGRAS OBRIGATÓRIAS:
    - Baseie TODAS as respostas exclusivamente nos dados fornecidos no contexto.
    - NÃO invente números, causas ou conclusões.
    - NÃO faça suposições além do que os dados permitem.
    - Se não houver dados suficientes para responder, diga claramente que a informação não está disponível.
    - Use apenas as partes do contexto que forem relevantes para a pergunta do usuário.
    - Ignore dados que não tenham relação com a pergunta.

    FORMATO E TOM:
    - Responda sempre em português.
    - Seja objetivo, direto e profissional.
    - Priorize análises, padrões e priorização.
    - Evite explicações longas ou genéricas.
    - Use Markdown quando fizer sentido.

    COMPORTAMENTO ESPERADO:
    - Se a pergunta for sobre resumo, período ou visão geral, apresente uma síntese clara dos principais pontos.
    - Se a pergunta envolver prioridade, foco ou impacto, utilize a análise Pareto (80/20) quando disponível.
    - Se a pergunta for sobre causa raiz, responda de forma curta e técnica.
    - Se a pergunta for sobre ações ou melhorias, organize a resposta em curto, médio e longo prazo.

    PROMPT

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

# Testing pareto_classifications
def pareto
  rows = Conversation
    .joins(:classification)
    .select(
      "classifications.tag AS tag,
      COUNT(*) AS count,
      ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER ()
      ) AS pct,
      ROUND(
        100.0 * SUM(COUNT(*)) OVER (
          ORDER BY COUNT(*) DESC, classifications.tag ASC
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )
        / SUM(COUNT(*)) OVER ()
      ) AS cum_pct,
      ROUND(
        100.0 * SUM(COUNT(*)) OVER (
          ORDER BY COUNT(*) DESC, classifications.tag ASC
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )
        / SUM(COUNT(*)) OVER (),
      2
      ) AS cum_pct_2"
    )
    .group("classifications.tag")
    .order("count DESC, classifications.tag ASC")

  # Keep only classifications contributing to the first 80%
  rows.select { |r| r.cum_pct_2.to_f <= 80.00 }
end

# Testing pareto_classifications

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

  def classification_and_improvements_dados
    Classification
    .joins(:improvements)
    .pluck("classifications.tag", "improvements.content")
    .to_h
    .to_json
  end

  def classification_and_improvements_dados_and_context
    "Segue um JSON com títulos curtos para ações de melhoria de curto prazo, médio prazo e longo prazo pra cada CLASSIFICATION (problema raiz encontrado):
    ```
    #{classification_and_improvements_dados}
    ```
    "
  end

  def pareto_json
    pareto.map do |item|
      {tag: item.tag, percentage: item.pct.to_i}
    end
  end


  def pareto_and_context
    "Segue um JSON com uma lista de CLASSIFICATION chaves e percentuais de ocorrência:
    ```
    #{pareto_json.to_json}
    ```
    "
  end

  def instructions
    [SYSTEM_PROMPT, classifications_count, categories_count, classification_and_improvements_dados_and_context, pareto_and_context].compact.join("\n\n")
  end
end
