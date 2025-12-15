Improvement.destroy_all
Conversation.destroy_all
Classification.destroy_all
Category.destroy_all
User.destroy_all


user = User.create!(email: "saunier2@gmail.com", password: "123456")

atraso_entrega = Classification.create!(
  tag: "Atraso na Entrega",
  tag_description: "Use esta tag somente quando o foco principal do cliente for o atraso — ou seja, quando ele reclama que o pedido não chegou no prazo, está demorando mais que o esperado, vai perder uma viagem/evento, ou se mostra irritado porque a entrega está demorada, travada, sem previsão. Mesmo que o cliente mencione rastreio parado, se a reclamação central for sobre o atraso, esta é a tag correta. Exemplos: 'meu pedido está parado' 'já era pra ter chegado' 'dias de atraso'"
)

pedido_errado = Classification.create!(
  tag: "Pedido Errado",
  tag_description: "Use esta tag quando o cliente recebeu um item diferente do que pediu — seja modelo, cor, tamanho ou produto completamente errado."
)

produto_danificado = Classification.create!(
  tag: "Produto Danificado",
  tag_description: "Use esta tag quando o cliente recebe um produto com defeito, risco, dano, falha na qualidade ou avaria durante o transporte."
)

erro_cupom = Classification.create!(
  tag: "Erro no Cupom",
  tag_description: "Use esta tag quando o cupom não aplica, aparece como inválido, não funciona para os itens ou gera mensagens de erro."
)

rastreamento = Classification.create!(
  tag: "Rastreamento",
  tag_description: "Use esta tag somente quando o foco principal do cliente solicitar o código de rastreio, link ou atualização de tracking, mas sem enfatizar atraso e sem manifestar urgência sobre prazo. Se a queixa central for “vai atrasar / já atrasou / estou preocupada com o prazo” → NÃO é Rastreamento, é Atraso na Entrega."
)

duvida_produto = Classification.create!(
  tag: "Dúvida de Produto",
  tag_description: "Use esta tag quando o cliente faz perguntas sobre tamanho, forma, características, uso, material ou detalhes técnicos do produto."
)

solicitacao_nf = Classification.create!(
  tag: "Solicitação de NF",
  tag_description: "Use esta tag quando o cliente pede nota fiscal, segunda via, correção ou informações sobre emissão da NF."
)

outros = Classification.create!(
  tag: "Outros",
  tag_description: "Use esta tag quando a conversa não representar um problema ou solicitação clara, mas sim feedbacks, sugestões, elogios, comentários gerais ou mensagens que não se encaixam nas demais classificações/tags."
)

Category.create!(
  name: "questions",
  description: "Utilize esta categoria quando o foco principal do cliente é perguntar, tirar dúvidas sobre algo, solicitando informações, apoio, ou um FAQ-style help. Nenhum incidente relevante, trata-se apenas de dúvidas e instruções sendo solicitadas."
)

Category.create!(
  name: "complaints",
  description: "Utilize esta categoria quando o foco principal do cliente é reportar um problema com insatisfação ou fricção: atrasos, pedido errado, pedido danificado, problemas com cobrança, utilizando um tom irritado/frustrado, ou qualquer incidente que necessite de uma resolução ativa."
)

Category.create!(
  name: "product_insights",
  description: "Utilize esta categoria quando o foco principal do cliente é sugerir melhorias no produto ou site, feedbacks, ideias de UX, ou solicitações como 'adicionem dark mode', 'gostaria que isto tivesse..'. Esta categoria não é um incidente, dúvida ou reclamação. "
)

# Intervalo de datas para simular os "últimos 30 dias"
start_date = 30.days.ago.to_date  # Dia 1
end_date   = Date.today           # Dia 30

def random_date(start_date, end_date)
  rand(start_date..end_date)
end

  conversas = <<~CHAT
    [Customer]: Olá, bom dia. Preciso falar com um atendente urgente. O robô não tá entendendo meu problema.
    [Support Agent]: Olá! Aqui é a Beatriz da Beautiful Feet. Sinto muito que esteja com dificuldades. Pode me contar o que houve? Estou aqui para resolver.
    [Customer]: Oi Beatriz. Olha, eu tô bem chateada. Fiz uma compra semana passada, o pedido BF-88209. Eram pra ser aquelas sandálias "Royal Velvet" pretas, tamanho 37. A caixa chegou agora pouco.
    [Customer]: Quando eu abri, não tem sandália nenhuma. Vocês me mandaram um tênis "Comfy Walk" branco tamanho 39!!! Nada a ver com nada. Eu tenho um casamento no sábado, como vou usar um tênis 39??
    [Support Agent]: Nossa, entendo perfeitamente sua frustração e peço mil desculpas por isso! :pensive: Realmente não é a experiência que queremos que você tenha na Beautiful Feet, ainda mais com um casamento chegando. Vou verificar o pedido BF-88209 agora mesmo. Só um instante.
    [Customer]: Por favor, vê isso rápido. Eu não tenho tempo de ir no correio devolver e esperar chegar outro. Se não chegar até sexta eu vou ter que cancelar e comprar em loja física.
    [Support Agent]: Já localizei aqui. Realmente consta a saída da Sandália Royal Velvet 37. Houve um erro grave na nossa expedição na hora de etiquetar as caixas. Sinto muito mesmo. Para eu agilizar a troca expressa, você consegue me mandar uma foto da etiqueta da caixa e do tênis que chegou?
    [Customer]: Tá, espera aí. [Customer sends image: photo of a bulky white sneaker inside a delicate box]. Tá vendo? Olha a etiqueta, diz "Destinatário: Carla" mas dentro tá esse tênis gigante.
    [Support Agent]: Obrigada pela foto, Carla. Já registrei o erro aqui. Normalmente, nosso processo pede que o cliente devolva o errado antes de enviarmos o certo, mas dada a urgência do seu evento no sábado, eu vou abrir uma exceção de "Envio Prioritário".
    [Support Agent]: Vou despachar um novo par da Royal Velvet 37 ainda hoje via Sedex 10. Assim garantimos que chega até quinta ou sexta no máximo. Pode ser?
    [Customer]: Ai, sério? Se chegar até sexta me salva. Mas e esse tênis aqui? Eu não tenho como ir no correio hoje, tô no trabalho.
    [Support Agent]: Não se preocupe com o tênis agora. O foco é garantir seu sapato para o casamento! :raised_hands: Vou te mandar um código de postagem reverso no e-mail, e você tem até 15 dias para deixar no Correios quando ficar mais tranquilo para você.
    [Customer]: Menos mal. Tá bom então, Beatriz. Vou ficar de olho no rastreio. Se não chegar na sexta de manhã eu volto a chamar aqui.
    [Support Agent]: Combinado! O novo código de rastreio vai chegar no seu e-mail em até 2 horas. Qualquer coisa, é só me chamar. Desculpe novamente pelo susto e espero que arrase no casamento com a Beautiful Feet!
CHAT

Conversation.create!(channel: "Whatsapp", content: conversas, user: user, occurred_on: random_date(start_date, end_date))

conversas_2 = <<~CHAT2
  [Customer]: Olá, boa tarde. Recebi meu pedido #BF59321 hoje cedo, o tênis Urban Flex Branco – tamanho 39, mas ele veio com um risco enorme na lateral :confused: Isso não é normal, né?
  [Support Agent]: Boa tarde! Poxa, sinto muito por isso :pensive: Claro que não é normal. Você pode me enviar uma foto do dano para que eu consiga te ajudar melhor?
  [Customer]: Mandei agora. Repara na lateral direita… parece até que arrastaram na caixa.
  [Support Agent]: Obrigado pela foto! Realmente, o risco é bem visível. Vou verificar aqui no sistema se houve alguma ocorrência registrada durante o transporte.
  [Customer]: É, fiquei bem chateada… comprei pra usar no fim de semana. :weary:
  [Support Agent]: Entendo totalmente sua frustração, e peço desculpas por isso :pray: Verifiquei aqui e a transportadora marcou uma observação de “caixa amassada” na etapa de transferência do dia 30/11. Tudo indica que o item foi danificado no transporte.
  [Customer]: Nossa… então não foi nem verificado antes de enviar?
  [Support Agent]: Infelizmente, o dano provavelmente aconteceu depois da expedição, durante o trajeto. Mas isso não é culpa sua — vamos resolver. Posso abrir agora uma troca imediata, sem custo, e o novo par será enviado assim que o danificado for coletado.
  [Customer]: E essa coleta demora muito?
  [Support Agent]: Normalmente é bem rápida. Posso agendar para amanhã, entre 8h e 18h. Funciona pra você?
  [Customer]: Sim, funciona. Só quero receber um par em boas condições mesmo.
  [Support Agent]: Perfeito! Solicitação aberta: #R-99341. A coleta será amanhã, e assim que o transportador confirmar, enviamos um novo Urban Flex Branco – 39 pra você.
  [Customer]: Obrigado pela agilidade. Tomara que o próximo venha certinho.
  [Support Agent]: Pode deixar, vou acompanhar pessoalmente para garantir que saia tudo certo :blush: Qualquer coisa, é só chamar!
CHAT2

Conversation.create!(channel: "Instagram", content: conversas_2, user: user, occurred_on: random_date(start_date, end_date))

conversas_3 = <<~CHAT3
  [Customer]: Oi, boa tarde. Tô tentando fechar uma compra aqui no site de vocês mas tá difícil. O cupom de primeira compra não tá entrando de jeito nenhum.
  [Support Agent]: Olá! Boa tarde. Aqui é a Sofia, da equipe de Customer Success da Beautiful Feet :high_heel:. Sinto muito por esse inconveniente, nós adoramos dar descontos e queremos que você os use! Me conta, qual é o código que você está tentando aplicar e qual mensagem de erro aparece?
  [Customer]: O código é o BEMVINDA10. Eu recebi no meu email agorinha. Eu coloquei no carrinho a bota "Urban Leather" preta tamanho 36 e um scarpin nude básico. Quando clico em aplicar, aparece uma letra vermelha dizendo "Cupom não aplicável a estes itens".
  [Customer]: Já tentei tirar o scarpin, deixar só a bota, tentei escrever em minúsculo, e nada. Tô quase desistindo, só ia fechar por causa do desconto que paga o frete.
  [Support Agent]: Entendi, obrigada pelos detalhes! Não desista ainda, vamos resolver isso. Vou verificar as regras desse cupom no sistema agora mesmo. Você poderia me confirmar se essa bota "Urban Leather" que você escolheu é a que tem a fivela dourada, da coleção nova de Inverno?
  [Customer]: Sim, essa mesma da fivela. Mas gente, no email que vocês mandaram tava escrito bem grande "10% OFF em TODO o site". Eu não vi nada de exceção.
  [Support Agent]: Obrigada por confirmar. Analisei aqui no sistema. O cupom BEMVINDA10 está ativo, porém, ele possui uma restrição automática de sistema para itens da categoria "Lançamentos/New In", que é justamente o caso da Bota Urban Leather.
  [Support Agent]: Geralmente, essas regras ficam nas letras miúdas do rodapé do e-mail, mas entendo perfeitamente que a chamada principal de "todo o site" pode ter gerado essa confusão. Peço desculpas por essa falha na comunicação.
  [Customer]: Ah não, sério? Que pegadinha chata. Eu li o email rápido e não vi rodapé nenhum. Me senti meio enganada agora. A bota custa 400 reais, 10% faz diferença. Se não tiver como aplicar, eu vou ter que abandonar o carrinho, achei chato isso.
  [Support Agent]: Compreendo totalmente sua frustração e você tem toda razão, a experiência não deveria ser confusa assim. Não queremos perder você como cliente Beautiful Feet, ainda mais na sua primeira experiência conosco! :sparkling_heart:
  [Support Agent]: Como foi uma falha nossa na clareza do e-mail, conversei com minha supervisora e consegui gerar um código manual pra você que funciona inclusive nos lançamentos. Pode tentar usar o código: VIP-SOFIA-BF? Ele deve liberar os 10% na bota agora.
  [Customer]: Hum, tá bom. Deixa eu testar aqui, peraí...
  [Customer]: [3 minutos depois] Aaaah agora foi! Deu o desconto de R$ 56,00 no total. Ufa. Obrigada, Sofia. Se não fosse isso eu ia fechar a aba aqui e ir comprar na concorrente rs.
  [Support Agent]: Que alívio! :tada: Fico muito feliz que deu certo. A Bota Urban Leather é um dos nossos modelos mais confortáveis, tenho certeza que você vai amar. Já vi que o pedido foi confirmado aqui no sistema.
  [Customer]: Beleza. Já paguei no PIX. Obrigada pela ajuda rápida.
  [Support Agent]: Imagina, eu que agradeço a paciência! Já estamos separando seu par 36 com todo carinho. Qualquer dúvida sobre o rastreio, é só chamar aqui. Tenha uma semana incrível com seus sapatos novos! :sparkles:
