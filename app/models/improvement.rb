class Improvement < ApplicationRecord
  belongs_to :user
  belongs_to :classification


IMPROVEMENT_PROMPT = <<~PROMPT
As conversas abaixo são do mesmo problema.

Gere apenas títulos curtos (máx. 10 palavras) para ações de melhoria.
Não explique nada. Não escreva frases longas. Apenas títulos.

Formato obrigatório:

Curto Prazo:
- <título>
- <título>

Médio Prazo:
- <título>
- <título>

Longo Prazo:
- <título>
- <título>
PROMPT

end
