class Improvement < ApplicationRecord
  belongs_to :user
  belongs_to :classification

  validates :content, presence: true

   IMPROVEMENT_PROMPT =  <<~PROMPT
   Receber várias conversas de suporte ao cliente, todas relacionadas com o MESMO tipo de problema.

  Analisa o conjunto completo das conversas.

  O teu objectivo é gerar um plano de melhorias estratégico para a empresa, com três níveis de acção:

  1. Curto Prazo: acções imediatas para resolver os problemas actuais dos clientes.
  2. Médio Prazo: melhorias de processo para evitar que estes problemas voltem a acontecer.
  3. Longo Prazo: melhorias estruturais, tecnológicas ou estratégicas para reduzir este tipo de falha no futuro.

  Considera padrões, repetições e causas prováveis.

  Sê claro, objectivo e realista.

  Responde exactamente neste formato:

  Curto Prazo:
  <uma frase>

  Médio Prazo:
  <uma frase>

  Longo Prazo:
  <uma frase>
PROMPT
end