CHAT3

Conversation.create!(channel: "RA", content: conversas_3, user: user, occurred_on: random_date(start_date, end_date))

conversas_4 = <<~CHAT4
  [Customer]: Oi, boa tarde. Preciso falar com alguém sobre uma troca por defeito, mas é urgente.
  [Support Agent]: Olá, boa tarde! Aqui é o Lucas, do time de Experiência da Beautiful Feet. Sinto muito que tenha tido um problema com seu pedido. Estou aqui para ajudar. Pode me informar o número do pedido e o que aconteceu?
  [Customer]: O pedido é o #BF-44901. Eu comprei o Scarpin "Classic Nude" verniz, tamanho 37. Chegou hoje de manhã. A caixa tava intacta, bonita e tal. Mas quando eu tirei o sapato do saquinho de tecido... decepção total.
  [Customer]: O pé direito tá com um risco enorme na lateral do verniz, parece que alguém passou uma chave ali. E o pior: o salto tá bambo. Se eu piso, ele entorta. Eu paguei quase 400 reais nesse sapato, gente! Cadê o controle de qualidade?
  [Support Agent]: Nossa, lamento profundamente por essa experiência! :worried: Isso foge totalmente do nosso padrão, especialmente na linha Classic, que é feita à mão. Entendo sua frustração, é horrível esperar algo lindo e receber assim. Para eu acionar a garantia imediata, você consegue me enviar uma foto do risco e, se possível, um vídeo curto mexendo nesse salto bambo?
  [Customer]: Espera aí, vou tirar agora. [Customer sends image: Close-up of a deep scratch on the beige patent leather]. [Customer sends video: Hand wobbling the high heel, showing it is loose from the sole]. Tá vendo? É perigoso eu torcer o pé usando isso.
  [Support Agent]: Recebi as mídias. Realmente, inaceitável. O vídeo mostra claramente que a estruturação do salto falhou. Peço mil desculpas por termos deixado isso passar. :pensive: Já abri o protocolo de defeito #DEF-992. Como você prefere prosseguir? Posso estornar o valor agora ou enviar um par novo conferido por mim pessoalmente?
  [Customer]: Olha Lucas, eu queria o sapato porque tenho uma reunião importante na quinta-feira e ele combinava com a roupa. Mas agora tô com medo de pedir outro e vir solto também. O verniz riscado até dava pra relevar, mas o salto quebrado não dá.
  [Support Agent]: Compreendo perfeitamente o receio. O que posso fazer é o seguinte: vou separar um par novo no estoque agora e pedir para a supervisão de qualidade fazer o "Teste de Estabilidade" antes de embalar. Posso te mandar foto dele antes de despachar. E para compensar o transtorno e garantir que chegue para sua reunião, eu envio por Sedex 12 (entrega expressa) por nossa conta. O que acha?
  [Customer]: Hum... se você me mandar foto antes provando que tá perfeito, eu aceito. Eu realmente gostei do modelo. Mas e esse estragado aqui? Não vou ter tempo de ir no correio postar amanhã, meu dia é corrido.
  [Support Agent]: Sem problemas! Não quero te dar trabalho extra. Como o defeito é visível e grave, não precisa devolver agora. Vou gerar uma coleta domiciliar para a semana que vem, ou você doa para alguma instituição de reparo de calçados se preferir. O foco agora é te entregar o novo a tempo. Vou buscar o par no estoque. Me dá 10 minutos?
  [Customer]: Nossa, sério? Isso ajuda muito, não ter que ir no correio. Tá bom, Lucas. Aguardo a foto do par novo então. Se estiver 100%, pode mandar.
  [Support Agent]: Perfeito! Já volto com as fotos do seu "Classic Nude" impecável. Obrigada por nos dar uma segunda chance de acertar! :high_heel::sparkles:
CHAT4

Conversation.create!(channel: "Whatsapp", content: conversas_4, user: user, occurred_on: random_date(start_date, end_date))

conversas_5 = <<~CHAT5
  [Customer]: Bom dia. O prazo de entrega era para ontem, dia 01/12, e até agora nada. Meu pedido está atrasado!
  [Support Agent]: Olá, bom dia! Aqui é a Júlia, do atendimento da Beautiful Feet. Peço mil desculpas pelo atraso e pela falta de atualização no rastreio. Sei o quanto é frustrante esperar uma encomenda que não chega na data combinada. :confused: Você pode me informar o número do seu pedido para eu verificar o que houve com a transportadora agora mesmo?
  [Customer]: O pedido é o #BF-50588. Comprei o Tênis "Cloud Running" Branco, tamanho 35. Eu comprei com antecedência justamente porque vou viajar na sexta-feira agora e queria levar ele. Se não chegar, vou ter um problema sério.
  [Support Agent]: Entendi perfeitamente a urgência, obrigada pelos dados. Estou acessando o sistema da transportadora "FlashLog" aqui. Só um minuto... Realmente, consta que o pacote saiu do nosso centro de distribuição no dia 25/11, mas travou no status "Em transferência entre unidades" em Barueri desde o dia 28/11. Isso não é comum.
  [Customer]: Pois é, travou! E ninguém me avisa nada. Eu paguei o frete mais caro pra chegar rápido. Eu viajo sexta de manhã cedo. Vocês conseguem garantir que chega até quinta à noite?
  [Support Agent]: Eu lamento muito por essa falha de comunicação da transportadora. Já estou abrindo um chamado de "Prioridade Máxima" com o gerente de conta deles para destravarem essa entrega hoje mesmo. Sendo bem transparente com você: como travou na triagem, eles pedem até 48h para finalizar. Ou seja, a previsão mais realista é que chegue na quinta-feira (dia 04/12) ao longo do dia. Vai ficar bem em cima do prazo da sua viagem.
  [Customer]: Nossa, Júlia, que risco. Quinta-feira eu vou estar o dia todo fora resolvendo coisas da viagem, só vai ter gente em casa depois das 18h. Se eles tentarem entregar de manhã e não tiver ninguém, eles vão embora e eu fico sem o tênis?
  [Support Agent]: Ótimo ponto. Para evitar isso, vou colocar uma observação na nota de transporte pedindo "Entrega em horário comercial estendido" ou solicitar que deixem na portaria (se você morar em prédio). Você mora em casa ou apartamento? Além disso, como forma de compensar esse estresse e o atraso, já solicitei o estorno integral do valor do frete no seu cartão. É o mínimo que podemos fazer pelo transtorno.
  [Customer]: Ah, o estorno ajuda, obrigada. Eu moro em prédio sim, tem porteiro 24h. Então se eles entregarem quinta de manhã, o porteiro recebe. O meu medo é eles não entregarem quinta.
  [Support Agent]: Perfeito! Se tem portaria 24h, fica muito mais seguro. Com o chamado de prioridade que abri agora, a transportadora sabe que temos um prazo fatal. Vou fazer o seguinte: vou monitorar pessoalmente esse rastreio amanhã e te mando uma mensagem no WhatsApp confirmando se saiu para entrega. Se até quinta de manhã não tiver atualizado, nós enviamos um motoboy de emergência se você estiver na capital (SP), ou pensamos num plano B. Pode ser?
  [Customer]: Tá bom, isso me deixa mais tranquila. Se tiver a opção do motoboy caso dê tudo errado, eu respiro melhor. Eu amo os sapatos de vocês, é a terceira vez que compro, mas essa transportadora tá difícil.
  [Support Agent]: Fico muito feliz que seja nossa cliente fiel! :heart: Vamos rever o contrato com essa transportadora sim. Pode deixar que não vou te deixar na mão para sua viagem. Amanhã te chamo com novidades. O estorno do frete deve aparecer na sua fatura em até 2 dias úteis.
  [Customer]: Combinado, Júlia. Fico no aguardo então. Obrigada.
  [Support Agent]: Eu que agradeço a compreensão. Vai dar certo! Tenha um ótimo dia e até breve. :athletic_shoe::airplane:
CHAT5

Conversation.create!(channel: "Instagram", content: conversas_5, user_id: user.id, occurred_on: random_date(start_date, end_date))


conversas_6 = <<~CHAT6
[Customer]: Oi, boa tarde. Gente, sério, já não sei mais o que fazer. Comprei o Tênis UrbanFlow Knit – tamanho 37, pedido #BF-78219, no dia 28/01, com previsão de entrega para 01/02. Hoje já é 05/02 e nada. O status fica mudando entre “saiu para entrega” e “pendente no centro de distribuição”. Vou mandar um print aqui — imagina um screenshot — porque não faz sentido nenhum.
[Support Agent]: Boa tarde! Sinto muito mesmo pelo transtorno, e agradeço por enviar o print, ele ajuda bastante. Entendo totalmente sua frustração, ainda mais com esses status contraditórios. Deixe-me verificar seu pedido no sistema para entender o que aconteceu. Só um instante, por favor.
[Customer]: Claro… mas olha, é que eu comprei esse tênis pra usar no trabalho, porque estou com dor no pé com meu tênis antigo. Então esse atraso tá me prejudicando de verdade. E o pior: ontem recebi uma notificação dizendo “entrega reprogramada”, mas não diz para quando. Fica tudo muito confuso.
[Support Agent]: Obrigado por compartilhar esses detalhes. Acabei de checar aqui internamente: o seu pacote realmente sofreu uma retenção logística no centro de distribuição de Campinas devido a um “alto volume de remessas” — é a mensagem que recebi da transportadora. Não é a experiência que queremos que você tenha. Vou solicitar uma priorização de rota para que ele seja entregue o mais rápido possível.
Você poderia confirmar seu endereço completo para garantirmos que não há nenhum bloqueio por divergência?
[Customer]: Sim, claro: Rua Dr. Roberto Silveira, 1280 – Apto 402, Vila Prado – Campinas/SP, CEP 13045-900. Já conferi mil vezes, tá certinho. Inclusive, no tracking aparece esse mesmo endereço. Não entendo por que ficou “retido”.
[Support Agent]: Perfeito, obrigada pela confirmação! O endereço realmente está correto. Já abri um chamado direto com a transportadora solicitando liberação imediata e pedindo uma nova previsão oficial. Eles costumam responder em até 24 horas, mas já sinalizei urgência. Assim que eu tiver retorno, te aviso por aqui.
[Customer]: Tá, mas sinceramente… vocês conseguem garantir que isso vai chegar ainda essa semana? Porque já tá muito fora do prazo. Eu gosto muito da Beautiful Feet, mas isso aqui está complicado.
[Support Agent]: Entendo totalmente sua preocupação, e você está certíssima em cobrá-la. Embora eu ainda dependa da resposta da transportadora, pelo histórico que analisei, é bem provável que a entrega aconteça entre amanhã e sexta-feira (06–07/02). Mesmo assim, só vou considerar confirmado quando eles retornarem oficialmente.
Para compensar o transtorno, já deixei registrado um cupom de 20% off para sua próxima compra: FEET20.
[Customer]: Obrigada pelo retorno e pelo cupom. Eu realmente só preciso que chegue. Por favor, me avisa assim que tiver qualquer novidade, tá? Porque tô ficando ansiosa com isso.
[Support Agent]: Pode deixar! Assim que a transportadora responder ao chamado — ou se eu notar qualquer mudança no status antes disso — eu te aviso imediatamente por aqui. Vamos acompanhar juntas até o tênis chegar certinho na sua porta.
CHAT6
Conversation.create!(channel: "Whatsapp", content: conversas_6, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_7 = <<~CHAT7
[Customer]: Oi, boa tarde. Fiz o pedido #BF-10291 no dia 03/02, um Sneaker BreezeLite – tamanho 38, e meu pedido está atrasado!
[Support Agent]: Boa tarde! Sinto muito mesmo pelo transtorno. Vou verificar o que ocorreu com a transportadora. Só um instante, por favor.
[Customer]: Claro… mas já estou bem chateada. Preciso desse tênis para treinar porque o meu atual está com a sola abrindo. E o status só aparece “em transferência”.
[Support Agent]: Entendo totalmente sua frustração. Verifiquei aqui e identifiquei um atraso no centro de distribuição de Guarulhos devido a readequação de rotas. Já abri um chamado solicitando urgência na liberação.
[Customer]: Isso significa que ainda vai demorar? Porque já passou muito do prazo...
[Support Agent]: Pela previsão atualizada, a transportadora informou entrega entre amanhã e 12/02. Assim que houver atualização, te aviso imediatamente.
[Customer]: Tá bom… espero mesmo que chegue. Obrigada.
[Support Agent]: Eu que agradeço pela compreensão! Vamos acompanhar juntas até a entrega chegar certinho.
CHAT7
Conversation.create!(channel: "Instagram", content: conversas_7, user_id: user.id, occurred_on: random_date(start_date, end_date))


conversas_8 = <<~CHAT8
[Customer]: Olá, tudo bem? Meu pedido #BF-88310 do Botinha SoftWalk – tamanho 36 estava previsto para ontem, 09/02, mas nada chegou. No tracking consta “objeto em rota reversa”. O que isso significa?
[Support Agent]: Olá! Obrigada por nos chamar. “Rota reversa” significa que o pacote pode ter sido devolvido ao centro de distribuição por algum erro de leitura. Vou confirmar isso para você.
[Customer]: Mas como assim erro? O endereço está certo. Sempre recebo compras aqui. Fiquei confusa.
[Support Agent]: Realmente não deveria ter acontecido. Verifiquei no sistema e a transportadora marcou “endereço não localizado”. Já solicitei correção e nova tentativa.
[Customer]: Nossa… ninguém tentou me ligar ou nada. Isso atrasa tudo.
[Support Agent]: Concordo. E sinto muito por isso. Já priorizei seu pedido e pedi que realizem nova tentativa até 11/02.
[Customer]: Tá… por favor, me avise quando tiver resposta.
[Support Agent]: Pode deixar! Assim que houver movimentação no sistema, retorno aqui.
CHAT8
Conversation.create!(channel: "Instagram", content: conversas_8, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_9 = <<~CHAT9
[Customer]: Oi! O meu pedido #BF-77201 com o Tênis AirFlex Motion – 37 deveria ter sido entregue no dia 02/02. Já estamos no dia 08/02 e nem sinal.
[Support Agent]: Oi! Lamento demais pelo atraso. Esse status realmente indica retenção no centro logístico. Vou verificar o motivo.
[Customer]: Tá bom, mas eu precisava dele para uma viagem… e vou amanhã. Acho que não vai chegar a tempo né?
[Support Agent]: Olhei aqui: a transportadora informou uma fila de liberação aduaneira, mas o item já está liberado desde hoje cedo. Previsão de entrega: 09 ou 10/02.
[Customer]: Poxa… queria usar na viagem. 😔
[Support Agent]: Sinto muito mesmo. Se não chegar a tempo, posso te oferecer reembolso parcial como compensação.
[Customer]: Entendi. Me avisa qualquer mudança, por favor.
[Support Agent]: Aviso sim! Estou acompanhando de perto.
CHAT9
Conversation.create!(channel: "RA", content: conversas_9, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_10 = <<~CHAT10
[Customer]: Boa noite. O pedido #BF-42109 era para chegar hoje cedo. Um Slingback ElegantSoft – 35. Eu estava em casa o dia todo e não chegou. Meu pedido está atrasado!
[Support Agent]: Boa noite! Sinto muito por essa informação incorreta. Isso acontece quando a rota está atrasada e o entregador não consegue finalizar todas as entregas.
[Customer]: Mas por que marcaram como “ausente”? Isso atrapalha totalmente.
[Support Agent]: Concordo. Já solicitei nova tentativa para amanhã até 18h. Vou pedir para não depender de confirmação manual do entregador.
[Customer]: Obrigada, espero que dessa vez venha mesmo.
[Support Agent]: Vai sim! Te mantenho informada.
CHAT10
Conversation.create!(channel: "Whatsapp", content: conversas_10, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_11 = <<~CHAT11
[Customer]: Oi! Pedido #BF-90444, Sandália ComfortWave – 38. Fiz no dia 01/02, previsão 04/02. Hoje é 09/02. No histórico aparece “Pacote danificado — aguardando análise”. O que isso significa?
[Support Agent]: Oi! Obrigada por avisar. Esse status aparece quando a transportadora identifica avaria externa na embalagem. Vou confirmar se isso afeta o produto.
[Customer]: Nossa, espero que não… era presente para minha mãe.
[Support Agent]: Eles responderam que a embalagem foi amassada, mas o produto parece intacto. Devem liberar hoje.
[Customer]: Ai, que susto. Mas chega quando?
[Support Agent]: Previsão 10 ou 11/02.
[Customer]: Tá bom. Obrigada pela rapidez.
[Support Agent]: Sempre à disposição!
CHAT11
Conversation.create!(channel: "RA", content: conversas_11, user_id: user.id, occurred_on: random_date(start_date, end_date))


conversas_12 = <<~CHAT12
Customer: Oi, boa tarde. Meu pedido #BF-66721 do Tênis Running AirMesh – 40 e meu pedido está atrasado. Comprei dia 28/01, previsão 31/01. Hoje é 06/02 e não chegou.
Support Agent: Boa tarde! Sinto muito pelo transtorno. Deixa eu verificar diretamente com a transportadora o que aconteceu.
Customer: Obrigado. Eu comprei para começar fisioterapia e estou tendo que adiar por causa disso. 😕
Support Agent: Entendo completamente. Aqui aparece que o pacote está em processo de reencaminhamento de rota, o que acontece quando há excesso de carga no caminhão.
Customer: Nossa, mas isso demora tanto assim?
Support Agent: Geralmente não, mas houve uma sobrecarga no hub de Curitiba. A nova previsão é entre 07 e 08/02.
Customer: Tá certo… fico no aguardo. Se puder me avisar quando mudar o status, agradeço.
Support Agent: Pode deixar! Vou acompanhar de perto e atualizar você.
CHAT12
Conversation.create!(channel: "Instagram", content: conversas_12, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_13 = <<~CHAT13
Customer: Olá! Meu pedido #BF-30091, Sapatilha FlexBelle – 36, está parado desde 01/02 com o status “fiscalização”. Isso é normal? Previsão era 02/02.
Support Agent: Olá! Obrigada por chamar. Esse status aparece quando o pacote passa por análise aleatória da transportadora. Vou ver quanto tempo deve levar.
Customer: Porque já está com 5 dias de atraso… achei estranho demais.
Support Agent: Verifiquei com eles. Houve uma revisão interna de documentação, já concluída. A entrega ficou reprogramada para 07/02.
Customer: Pelo menos liberou, né… mas atrasou bastante.
Support Agent: Com certeza, e peço desculpas por isso. Posso registrar um cupom de 15% para sua próxima compra.
Customer: Ok, obrigada. Acompanho aqui então.
Support Agent: Qualquer novidade te aviso por aqui mesmo.
CHAT13
Conversation.create!(channel: "RA", content: conversas_13, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_14 = <<~CHAT14
Customer: Oi! Pedido #BF-51022 está atrasado! Tava previsto para ontem, 05/02. Recebi notificação dizendo “destinatário ausente”, mas eu estava literalmente na porta de casa na hora do suposto horário da tentativa.
Support Agent: Oi! Sinto muito por isso. Esse registro costuma aparecer quando a rota do entregador está incompleta e ele não consegue finalizar as entregas.
Customer: Mas isso é muito chato… já aconteceu com outra compra de vocês. 😤
Support Agent: Imagino a frustração. Já solicitei nova tentativa para hoje até 20h e deixei observação de que o cliente está disponível.
Customer: Tá. Mas será que realmente vão vir? Não quero esperar à toa de novo.
Support Agent: Sim, já conversei com o supervisor da rota. Eles se comprometeram a tentar novamente hoje.
Customer: Então vou aguardar. Obrigado.
Support Agent: Qualquer atualização, eu te escrevo.
CHAT14
Conversation.create!(channel: "Whatsapp", content: conversas_14, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_15 = <<~CHAT15
Customer: Oi, tudo bem? Meu pedido #BF-20118, o Slip On CloudStep – 37 está atrasado há 4 dias e como “objeto não localizado no fluxo”. Isso quer dizer que sumiu?
Support Agent: Oi! Obrigada por avisar. Esse status indica que o pacote não foi escaneado corretamente na última movimentação. Vou confirmar se está em processo de busca.
Customer: Porque estou preocupada… é presente de aniversário e já está super atrasado.
Support Agent: Verifiquei aqui e sim, ele entrou em procedimento de varredura interna na transportadora. Eles costumam localizar em até 48h.
Customer: Espero mesmo, porque não posso esperar semanas.
Support Agent: Concordo totalmente. Se não localizarem até amanhã, envio um novo produto para você.
Customer: Aí sim, obrigada. Me avisa por favor.
Support Agent: Pode deixar! Estou acompanhando de perto.
CHAT15
Conversation.create!(channel: "RA", content: conversas_15, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_16 = <<~CHAT16
Customer: Boa tarde. Meu pedido #BF-99510 com a Sandália VelvetFit – 35 dizia entrega para hoje entre 8h e 13h. São 18h e nada. O status está “saiu para entrega” desde cedo.
Support Agent: Boa tarde! Sinto muito pela demora. Vou verificar se houve alguma intercorrência na rota do entregador.
Customer: Porque estou em casa desde manhã só esperando isso. 😩
Support Agent: Falei com a transportadora agora. Houve um problema mecânico no veículo da rota e eles não conseguiram finalizar as entregas.
Customer: Sério? Nossa… poderiam avisar né.
Support Agent: Com certeza. Já reagendaram sua entrega para amanhã no período da manhã.
Customer: Tá bom… espero que aconteça mesmo.
Support Agent: Eu também! Vou monitorar para garantir que seja entregue.
CHAT16
Conversation.create!(channel: "Whatsapp", content: conversas_16, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_17 = <<~CHAT17
Customer: Olá… meu pedido #BF-11509 está atrasadíssimo. O Tênis ActiveSpring – 38. Comprei dia 20/01 e até hoje, 05/02, nada. Isso é normal?
Support Agent: Olá! Não, não é normal. Por favor, desculpe pelo transtorno. Vou investigar imediatamente.
Customer: É que eu vi no tracking aparece “erro de triagem” e depois não atualizou mais.
Support Agent: Achei aqui: o pacote foi enviado para o hub errado, em Belo Horizonte, em vez de São Paulo.
Customer: Meu Deus 😳 como assim isso acontece?
Support Agent: Infelizmente erros de leitura podem ocorrer, mas já solicitei correção e prioridade no reenvio.
Customer: Ok, mas chega quando?
Support Agent: Previsão atualizada: entre 07 e 08/02.
Customer: Tá… obrigada.
Support Agent: Qualquer novidade te aviso.
CHAT17
Conversation.create!(channel: "RA", content: conversas_17, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_18 = <<~CHAT18
Customer: Oi, boa tarde. Pedido #BF-21881, Scarpin SoftTouch – 34 que está atrasado! O entregador marcou que “não conseguiu acesso ao condomínio”. Mas não é verdade — portaria funciona 24h.
Support Agent: Boa tarde! Isso realmente não faz sentido. Sinto muito por esse registro incorreto. Vou abrir reclamação com a rota.
Customer: Aconteceu às 10h da manhã e eu estava até na portaria!
Support Agent: Falei com a transportadora: foi erro de registro automático. Nova tentativa agendada para hoje até 21h.
Customer: Tá, vou aguardar. Só não quero ficar esperando à toa.
Support Agent: Entendo totalmente. Estou monitorando. Assim que o status mudar, te aviso.
Support Agent: Sempre à disposição.
CHAT18
Conversation.create!(channel: "Whatsapp", content: conversas_18, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_19 = <<~CHAT19
Customer: Oi! Pedi o Mocassim UrbanComfort – 39, pedido #BF-51004 está atrasado! Era pra chegar ontem, mas agora o status diz: “pedido retido para inspeção manual”. Isso é preocupante?
Support Agent: Oi! Obrigada por chamar. Esse status significa apenas uma análise extra por parte da transportadora. Vou descobrir o motivo específico.
Customer: Fiquei assustada, nunca vi isso.
Support Agent: Eles informaram que houve uma divergência de peso na triagem, então abriram para conferir. Produto sem dano.
Customer: Ufa. Mas e a entrega?
Support Agent: Reprogramada para 08/02.
Customer: Certo. Obrigada pela transparência.
CHAT19
Conversation.create!(channel: "RA", content: conversas_19, user_id: user.id, occurred_on: random_date(start_date, end_date))


conversas_20 = <<~CHAT20
[Customer]: Olá, tudo bem? Meu pedido #BF-70011, um Tênis FitBalance – 37, está parado desde 29/01 com status “em transferência entre unidades”. Já estamos em 07/02.
[Support Agent]: Olá! Sinto muito por esse atraso tão grande. Vou checar imediatamente com a transportadora o que está acontecendo.
[Customer]: Obrigada. Estou realmente frustrada porque comprei para usar numa corrida esse fim de semana.
[Support Agent]: Verifiquei aqui: houve um erro na roteirização e o pacote foi enviado para uma unidade intermediária errada. Já solicitei correção.
[Customer]: Isso significa que vai atrasar mais ainda?
[Support Agent]: A previsão atualizada é de entrega até 09/02. Pedi prioridade no transporte.
[Customer]: Tá bom… por favor me avise qualquer mudança.
[Support Agent]: Pode deixar! Estarei monitorando de perto.
CHAT20
Conversation.create!(channel: "RA", content: conversas_20, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_21 = <<~CHAT21
[Customer]: Boa tarde. Fiz o pedido #BF-66002, Sandália BreezeComfort – 36, no dia 30/01. Era pra chegar dia 02/02. Hoje é 08/02 e nada. O tracking mostra “remessa não movimentada”.
[Support Agent]: Boa tarde! Sinto muito mesmo pela demora. Esse status indica que o pacote não foi escaneado desde a entrada no centro de distribuição. Vou verificar se está parado lá.
[Customer]: Parece que sumiu… estou bem chateada.
[Support Agent]: Falei com a transportadora: houve falha no sistema de leitura, mas o pacote está lá sim. Já pediram a movimentação para expedição.
[Customer]: E vocês conseguem saber quando entregam?
[Support Agent]: Eles estimam entre 09 e 10/02.
[Customer]: Espero que aconteça, porque comprei para um evento.
[Support Agent]: Estarei acompanhando e te aviso qualquer atualização.
CHAT21
Conversation.create!(channel: "Whatsapp", content: conversas_21, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_22 = <<~CHAT22
[Customer]: Oi! Eu fiz o pedido #BF-31900, Sapatênis UrbanFlex – 40, e disseram que ia chegar até dia 05/02. No tracking aparece “tentativa de entrega frustrada — área de risco”. Eu moro aqui há 10 anos, nunca deu isso!
[Support Agent]: Oi! Que situação absurda, sinto muito mesmo. Esse status geralmente é usado quando a rota está incompleta e não conseguem finalizar o trajeto — não significa que sua região seja de risco.
[Customer]: Nossa, que alívio. Achei que tinha algo a ver com segurança mesmo.
[Support Agent]: Nada disso. Já solicitei reclassificação e nova tentativa ainda hoje.
[Customer]: E será que vem mesmo?
[Support Agent]: Segundo o supervisor de rota, sim. Entre 16h e 21h.
[Customer]: Tá bom. Qualquer coisa me avise, por favor.
[Support Agent]: Atualizo você assim que tiver movimentação.
CHAT22
Conversation.create!(channel: "Instagram", content: conversas_22, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_23 = <<~CHAT23
[Customer]: Olá, tudo certo? Fiz o pedido #BF-88117, o Tênis CloudGrip – 38. O status fica alternando entre “em trânsito” e “aguardando fiscalização”. É normal isso? E reforço: meu pedido está atrasado!
[Support Agent]: Olá! Obrigada por avisar. Não, essa alternância não deveria acontecer. Vou checar com a transportadora.
[Customer]: Porque já está com 3 dias de atraso… achei estranho demais.
[Support Agent]: Recebi retorno: houve uma falha no sistema de atualização deles, mas o pacote está liberado.
[Customer]: Então não está preso na fiscalização?
[Support Agent]: Não, felizmente não. Previsão de entrega: 09/02.
[Customer]: Ufa. Obrigada pela verificação!
[Support Agent]: Sempre que precisar, é só me chamar.
CHAT23
Conversation.create!(channel: "RA", content: conversas_23, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_24 = <<~CHAT24
[Customer]: Boa noite. Pedido #BF-41222, Bota WinterSoft – 37. Está parado há 6 dias e já está atrasado!
[Support Agent]: Boa noite! Vou confirmar por quê.
[Customer]: Porque comprei para viajar sábado, e acho que não vai chegar mais…
[Support Agent]: Falei com o centro de distribuição: houve atraso no processamento manual. Eles garantiram inclusão na rota de amanhã.
[Customer]: Amanhã mesmo?
[Support Agent]: Sim, entre 12h e 18h.
[Customer]: Tá… vou confiar. Obrigada.
[Support Agent]: Qualquer mudança te aviso prontamente.
CHAT24
Conversation.create!(channel: "RA", content: conversas_24, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_25 = <<~CHAT25
[Customer]: Oi! Meu pedido #BF-55091, Tênis SoftRun – 39, foi marcado como entregue hoje às 14h, mas NÃO recebi nada. Já chequei com vizinhos e nada.
[Support Agent]: Oi! Nossa, sinto muito por isso. Vou checar imediatamente o comprovante de entrega.
[Customer]: Já estou preocupada porque preciso usar amanhã cedo.
[Support Agent]: Verifiquei aqui: o entregador registrou erroneamente como entregue porque não conseguiu finalizar a rota. O pacote ainda está com ele.
[Customer]: Gente… mas como registram como entregue sem entregar? 😡
[Support Agent]: Realmente não deveria acontecer. Já solicitei correção e nova tentativa para amanhã até 11h.
[Customer]: Espero que chegue, por favor.
[Support Agent]: Estou acompanhando em tempo real. Te aviso qualquer novidade.
CHAT25
Conversation.create!(channel: "Whatsapp", content: conversas_25, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_26 = <<~CHAT26
[Customer]: Boa tarde! O pedido #BF-10007, Sandália SoftChic – 35 está atrasado! A entrega era para 03/02.
[Support Agent]: Boa tarde! Obrigada por relatar. Vou verificar o que ocorreu na triagem.
[Customer]: Eu nunca vi esse tipo de status. Achei que o pacote tivesse quebrado ou algo assim.
[Support Agent]: Não, fique tranquila. “Falha na triagem” geralmente é erro de leitura no sistema. Pedi que o item seja reprocessado.
[Customer]: E a nova previsão?
[Support Agent]: Eles informaram que a entrega deve ocorrer até 09/02.
[Customer]: Ok… vou aguardar então. Obrigada.
[Support Agent]: Estou acompanhando e te aviso qualquer novidade.
CHAT26
Conversation.create!(channel: "Instagram", content: conversas_26, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_27 = <<~CHAT27
[Customer]: Oi, tudo bom? Meu pedido #BF-41891, Tênis PowerFlex – 42, está marcado como “endereço inválido”. Mas o endereço está certinho! Já comprei várias vezes aqui.
[Support Agent]: Oi! Que situação chata. Vou checar se houve erro de leitura no sistema.
[Customer]: Confere aí, por favor. Não faz sentido nenhum.
[Support Agent]: Verifiquei. A transportadora registrou rua “sem numeração”. Isso às vezes acontece quando a etiqueta amassa.
[Customer]: Mas o número está super visível!
[Support Agent]: Concordo. Já solicitei correção manual e nova tentativa para amanhã.
[Customer]: Obrigado. Espero que resolva.
[Support Agent]: Qualquer alteração de status te aviso.
CHAT27
Conversation.create!(channel: "Whatsapp", content: conversas_27, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_28 = <<~CHAT28
[Customer]: Olá, meu pedido #BF-70077, o Tamanco SummerLite – 36, está há 4 dias com status “objeto conferido”. Não anda! Já era para ter chegado ontem.
[Support Agent]: Olá! Obrigada por chamar. Vou verificar a causa dessa retenção.
[Customer]: Estou achando que podem ter perdido meu pacote.
[Support Agent]: Felizmente não. O item está na fila de expedição, mas houve excesso de carga na unidade. Está programado para sair hoje.
[Customer]: Então entrega quando?
[Support Agent]: Amanhã, entre 10h e 17h.
[Customer]: Ok. Obrigada pela clareza.
[Support Agent]: Qualquer novidade, atualizo aqui.
CHAT28
Conversation.create!(channel: "Whatsapp", content: conversas_28, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_29 = <<~CHAT29
[Customer]: Boa noite. O pedido #BF-99110, Tênis LightStep – 38, está marcado como “em devolução ao remetente”. Como assim? Eu nem recebi!
[Support Agent]: Boa noite! Vou verificar isso imediatamente porque realmente não está certo.
[Customer]: Achei bem estranho… não faz sentido.
[Support Agent]: Verifiquei com a transportadora. Foi um erro no fechamento da rota — eles não conseguiram entregar ontem e o sistema gerou devolução automática.
[Customer]: Meu Deus… mas não devolveram de verdade, né?
[Support Agent]: Não! O pacote ainda está na unidade local. Já solicitei reversão e nova tentativa amanhã.
[Customer]: Tá… por favor me avise mesmo. Não quero que voltem com o produto.
[Support Agent]: Pode deixar! Estarei acompanhando para garantir que chegue certinho.

CHAT29
Conversation.create!(channel: "Instagram", content: conversas_29, user_id: user.id, occurred_on: random_date(start_date, end_date))
conversas_30 = <<~CHAT30
 [Customer]: Oi, bom dia. Preciso de ajuda urgente
 [Support Agent]: Olá! Aqui é a Ana da Beautiful Feet. Me conta o que aconteceu, por favor.
 [Customer]: Meu pedido BF-91302 chegou agora pouco. Eu pedi a sandália Aurora Nude 38. Veio 36…
 [Customer]: Eu tenho uma formatura amanhã. Isso não entra nem com reza.
 [Support Agent]: Meu Deus, sinto muito mesmo por isso  Vou verificar agora no sistema, só um momento.
 [Customer]: Por favor, porque eu tô entrando em desespero aqui.
 [Support Agent]: Verifiquei aqui: realmente seu pedido original é 38. Houve erro na separação do estoque.
 [Support Agent]: Você consegue me mandar uma foto da etiqueta da caixa e do solado da sandália?
 [Customer]: Mando já. [Customer sends image: etiqueta com 36 visível]
 [Support Agent]: Obrigada! Vou abrir exceção de envio prioritário pra te atender ainda hoje.
 [Customer]: Sério? Se chegar amanhã cedo, eu choro de alegria.
 [Support Agent]: Vamos fazer o possível. Te envio o novo rastreio ainda hoje.
CHAT30
Conversation.create!(channel: "Whatsapp", content: conversas_30, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_31 = <<~CHAT31
 [Customer]: Boa tarde. Pela segunda vez vocês erram meu tamanho.
 [Support Agent]: Boa tarde! Sinto muito mesmo por isso 😔 Pode me passar o número do pedido?
 [Customer]: BF-89977. Pedi 39, veio 37.
 [Support Agent]: Já localizei. Realmente houve falha novamente na expedição.
 [Customer]: Isso é muito frustrante, parece descaso.
 [Support Agent]: Você tem razão em ficar chateada. Vamos resolver isso agora com prioridade.
 [Support Agent]: Consegue me enviar uma foto do produto recebido?
 [Customer]: Envio sim. [Customer sends image: sandália pequena dentro da caixa]
 [Support Agent]: Obrigada. Vou autorizar troca expressa sem necessidade de devolução imediata.
 [Customer]: Ainda bem, porque eu trabalho o dia todo.
 [Support Agent]: Sem problemas, você terá 10 dias pra postar depois.
CHAT31

Conversation.create!(channel: "RA", content: conversas_31, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_32 = <<~CHAT32
 [Customer]: Oi, acho que veio errado o tamanho…
 [Support Agent]: Oi! Tudo bem? Me conta o que aconteceu.
 [Customer]: O pedido BF-92110. Pedi 37, mas quando calcei senti que tá muito apertado. Na palmilha tá 36.
 [Support Agent]: Obrigada por avisar. Às vezes a caixa vem correta e o sapato não.
 [Support Agent]: Você pode me mandar uma foto da palmilha com a numeração?
 [Customer]: Mando já. [Customer sends image: palmilha com 36 marcado]
 [Support Agent]: Confirmado, houve erro sim. Vou gerar sua troca imediatamente.
 [Customer]: Mas demora muito? Eu preciso dele pra trabalhar.
 [Support Agent]: O reenvio sai amanhã e chega em até 3 dias úteis.
CHAT32

Conversation.create!(channel: "Instagram", content: conversas_32, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_33 = <<~CHAT33
 [Customer]: Eu sei que já usei dentro de casa, mas veio no tamanho errado 😔
 [Support Agent]: Fique tranquila, provar não invalida a troca. Qual seu pedido?
 [Customer]: BF-93450. Pedi 40, veio 38.
 [Support Agent]: Obrigada! Vou verificar agora.
 [Support Agent]: Confirmado o erro de tamanho. A troca é autorizada sem custos pra você.
 [Customer]: Ai, ainda bem… achei que ia perder meu dinheiro.
 [Support Agent]: Jamais! Vamos resolver isso direitinho.

CHAT33

Conversation.create!(channel: "Whatsapp", content: conversas_33, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_34 = <<~CHAT34
 [Customer]: Oi, acabei de abrir meu pedido aqui no trabalho e veio errado.
 [Support Agent]: Oi! Me conta o que houve.
 [Customer]: Pedido BF-90218. Pedi 35, veio 37.
 [Support Agent]: Entendi. Você consegue me mandar foto da etiqueta da caixa quando chegar em casa?
 [Customer]: Consigo sim, agora não tenho como.
 [Support Agent]: Sem problemas, já deixo o protocolo aberto pra adiantar.
CHAT34

Conversation.create!(channel: "Instagram", content: conversas_34, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_35 = <<~CHAT35
 [Customer]: Se não tiver mais meu tamanho, eu faço o quê?
 [Support Agent]: Vamos verificar agora. Qual pedido?
 [Customer]: BF-91844. Pedi 38, veio 36.
 [Support Agent]: Temos apenas 1 unidade no 38 ainda disponível.
 [Customer]: Ai, então separa pra mim pelo amor de Deus
 [Support Agent]: Já deixei reservado no sistema, fica tranquila.
CHAT35

Conversation.create!(channel: "RA", content: conversas_35, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_36 = <<~CHAT36
 [Customer]: E se o correio perder meu produto na devolução? Meu pedido estava errado.
 [Support Agent]: Fique tranquila, o envio é segurado e rastreado.
 [Customer]: Porque é a primeira vez que eu troco online. Pois meu pedido estava errado.
 [Support Agent]: Entendo o medo, mas você estará protegida do início ao fim.

CHAT36

Conversation.create!(channel: "Instagram", content: conversas_36, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_37 = <<~CHAT37
 [Customer]: Já faz 9 dias que eu enviei a troca e ninguém responde.
 [Support Agent]: Peço mil desculpas pela demora 😞 Pode me passar o número da postagem?
 [Customer]: PX349201BR.
 [Support Agent]: Obrigada! Vejo aqui que chegou ontem no nosso CD.
 [Customer]: Só ontem??
 [Support Agent]: Sim, houve atraso da transportadora, infelizmente.
CHAT37

Conversation.create!(channel: "Instagram", content: conversas_37, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_38 = <<~CHAT38
 [Customer]: Meu sapato da troca foi enviado pro endereço antigo 😡
 [Support Agent]: Nossa, sinto muito! Pode me confirmar o atual?
 [Customer]: Rua Bela Vista, 310.
 [Support Agent]: Aqui constou o endereço antigo mesmo. Vou solicitar correção imediata.
CHAT38

 Conversation.create!(channel: "Instagram", content: conversas_38, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_39 = <<~CHAT39
 [Customer]: Já errou uma vez, eu não confio mais. Quero cancelar.
 [Support Agent]: Eu entendo sua frustração 😔 Quer que eu siga com estorno total?
 [Customer]: Quero sim.
 [Support Agent]: Perfeito, o valor será estornado em até 5 dias úteis no seu cartão.
 [Customer]: Tá bom. Obrigada.
 [Support Agent]: Sinto muito pela experiência e espero que possamos te atender melhor no futuro.
CHAT39

Conversation.create!(channel: "Whatsapp", content: conversas_39, user_id: user.id, occurred_on: random_date(start_date, end_date))

#Erro no Cupom (8)
conversas_40 = <<~CHAT40
 [Customer]: Oi, bom dia. Meu cupom não funciona de jeito nenhum.
 [Support Agent]: Bom dia! Aqui é a Beatriz da Beautiful Feet. Qual cupom você está tentando usar?
 [Customer]: É o BF15OFF. Ele aparece como inválido.
 [Support Agent]: Entendi! Você poderia me informar o número do pedido, por favor?
 [Customer]: Ainda não finalizei, tava tentando agora com a sandália Crystal Rosa 37.
 [Support Agent]: Perfeito, já identifiquei aqui que o cupom expirou ontem à meia-noite.
 [Customer]: Mas no Instagram dizia que era até hoje 😤
 [Support Agent]: Você tem razão, houve falha na divulgação. Vou gerar um cupom manual pra você agora.
CHAT40

Conversation.create!(channel: "RA", content: conversas_40, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_41 = <<~CHAT41
 [Customer]: Eu apliquei o cupom, mas mesmo assim foi cobrado o valor cheio 😡
 [Support Agent]: Sinto muito por isso 😔 Pode me enviar o número do pedido?
 [Customer]: BF-93011.
 [Support Agent]: Obrigada, estou verificando…
 [Support Agent]: Realmente o desconto não foi abatido. Houve falha na integração do pagamento.
 [Customer]: Nossa, isso é muito errado.
 [Support Agent]: Você está certa. Vou solicitar o estorno do valor do desconto imediatamente.
CHAT41

Conversation.create!(channel: "Instagram", content: conversas_41, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_42 = <<~CHAT42
 [Customer]: O cupom entra no carrinho mas some quando vou pagar 😤
 [Support Agent]: Entendo, isso realmente gera muita frustração. Qual cupom você usou?
 [Customer]: BFVIP20.
 [Support Agent]: Esse cupom é exclusivo para clientes cadastrados no CPF promocional.
 [Customer]: Mas eu já comprei com vocês várias vezes.
 [Support Agent]: Sim, vejo seu histórico aqui. Vou liberar o desconto manualmente.
CHAT42

Conversation.create!(channel: "Instagram", content: conversas_42, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_43 = <<~CHAT43
 [Customer]: No celular o cupom não aplica, só no site normal.
 [Support Agent]: Obrigada por avisar. Isso ajuda muito a gente!
 [Customer]: Eu só consegui testar agora no notebook.
 [Support Agent]: É um bug específico na versão mobile, já está em correção.
 [Customer]: Mas eu perdi a promoção 😔
 [Support Agent]: Não vai perder. Vou gerar um cupom exclusivo válido por 24h pra você.
CHAT43

Conversation.create!(channel: "Whatsapp", content: conversas_43, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_44 = <<~CHAT44
 [Customer]: Vi anúncio dizendo 20% OFF com cupom, mas não funciona!
 [Support Agent]: Entendo sua indignação 😔 Você lembra onde viu o anúncio?
 [Customer]: No Instagram de vocês, hoje de manhã.
 [Support Agent]: Obrigada! Vamos reportar isso para o marketing agora mesmo.
 [Customer]: Porque assim parece propaganda enganosa.
 [Support Agent]: Você tem razão. Vou garantir o desconto manualmente pra você agora.

CHAT44

Conversation.create!(channel: "Instagram", content: conversas_44, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_45 = <<~CHAT45
 [Customer]: O cupom diz que é válido, mas não entra no meu pedido.
 [Support Agent]: Qual o modelo que você escolheu?
 [Customer]: Bota London Black 38.
 [Support Agent]: Esse modelo infelizmente está fora da campanha promocional.
 [Customer]: Mas isso não tava claro no site 😤
 [Support Agent]: Você tem razão. Vou liberar uma exceção pra você agora.
CHAT45


Conversation.create!(channel: "RA", content: conversas_45, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_46 = <<~CHAT46
 [Customer]: Eu já tentei esse cupom umas 6 vezes, nada funciona.
 [Support Agent]: Nossa, sinto muito por isso 😔 Qual cupom é?
 [Customer]: BFMAIO15.
 [Support Agent]: Ele atingiu o limite máximo de usos hoje.
 [Customer]: Então por que continua aparecendo no site?
 [Support Agent]: Ótima observação. Vou repassar isso agora para o time responsável.

CHAT46

Conversation.create!(channel: "Instagram", content: conversas_46, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_47 = <<~CHAT47
 [Customer]: Se não funcionar o cupom eu vou cancelar a compra.
 [Support Agent]: Calma, vamos resolver isso agora. Qual pedido?
 [Customer]: BF-94120.
 [Support Agent]: Já vi aqui, o sistema realmente não aplicou o desconto.
 [Customer]: Então cancela tudo.
 [Support Agent]: Antes disso, posso aplicar o desconto manualmente e manter o valor correto pra você.
 [Customer]: Se conseguir, eu fico.
 [Support Agent]: Consegui! Já ajustei e te enviei o novo link de pagamento. ✅
CHAT47

Conversation.create!(channel: "RA", content: conversas_47, user_id: user.id, occurred_on: random_date(start_date, end_date))
#Solicitacao de NF (3)

conversas_48 = <<~CHAT48
 [Customer]: Oi, tudo bem? Eu preciso MUITO da nota fiscal da minha compra.
 [Support Agent]: Oi! Aqui é a Júlia da Beautiful Feet 😊 Me passa o número do pedido pra eu verificar?
 [Customer]: É o BF-92881. Comprei a Sandália Gala Gold 38.
 [Support Agent]: Obrigada! Verificando aqui…
 [Support Agent]: Vejo que a NF foi gerada automaticamente, mas não foi enviada por e-mail por uma falha do sistema 😔
 [Customer]: Puts, isso me ferra. Eu preciso enviar pro financeiro da empresa hoje.
 [Support Agent]: Fique tranquila, vou gerar uma segunda via manualmente e te enviar em até 20 minutos.
 [Customer]: Por favor, urgente mesmo. É reembolso de viagem.
 [Support Agent]: Pode deixar comigo! Assim que estiver pronta, te envio em PDF e XML no seu e-mail.
CHAT48

Conversation.create!(channel: "Instagram", content: conversas_48, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_49 = <<~CHAT49
 [Customer]: Olá, eu recebi meu pedido já faz 5 dias, mas até agora nada da nota fiscal.
 [Support Agent]: Olá! Aqui é o Felipe. Pode me passar o número do pedido, por favor?
 [Customer]: BF-90244. É aquela Mule Soft Black.
 [Support Agent]: Obrigado! Estou vendo aqui que a NF não foi emitida porque o CPF ficou registrado incompleto no checkout.
 [Customer]: Ah não 😩 eu jurava que tinha colocado certinho.
 [Support Agent]: Sem problema algum! Você pode me confirmar seu CPF completo aqui?
 [Customer]: Claro, é ..*-
 [Support Agent]: Perfeito, já corrigi. A NF vai ser emitida em até 2 horas e enviada direto pro seu e-mail.
 [Customer]: Obrigada por agilizar 🙏
 [Support Agent]: Qualquer coisa é só me chamar!
CHAT49

Conversation.create!(channel: "RA", content: conversas_49, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_50 = <<~CHAT50
 [Customer]: Boa tarde. Preciso da nota fiscal, mas tem que ser emitida no CNPJ da minha loja.
 [Support Agent]: Claro! Posso te ajudar com isso. Qual o número do seu pedido?
 [Customer]: BF-91560.
 [Support Agent]: Obrigado! Vejo que a NF foi emitida no seu CPF.
 [Customer]: Sim, mas eu preciso no CNPJ. Foi erro meu na hora da compra.
 [Support Agent]: Sem problemas, posso cancelar a NF atual e gerar uma nova.
 [Customer]: Tem custo ou algo assim?
 [Support Agent]: Nenhum. Só preciso do CNPJ da empresa e o nome completo.
 [Customer]: CNPJ: XX.XXX.XXX/0001-XX, Razão Social: Nova Era Beauty LTDA
 [Support Agent]: Perfeito! Estou solicitando aqui. Em até 24h você recebe a NF corrigida no e-mail.
 [Customer]: Ótimo. Obrigada pelo atendimento rápido.
 [Support Agent]: Disponha sempre! 😊

CHAT50

Conversation.create!(channel: "Whatsapp", content: conversas_50, user_id: user.id, occurred_on: random_date(start_date, end_date))
#Duvida de Produto (3)
conversas_51 = <<~CHAT51
 [Customer]: Oi, boa noite. Tô olhando uma sandália de vocês, mas tô com medo de não aguentar usar o dia todo.
 [Support Agent]: Boa noite! Aqui é a Marina da Beautiful Feet 😊 Qual modelo você está vendo?
 [Customer]: É a Sandália Royal Velvet preta, tamanho 37.
 [Support Agent]: Ótima escolha! Ela tem palmilha acolchoada e salto bloco, ideal pra uso prolongado.
 [Customer]: Porque eu vou pra um casamento e devo ficar em pé várias horas 😥
 [Support Agent]: Entendo. Esse modelo é justamente um dos mais confortáveis pra esse tipo de evento.
 [Customer]: Ela machuca no calcanhar?
 [Support Agent]: Não costuma machucar, mas sempre indicamos usar um pouco em casa antes pra adaptar.
 [Customer]: Tá, acho que vou arriscar então.
 [Support Agent]: Qualquer coisa, nossa política de troca é bem tranquila 💛
CHAT51

Conversation.create!(channel: "Whatsapp", content: conversas_51, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_52 = <<~CHAT52
 [Customer]: Boa tarde. Esse modelo “Luna Off White” tem forma grande ou pequena?
 [Support Agent]: Boa tarde! Ótima pergunta. Ele tem forma padrão, não costuma apertar.
 [Customer]: Porque eu fico entre 36 e 37 dependendo do modelo 😕
 [Support Agent]: Nesse caso, a maioria das clientes escolhe o 37 para maior conforto.
 [Customer]: Ele laceia com o uso?
 [Support Agent]: Um pouco, sim, principalmente por ser material sintético maleável.
 [Customer]: Tá, vou de 37 então.
 [Support Agent]: Perfeito! Qualquer problema, a troca é sem custo na primeira vez.
CHAT52

Conversation.create!(channel: "Instagram", content: conversas_52, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_53 = <<~CHAT53
 [Customer]: Oi, tudo bem? Essa bota London Black é de couro mesmo?
 [Support Agent]: Oi! Tudo bem sim 😊 Ela é de couro ecológico de alta resistência.
 [Customer]: Não descasca rápido, né?
 [Support Agent]: Não costuma descascar com uso normal e cuidados básicos.
 [Customer]: É que eu trabalho muito em pé e uso todo dia.
 [Support Agent]: Nesse caso, ela aguenta bem a rotina, mas indicamos alternar com outro par.
 [Customer]: Tá ótimo então. Obrigada por esclarecer.
 [Support Agent]: Eu que agradeço! Se precisar de qualquer outra dica, estou por aqui.
CHAT53

Conversation.create!(channel: "Instagram", content: conversas_53, user_id: user.id, occurred_on: random_date(start_date, end_date))
#Rastramento (3)

conversas_54 = <<~CHAT54
 [Customer]: Oi, boa tarde. Meu pedido tá parado no rastreio faz 4 dias, ninguém resolve 😟
 [Support Agent]: Boa tarde! Aqui é a Paula da Beautiful Feet. Me passa o número do pedido, por favor?
 [Customer]: BF-92670. É a Sandália Luna Bege 38.
 [Support Agent]: Obrigada! Estou verificando agora no sistema…
 [Support Agent]: Consta aqui como “Em trânsito para a unidade de destino” desde segunda-feira.
 [Customer]: Exato! Hoje já é sexta 😡 Eu fico atualizando toda hora e nada muda.
 [Support Agent]: Você tem razão em ficar preocupada. Pode me enviar um print do status atual?
 [Customer]: Mando sim. [Customer sends image: print do rastreio parado há dias]
 [Support Agent]: Obrigada! Vou abrir um chamado urgente com a transportadora agora mesmo.
 [Customer]: Porque eu preciso desse sapato pra viajar amanhã.
 [Support Agent]: Entendo a urgência. Te retorno assim que a transportadora responder.
CHAT54

Conversation.create!(channel: "Whatsapp", content: conversas_54, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_55 = <<~CHAT55
 [Customer]: Oi, meu pedido aparece como entregue, mas não chegou nada aqui!
 [Support Agent]: Oi! Sinto muito por isso 😔 Pode me informar o número do pedido?
 [Customer]: BF-93419. Era a Bota London Black 37.
 [Support Agent]: Obrigada! Um momento enquanto verifico…
 [Support Agent]: Consta aqui como entregue hoje às 10h32.
 [Customer]: Pois é, nesse horário eu tava no trabalho! Ninguém recebeu nada.
 [Support Agent]: Entendi. Você mora em condomínio?
 [Customer]: Moro, mas a portaria não recebeu nada também.
 [Support Agent]: Vou abrir um protocolo de “Entrega não reconhecida” com a transportadora agora.
 [Customer]: E eu fico sem resposta até quando?
 [Support Agent]: O prazo é de até 48h para retorno, mas vou acompanhar pessoalmente seu caso.
CHAT55

Conversation.create!(channel: "Whatsapp", content: conversas_55, user_id: user.id, occurred_on: random_date(start_date, end_date))

conversas_56 = <<~CHAT56
 [Customer]: Meu pedido tá aparecendo como cancelado e em rota de entrega ao mesmo tempo 😵‍💫
 [Support Agent]: Nossa, isso realmente confunde muito. Qual o número do pedido?
 [Customer]: BF-94003. Sandália Crystal Rosa 36.
 [Support Agent]: Obrigada! Deixa eu verificar aqui…
 [Support Agent]: No nosso sistema consta como “em rota”, mas a transportadora marcou como “cancelado por falha”.
 [Customer]: Como assim falha? Já foi pago tudo certinho!
 [Support Agent]: Sim, seu pagamento está confirmado. O erro foi operacional da transportadora.
 [Customer]: Então eu vou receber ou não?
 [Support Agent]: Vou solicitar reenvio imediato por outra transportadora pra evitar novos erros.
 [Customer]: Porque eu já tô perdendo a paciência 😤
 [Support Agent]: Você tem toda razão. Vou priorizar esse reenvio agora mesmo.
CHAT56

Conversation.create!(channel: "RA", content: conversas_56, user_id: user.id, occurred_on: random_date(start_date, end_date))


product_insights = [
<<~CHAT,
[Customer]: Oi, tudo bem? Eu gosto muito dos modelos de vocês, mas sempre fico insegura com o tamanho.
[Support Agent]: Oi! Tudo bem sim 😊 Fico feliz que goste dos nossos modelos. Pode me contar melhor o que gera essa insegurança?
[Customer]: Então, cada marca parece ter um padrão diferente. Acho que o guia de tamanhos poderia ser mais detalhado.
[Support Agent]: Entendo perfeitamente. Você sente falta de mais informações como comprimento do pé em cm?
[Customer]: Sim, exatamente. E talvez uma comparação tipo “calça justo”, “forma grande”.
[Support Agent]: Ótima sugestão! Vou registrar esse feedback e encaminhar para o time de produto.
[Customer]: Acho que ajudaria muita gente a comprar com mais segurança.
[Support Agent]: Com certeza. Obrigada por compartilhar, isso é muito valioso pra gente.
CHAT

<<~CHAT,
[Customer]: Olá! Estava olhando uma sandália linda no site.
[Support Agent]: Oi! Que bom 😊 Qual modelo você estava vendo?
[Customer]: A Sandália Aurora. Mas senti falta de fotos nos pés, em pessoas reais.
[Support Agent]: Entendo. Você acha que ajudaria a ter uma noção melhor do caimento?
[Customer]: Sim, totalmente. Foto em estúdio é bonita, mas no dia a dia é diferente.
[Support Agent]: Faz todo sentido. Vou anotar essa sugestão para nosso time de marketing.
[Customer]: Acho que aumentaria a confiança na compra.
[Support Agent]: Concordo com você. Muito obrigada pelo insight!
CHAT

<<~CHAT,
[Customer]: Oi, posso dar uma sugestão?
[Support Agent]: Claro! Adoramos receber sugestões 😊
[Customer]: Seria legal permitir avaliações com fotos dos clientes.
[Support Agent]: Que ótima ideia! Isso ajudaria outros clientes na decisão?
[Customer]: Muito! Dá mais confiança ver como ficou em alguém real.
[Support Agent]: Perfeito. Vou registrar isso como feedback de melhoria.
[Customer]: Obrigada por ouvir.
[Support Agent]: Nós que agradecemos! Isso ajuda muito nosso crescimento.
CHAT

<<~CHAT,
[Customer]: Oi, tudo bem?
[Support Agent]: Oi! Tudo ótimo 😊 Em que posso ajudar?
[Customer]: Eu tenho pé largo e sempre sofro pra escolher sapato.
[Support Agent]: Entendo bem. Você sente falta dessa informação no site?
[Customer]: Sim, seria ótimo um filtro tipo “pé largo” ou “pé fino”.
[Support Agent]: Excelente ponto. Vou anotar essa sugestão agora.
[Customer]: Facilitaria muito a vida.
[Support Agent]: Com certeza. Obrigada por compartilhar essa experiência.
CHAT

<<~CHAT,
[Customer]: Oi! Tudo bem?
[Support Agent]: Oi! Tudo sim 😊
[Customer]: Acho que o prazo de entrega podia aparecer antes de finalizar a compra.
[Support Agent]: Entendo. Você só consegue ver isso no final hoje?
[Customer]: Sim, e às vezes isso muda minha decisão.
[Support Agent]: Faz total sentido. Vou registrar como sugestão de melhoria.
[Customer]: Obrigada, acho importante.
[Support Agent]: Concordo com você. Obrigada pelo feedback!
CHAT

<<~CHAT,
[Customer]: Olá! Estava comparando dois modelos parecidos.
[Support Agent]: Oi! Posso te ajudar nisso 😊
[Customer]: Seria legal ter uma função de comparar produtos no site.
[Support Agent]: Ótima ideia! Comparar material, salto, conforto…
[Customer]: Exato, tudo lado a lado.
[Support Agent]: Vou anotar e repassar para o time técnico.
[Customer]: Obrigada!
[Support Agent]: Nós que agradecemos o insight.
CHAT

<<~CHAT,
[Customer]: Oi! Posso dar um feedback?
[Support Agent]: Claro, pode sim 😊
[Customer]: Eu sinto falta de mais detalhes sobre conforto nas descrições.
[Support Agent]: Tipo palmilha, maciez, uso prolongado?
[Customer]: Isso! Principalmente pra quem passa o dia em pé.
[Support Agent]: Excelente ponto. Vou registrar isso agora.
[Customer]: Obrigada por considerar.
[Support Agent]: A gente agradece muito!
CHAT

<<~CHAT,
[Customer]: Oi, um modelo que eu queria está esgotado.
[Support Agent]: Oi! Que pena 😕 Qual modelo?
[Customer]: Pensei que seria legal ter aviso quando voltar ao estoque.
[Support Agent]: Ótima sugestão! Um alerta por e-mail, por exemplo?
[Customer]: Sim, exatamente.
[Support Agent]: Vou encaminhar essa ideia ao time.
[Customer]: Obrigada!
[Support Agent]: Nós que agradecemos o insight.
CHAT

<<~CHAT,
[Customer]: Oi! Demorei pra achar o chat no site.
[Support Agent]: Oi! Obrigada por avisar 😊
[Customer]: Talvez um botão mais visível ajudasse.
[Support Agent]: Entendi. Você estava no celular ou computador?
[Customer]: No celular.
[Support Agent]: Ótimo ponto, vou anotar isso como melhoria mobile.
[Customer]: Obrigada.
[Support Agent]: Feedback super importante!
CHAT

<<~CHAT,
[Customer]: Olá!
[Support Agent]: Oi 😊
[Customer]: Amo um modelo de vocês, mas só tem duas cores.
[Support Agent]: Entendo. Você gostaria de mais opções?
[Customer]: Sim! Preto, nude, talvez tons claros.
[Support Agent]: Ótimo insight. Vou repassar ao time de produto.
[Customer]: Que bom!
[Support Agent]: Obrigada pela sugestão!
CHAT

<<~CHAT,
[Customer]: Oi! Posso sugerir algo?
[Support Agent]: Claro 😊
[Customer]: Vídeos curtos mostrando o sapato em movimento.
[Support Agent]: Excelente ideia! Ajuda muito a ver o caimento.
[Customer]: Sim, principalmente andando.
[Support Agent]: Vou registrar isso agora.
[Customer]: Obrigada!
[Support Agent]: Nós que agradecemos.
CHAT

<<~CHAT,
[Customer]: Oi!
[Support Agent]: Oi 😊
[Customer]: Já pensaram em embalagens mais sustentáveis?
[Support Agent]: Ótima pergunta. Isso é importante pra você?
[Customer]: Muito. Influencia até na escolha da marca.
[Support Agent]: Vou registrar esse feedback ambiental.
[Customer]: Obrigada por ouvir.
[Support Agent]: Muito relevante mesmo!
CHAT

<<~CHAT,
[Customer]: Oi! Estava procurando meus pedidos antigos.
[Support Agent]: Oi! Conseguiu encontrar?
[Customer]: Sim, mas acho que podia ser mais organizado.
[Support Agent]: Tipo com status e datas mais visíveis?
[Customer]: Isso!
[Support Agent]: Excelente sugestão. Vou anotar.
[Customer]: Obrigada.
[Support Agent]: Agradecemos muito!
CHAT

<<~CHAT,
[Customer]: Oi!
[Support Agent]: Oi 😊
[Customer]: Seria legal filtrar sapatos por ocasião: trabalho, festa…
[Support Agent]: Que ótima ideia!
[Customer]: Facilita muito pra escolher.
[Support Agent]: Vou registrar essa sugestão agora.
[Customer]: Obrigada.
[Support Agent]: Nós que agradecemos!
CHAT

<<~CHAT,
[Customer]: Oi, tudo bem?
[Support Agent]: Oi! Tudo sim 😊
[Customer]: Vocês já pensaram em programa de pontos?
[Support Agent]: Ótima sugestão! Isso te incentivaria a comprar mais?
[Customer]: Com certeza.
[Support Agent]: Vou encaminhar essa ideia.
[Customer]: Obrigada!
[Support Agent]: Feedback excelente.
CHAT

<<~CHAT,
[Customer]: Oi!
[Support Agent]: Oi 😊
[Customer]: A busca podia entender melhor quando a gente digita algo.
[Support Agent]: Tipo sinônimos?
[Customer]: Isso!
[Support Agent]: Ótimo ponto. Vou registrar.
[Customer]: Obrigada.
[Support Agent]: Muito válido!
CHAT

<<~CHAT,
[Customer]: Olá!
[Support Agent]: Oi 😊
[Customer]: Senti falta de info sobre durabilidade dos produtos.
[Support Agent]: Tipo uso diário, material?
[Customer]: Sim.
[Support Agent]: Excelente insight. Vou anotar.
[Customer]: Obrigada!
[Support Agent]: Agradecemos muito.
CHAT

<<~CHAT,
[Customer]: Oi!
[Support Agent]: Oi 😊
[Customer]: Seria legal ter uma lista de desejos.
[Support Agent]: Pra salvar produtos?
[Customer]: Sim!
[Support Agent]: Ótima sugestão. Vou registrar.
[Customer]: Obrigada.
[Support Agent]: Feedback anotado!
CHAT

<<~CHAT,
[Customer]: Oi!
[Support Agent]: Oi 😊
[Customer]: Promoções baseadas no que já comprei seriam legais.
[Support Agent]: Personalizadas, né?
[Customer]: Exatamente.
[Support Agent]: Excelente ideia. Vou repassar.
[Customer]: Obrigada!
[Support Agent]: Agradecemos o insight.
CHAT

<<~CHAT,
[Customer]: Oi! Uso muito o site no celular.
[Support Agent]: Oi 😊
[Customer]: Acho que algumas páginas podiam ser mais rápidas.
[Support Agent]: Entendo. Isso atrapalha a compra?
[Customer]: Um pouco, sim.
[Support Agent]: Obrigada por avisar. Vou registrar essa melhoria.
[Customer]: Que bom!
[Support Agent]: Feedback super importante.
CHAT
]
product_insights.each do |conversation|
  Conversation.create!(
    channel: "Whatsapp",
    content: conversation,
    user: user,
    occurred_on: random_date(start_date, end_date)
  )
end

questions = [

<<~CHAT,
[Customer]: Oi! Tudo bem?
[Support Agent]: Oi! Tudo sim 😊 Como posso ajudar?
[Customer]: Estou interessada num tênis, mas fiquei na dúvida sobre a forma.
[Support Agent]: Claro! Qual modelo você está vendo?
[Customer]: O Urban Flex. Ele tem forma normal?
[Support Agent]: Sim, forma padrão. Se ficar entre dois números, indicamos o maior.
[Customer]: Ele aperta nos lados?
[Support Agent]: Não costuma apertar, é bem confortável.
[Customer]: Ótimo, obrigada!
[Support Agent]: Por nada! Qualquer dúvida, estou aqui 😊
CHAT

<<~CHAT,
[Customer]: Oi, posso tirar uma dúvida?
[Support Agent]: Claro! Fique à vontade 😊
[Customer]: A sandália Aurora é de couro?
[Support Agent]: Sim, ela é confeccionada em couro legítimo.
[Customer]: E a palmilha também?
[Support Agent]: A palmilha é sintética, macia e confortável.
[Customer]: Ela esquenta muito?
[Support Agent]: Não, o material permite boa ventilação.
[Customer]: Perfeito!
[Support Agent]: Fico feliz em ajudar 😊
CHAT

<<~CHAT,
[Customer]: Oi! Se eu errar o tamanho, posso trocar?
[Support Agent]: Pode sim 😊
[Customer]: Tem custo?
[Support Agent]: A primeira troca por tamanho é gratuita.
[Customer]: Existe prazo?
[Support Agent]: Sim, até 7 dias após o recebimento.
[Customer]: Precisa estar sem uso?
[Support Agent]: Sim, com etiqueta e embalagem original.
[Customer]: Entendi.
[Support Agent]: Qualquer coisa, estamos aqui!
CHAT

<<~CHAT,
[Customer]: Oi! Qual o prazo de entrega?
[Support Agent]: Oi 😊 Para qual CEP?
[Customer]: 13045-900.
[Support Agent]: Para esse CEP, o prazo é de 5 a 7 dias úteis.
[Customer]: Dá pra chegar antes?
[Support Agent]: Depende da transportadora, não conseguimos garantir.
[Customer]: Entendi.
[Support Agent]: Qualquer outra dúvida, é só chamar!
CHAT

<<~CHAT,
[Customer]: Oi! Os produtos têm garantia?
[Support Agent]: Sim 😊
[Customer]: Por quanto tempo?
[Support Agent]: 90 dias contra defeito de fabricação.
[Customer]: E se descolar a sola?
[Support Agent]: Aí a garantia cobre, sim.
[Customer]: Que bom.
[Support Agent]: Prezamos muito pela qualidade!
CHAT

<<~CHAT,
[Customer]: Oi! Tem alguma promoção agora?
[Support Agent]: Oi 😊 Temos 10% OFF na primeira compra.
[Customer]: Como uso?
[Support Agent]: Basta se cadastrar e aplicar o cupom no checkout.
[Customer]: Funciona pra tudo?
[Support Agent]: Exceto produtos já remarcados.
[Customer]: Perfeito.
[Support Agent]: Aproveite 😊
CHAT

<<~CHAT,
[Customer]: Posso parcelar a compra?
[Support Agent]: Pode sim 😊
[Customer]: Em quantas vezes?
[Support Agent]: Até 6x sem juros no cartão.
[Customer]: Tem valor mínimo?
[Support Agent]: Não, qualquer valor.
[Customer]: Ótimo.
[Support Agent]: Qualquer dúvida, estou aqui!
CHAT

<<~CHAT,
[Customer]: Esse modelo é confortável pra usar o dia todo?
[Support Agent]: Sim 😊
[Customer]: Mesmo ficando muito tempo em pé?
[Support Agent]: Sim, ele tem palmilha acolchoada.
[Customer]: Ele machuca?
[Support Agent]: Não costuma machucar.
[Customer]: Que bom.
[Support Agent]: Vai amar!
CHAT

<<~CHAT,
[Customer]: Qual a altura do salto?
[Support Agent]: Esse modelo tem 6 cm.
[Customer]: É estável?
[Support Agent]: Sim, é salto bloco.
[Customer]: Dá pra usar bastante tempo?
[Support Agent]: Dá sim, é bem firme.
[Customer]: Ótimo.
[Support Agent]: Fico feliz em ajudar!
CHAT

<<~CHAT,
[Customer]: Esse sapato é impermeável?
[Support Agent]: Ele é resistente à água.
[Customer]: Dá pra usar na chuva?
[Support Agent]: Em chuva leve, sim.
[Customer]: Encharca fácil?
[Support Agent]: Não, mas não é totalmente impermeável.
[Customer]: Entendi.
[Support Agent]: Qualquer dúvida, só chamar.
CHAT

<<~CHAT,
[Customer]: O tênis é pesado?
[Support Agent]: Não, é bem leve.
[Customer]: Dá pra caminhar bastante?
[Support Agent]: Sim, foi pensado para isso.
[Customer]: Ótimo.
[Support Agent]: Vai servir muito bem!
[Customer]: Obrigada.
[Support Agent]: De nada 😊
CHAT

<<~CHAT,
[Customer]: Vocês enviam nota fiscal?
[Support Agent]: Sim 😊
[Customer]: Vai por e-mail?
[Support Agent]: Sim, automaticamente.
[Customer]: E junto com o pedido?
[Support Agent]: Também vai na embalagem.
[Customer]: Perfeito.
[Support Agent]: Qualquer coisa, estamos aqui.
CHAT

<<~CHAT,
[Customer]: Posso cancelar um pedido?
[Support Agent]: Pode sim.
[Customer]: Mesmo depois de pagar?
[Support Agent]: Sim, se ainda não foi enviado.
[Customer]: Como faço?
[Support Agent]: É só informar o número do pedido.
[Customer]: Entendi.
[Support Agent]: Ficamos à disposição.
CHAT

<<~CHAT,
[Customer]: O número 39 está esgotado?
[Support Agent]: No momento, sim.
[Customer]: Vai voltar?
[Support Agent]: Temos reposição prevista.
[Customer]: Vocês avisam?
[Support Agent]: Sim, posso te cadastrar.
[Customer]: Quero sim.
[Support Agent]: Perfeito!
CHAT

<<~CHAT,
[Customer]: Qual a diferença entre Luna e Bella?
[Support Agent]: O Luna é mais casual.
[Customer]: E o Bella?
[Support Agent]: Mais social.
[Customer]: Conforto muda?
[Support Agent]: Não, é o mesmo.
[Customer]: Entendi.
[Support Agent]: Qualquer dúvida, me chama.
CHAT

<<~CHAT,
[Customer]: Os sapatos são nacionais?
[Support Agent]: Sim 😊
[Customer]: Fabricados onde?
[Support Agent]: No Brasil.
[Customer]: Que legal.
[Support Agent]: Prezamos muito por isso.
[Customer]: Gostei.
[Support Agent]: Ficamos felizes!
CHAT

<<~CHAT,
[Customer]: Tem ajuste no tornozelo?
[Support Agent]: Sim.
[Customer]: Dá pra regular bem?
[Support Agent]: Sim, com fivela.
[Customer]: Não fica largo?
[Support Agent]: Não costuma.
[Customer]: Ótimo.
[Support Agent]: Qualquer dúvida, estou aqui.
CHAT

<<~CHAT,
[Customer]: Vocês têm frete grátis?
[Support Agent]: Sim 😊
[Customer]: A partir de quanto?
[Support Agent]: Compras acima de R$299.
[Customer]: Para todo o Brasil?
[Support Agent]: Sim.
[Customer]: Perfeito.
[Support Agent]: Aproveite!
CHAT

<<~CHAT,
[Customer]: E se vier com defeito?
[Support Agent]: Fazemos a troca.
[Customer]: Sem custo?
[Support Agent]: Sim.
[Customer]: Mesmo depois de usar?
[Support Agent]: Se for defeito de fabricação, sim.
[Customer]: Entendi.
[Support Agent]: Qualquer problema, nos chame.
CHAT

<<~CHAT,
[Customer]: Vocês têm modelo pra pés sensíveis?
[Support Agent]: Temos sim.
[Customer]: Qual indica?
[Support Agent]: Modelos com palmilha anatômica.
[Customer]: Algum específico?
[Support Agent]: Comfort Soft.
[Customer]: Obrigada.
[Support Agent]: De nada 😊
CHAT

<<~CHAT,
[Customer]: Dá pra usar no trabalho?
[Support Agent]: Sim.
[Customer]: Mesmo o dia inteiro?
[Support Agent]: Sim, é bem confortável.
[Customer]: Não machuca?
[Support Agent]: Não costuma.
[Customer]: Ótimo.
[Support Agent]: Vai atender bem!
CHAT

<<~CHAT,
[Customer]: Posso trocar por outra cor?
[Support Agent]: Pode sim.
[Customer]: Mesmo tamanho?
[Support Agent]: Sim.
[Customer]: Tem custo?
[Support Agent]: A primeira troca é gratuita.
[Customer]: Que bom.
[Support Agent]: Ficamos à disposição.
CHAT

<<~CHAT,
[Customer]: Tenho cupom de primeira compra?
[Support Agent]: Sim 😊
[Customer]: Como recebo?
[Support Agent]: Após se cadastrar no site.
[Customer]: É automático?
[Support Agent]: Sim.
[Customer]: Perfeito.
[Support Agent]: Aproveite!
CHAT

<<~CHAT,
[Customer]: Demora pra separar o pedido?
[Support Agent]: Não.
[Customer]: Quanto tempo?
[Support Agent]: Até 24h úteis.
[Customer]: Depois vai pra envio?
[Support Agent]: Isso mesmo.
[Customer]: Entendi.
[Support Agent]: Qualquer dúvida, só chamar.
CHAT

<<~CHAT,
[Customer]: A embalagem é discreta?
[Support Agent]: Sim.
[Customer]: Dá pra enviar como presente?
[Support Agent]: Sim 😊
[Customer]: Vai nota junto?
[Support Agent]: Não aparece valor externo.
[Customer]: Ótimo.
[Support Agent]: Vai ficar perfeito!
CHAT

<<~CHAT,
[Customer]: Vocês têm numeração grande?
[Support Agent]: Temos até 42.
[Customer]: E pequena?
[Support Agent]: A partir do 33.
[Customer]: Que bom.
[Support Agent]: Atendemos vários perfis.
[Customer]: Gostei.
[Support Agent]: Fico feliz!
CHAT

<<~CHAT,
[Customer]: Material sintético dura?
[Support Agent]: Sim.
[Customer]: Não descasca?
[Support Agent]: Com uso normal, não.
[Customer]: Precisa de cuidado?
[Support Agent]: Apenas limpeza básica.
[Customer]: Ok.
[Support Agent]: Qualquer dúvida, estou aqui.
CHAT

<<~CHAT,
[Customer]: Precisa lacear?
[Support Agent]: Um pouco.
[Customer]: Machuca no começo?
[Support Agent]: Normalmente não.
[Customer]: Recomenda usar em casa?
[Support Agent]: Sim, ajuda a adaptar.
[Customer]: Entendi.
[Support Agent]: Boa escolha!
CHAT

<<~CHAT,
[Customer]: Vocês trabalham com estoque próprio?
[Support Agent]: Sim.
[Customer]: Não é marketplace?
[Support Agent]: Não.
[Customer]: Então enviam direto?
[Support Agent]: Isso mesmo.
[Customer]: Ótimo.
[Support Agent]: Mais segurança 😊
CHAT

<<~CHAT,
[Customer]: Posso tirar dúvidas depois da compra?
[Support Agent]: Claro!
[Customer]: Por onde?
[Support Agent]: WhatsApp, Instagram ou e-mail.
[Customer]: Horário comercial?
[Support Agent]: Sim.
[Customer]: Perfeito.
[Support Agent]: Sempre à disposição 💛
CHAT
]

questions.each do |conversation|
  Conversation.create!(
    channel: "Whatsapp",
    content: conversation,
    user: user,
    occurred_on: random_date(start_date, end_date)
  )
end
