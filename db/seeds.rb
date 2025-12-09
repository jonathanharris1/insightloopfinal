Conversation.destroy_all
User.destroy_all
Classification.destroy_all

user = User.create!(email: "saunier2@gmail.com", password: "123456")

Classification.create!(
  tag: "Atraso na Entrega",
  tag_description: "Use esta tag quando o cliente relata atraso no pedido ou que ainda não recebeu a encomenda."
)

Classification.create!(
  tag: "Troca de Tamanho",
  tag_description: "Use esta tag quando o cliente deseja trocar o tamanho de um produto ou recebeu um tamanho incorreto."
)

Classification.create!(
  tag: "Erro no Cupom",
  tag_description: "Use esta tag quando o cupom não funciona, dá inválido ou o desconto não é aplicado."
)

Classification.create!(
  tag: "Solicitação de NF",
  tag_description: "Use esta tag quando o cliente pede nota fiscal ou tem dúvidas relacionadas à emissão da NF."
)

Classification.create!(
  tag: "Dúvida de Produto",
  tag_description: "Use esta tag quando o cliente tem perguntas sobre características, uso, material ou detalhes do produto."
)

Classification.create!(
  tag: "Rastreamento",
  tag_description: "Use esta tag quando o cliente solicita código de rastreio, status do envio, localização do pedido ou problemas para visualizar rastreamento."
)

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

Conversation.create!(channel: "Whatsapp", content: conversas, user: user)

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

Conversation.create!(channel: "Instagram", content: conversas_2, user: user)

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

Conversation.create!(channel: "RA", content: conversas_3, user: user)

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

Conversation.create!(channel: "Whatsapp", content: conversas_4, user: user)

conversas_5 = <<~CHAT5
  [Customer]: Bom dia. Estou tentando rastrear meu pedido há 3 dias e o site da transportadora não atualiza. O prazo de entrega era para ontem, dia 01/12, e até agora nada.
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

Conversation.create!(channel: "Instagram", content: conversas_5, user_id: user.id)


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
Conversation.create!(channel: "Whatsapp", content: conversas_6, user_id: user.id)

conversas_7 = <<~CHAT7
[Customer]: Oi, boa tarde. Fiz o pedido #BF-10291 no dia 03/02, um Sneaker BreezeLite – tamanho 38, e a previsão era 06/02. Hoje já é 10/02 e nada. O tracking não muda há 3 dias. Vou mandar o print aqui — imagina screenshot —.
[Support Agent]: Boa tarde! Sinto muito mesmo pelo transtorno. Obrigada por enviar o print, ele ajuda bastante. Vou verificar o que ocorreu com a transportadora. Só um instante, por favor.
[Customer]: Claro… mas já estou bem chateada. Preciso desse tênis para treinar porque o meu atual está com a sola abrindo. E o status só aparece “em transferência”.
[Support Agent]: Entendo totalmente sua frustração. Verifiquei aqui e identifiquei um atraso no centro de distribuição de Guarulhos devido a readequação de rotas. Já abri um chamado solicitando urgência na liberação.
[Customer]: Isso significa que ainda vai demorar? Porque já passou muito do prazo...
[Support Agent]: Pela previsão atualizada, a transportadora informou entrega entre amanhã e 12/02. Assim que houver atualização, te aviso imediatamente.
[Customer]: Tá bom… espero mesmo que chegue. Obrigada.
[Support Agent]: Eu que agradeço pela compreensão! Vamos acompanhar juntas até a entrega chegar certinho.
CHAT7
Conversation.create!(channel: "Instagram", content: conversas_7, user_id: user.id)


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
Conversation.create!(channel: "Instagram", content: conversas_8, user_id: user.id)

conversas_9 = <<~CHAT9
[Customer]: Oi! O meu pedido #BF-77201 com o Tênis AirFlex Motion – 37 deveria ter sido entregue no dia 02/02. Já estamos no dia 08/02 e nem sinal. O app dos Correios mostra “ processamento interno”.
[Support Agent]: Oi! Lamento demais pelo atraso. Esse status realmente indica retenção no centro logístico. Vou verificar o motivo.
[Customer]: Tá bom, mas eu precisava dele para uma viagem… e vou amanhã. Acho que não vai chegar a tempo né?
[Support Agent]: Olhei aqui: a transportadora informou uma fila de liberação aduaneira, mas o item já está liberado desde hoje cedo. Previsão de entrega: 09 ou 10/02.
[Customer]: Poxa… queria usar na viagem. 😔
[Support Agent]: Sinto muito mesmo. Se não chegar a tempo, posso te oferecer reembolso parcial como compensação.
[Customer]: Entendi. Me avisa qualquer mudança, por favor.
[Support Agent]: Aviso sim! Estou acompanhando de perto.
CHAT9
Conversation.create!(channel: "RA", content: conversas_9, user_id: user.id)

conversas_10 = <<~CHAT10
[Customer]: Boa noite. O pedido #BF-42109 era para chegar hoje cedo. Um Slingback ElegantSoft – 35. No tracking está: “falha na tentativa de entrega — cliente ausente”. Eu estava em casa o dia todo!
[Support Agent]: Boa noite! Sinto muito por essa informação incorreta. Isso acontece quando a rota está atrasada e o entregador não consegue finalizar todas as entregas.
[Customer]: Mas por que marcaram como “ausente”? Isso atrapalha totalmente.
[Support Agent]: Concordo. Já solicitei nova tentativa para amanhã até 18h. Vou pedir para não depender de confirmação manual do entregador.
[Customer]: Obrigada, espero que dessa vez venha mesmo.
[Support Agent]: Vai sim! Te mantenho informada.
CHAT10
Conversation.create!(channel: "Whatsapp", content: conversas_10, user_id: user.id)

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
Conversation.create!(channel: "RA", content: conversas_11, user_id: user.id)


conversas_12 = <<~CHAT12
Customer: Oi, boa tarde. Meu pedido #BF-66721 do Tênis Running AirMesh – 40 está atrasado. Comprei dia 28/01, previsão 31/01. Hoje é 06/02 e não chegou. O tracking não atualiza desde 02/02.
Support Agent: Boa tarde! Sinto muito pelo transtorno. Deixa eu verificar diretamente com a transportadora o que aconteceu.
Customer: Obrigado. Eu comprei para começar fisioterapia e estou tendo que adiar por causa disso. 😕
Support Agent: Entendo completamente. Aqui aparece que o pacote está em processo de reencaminhamento de rota, o que acontece quando há excesso de carga no caminhão.
Customer: Nossa, mas isso demora tanto assim?
Support Agent: Geralmente não, mas houve uma sobrecarga no hub de Curitiba. A nova previsão é entre 07 e 08/02.
Customer: Tá certo… fico no aguardo. Se puder me avisar quando mudar o status, agradeço.
Support Agent: Pode deixar! Vou acompanhar de perto e atualizar você.
CHAT12
Conversation.create!(channel: "Instagram", content: conversas_12, user_id: user.id)

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
Conversation.create!(channel: "RA", content: conversas_13, user_id: user.id)

conversas_14 = <<~CHAT14
Customer: Oi! Pedido #BF-51022, Coturno TrailUrban – 39. Tava previsto para ontem, 05/02. Recebi notificação dizendo “destinatário ausente”, mas eu estava literalmente na porta de casa na hora do suposto horário da tentativa.
Support Agent: Oi! Sinto muito por isso. Esse registro costuma aparecer quando a rota do entregador está incompleta e ele não consegue finalizar as entregas.
Customer: Mas isso é muito chato… já aconteceu com outra compra de vocês. 😤
Support Agent: Imagino a frustração. Já solicitei nova tentativa para hoje até 20h e deixei observação de que o cliente está disponível.
Customer: Tá. Mas será que realmente vão vir? Não quero esperar à toa de novo.
Support Agent: Sim, já conversei com o supervisor da rota. Eles se comprometeram a tentar novamente hoje.
Customer: Então vou aguardar. Obrigado.
Support Agent: Qualquer atualização, eu te escrevo.
CHAT14
Conversation.create!(channel: "Whatsapp", content: conversas_14, user_id: user.id)

conversas_15 = <<~CHAT15
Customer: Oi, tudo bem? Meu pedido #BF-20118, o Slip On CloudStep – 37, já está há 4 dias parado como “objeto não localizado no fluxo”. Isso quer dizer que sumiu?
Support Agent: Oi! Obrigada por avisar. Esse status indica que o pacote não foi escaneado corretamente na última movimentação. Vou confirmar se está em processo de busca.
Customer: Porque estou preocupada… é presente de aniversário e já está super atrasado.
Support Agent: Verifiquei aqui e sim, ele entrou em procedimento de varredura interna na transportadora. Eles costumam localizar em até 48h.
Customer: Espero mesmo, porque não posso esperar semanas.
Support Agent: Concordo totalmente. Se não localizarem até amanhã, envio um novo produto para você.
Customer: Aí sim, obrigada. Me avisa por favor.
Support Agent: Pode deixar! Estou acompanhando de perto.
CHAT15
Conversation.create!(channel: "RA", content: conversas_15, user_id: user.id)

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
Conversation.create!(channel: "Whatsapp", content: conversas_16, user_id: user.id)

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
Conversation.create!(channel: "RA", content: conversas_17, user_id: user.id)

conversas_18 = <<~CHAT18
Customer: Oi, boa tarde. Pedido #BF-21881, Scarpin SoftTouch – 34. O entregador marcou que “não conseguiu acesso ao condomínio”. Mas não é verdade — portaria funciona 24h.
Support Agent: Boa tarde! Isso realmente não faz sentido. Sinto muito por esse registro incorreto. Vou abrir reclamação com a rota.
Customer: Aconteceu às 10h da manhã e eu estava até na portaria!
Support Agent: Falei com a transportadora: foi erro de registro automático. Nova tentativa agendada para hoje até 21h.
Customer: Tá, vou aguardar. Só não quero ficar esperando à toa.
Support Agent: Entendo totalmente. Estou monitorando. Assim que o status mudar, te aviso.
Support Agent: Sempre à disposição.
CHAT18
Conversation.create!(channel: "Whatsapp", content: conversas_18, user_id: user.id)

conversas_19 = <<~CHAT19
Customer: Oi! Pedi o Mocassim UrbanComfort – 39, pedido #BF-51004. Era pra chegar ontem, mas agora o status diz: “pedido retido para inspeção manual”. Isso é preocupante?
Support Agent: Oi! Obrigada por chamar. Esse status significa apenas uma análise extra por parte da transportadora. Vou descobrir o motivo específico.
Customer: Fiquei assustada, nunca vi isso.
Support Agent: Eles informaram que houve uma divergência de peso na triagem, então abriram para conferir. Produto sem dano.
Customer: Ufa. Mas e a entrega?
Support Agent: Reprogramada para 08/02.
Customer: Certo. Obrigada pela transparência.
CHAT19
Conversation.create!(channel: "RA", content: conversas_19, user_id: user.id)


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
Conversation.create!(channel: "RA", content: conversas_20, user_id: user.id)

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
Conversation.create!(channel: "Whatsapp", content: conversas_21, user_id: user.id)

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
Conversation.create!(channel: "Instagram", content: conversas_22, user_id: user.id)

conversas_23 = <<~CHAT23
[Customer]: Olá, tudo certo? Fiz o pedido #BF-88117, o Tênis CloudGrip – 38. O status fica alternando entre “em trânsito” e “aguardando fiscalização”. É normal isso?
[Support Agent]: Olá! Obrigada por avisar. Não, essa alternância não deveria acontecer. Vou checar com a transportadora.
[Customer]: Porque já está com 3 dias de atraso… achei estranho demais.
[Support Agent]: Recebi retorno: houve uma falha no sistema de atualização deles, mas o pacote está liberado.
[Customer]: Então não está preso na fiscalização?
[Support Agent]: Não, felizmente não. Previsão de entrega: 09/02.
[Customer]: Ufa. Obrigada pela verificação!
[Support Agent]: Sempre que precisar, é só me chamar.
CHAT23
Conversation.create!(channel: "RA", content: conversas_23, user_id: user.id)

conversas_24 = <<~CHAT24
[Customer]: Boa noite. Pedido #BF-41222, Bota WinterSoft – 37. Está parado há 6 dias com status “roteirização pendente”. Isso é o quê?
[Support Agent]: Boa noite! Esse status significa que o pacote chegou na unidade, mas não entrou na rota de entrega. Vou confirmar por quê.
[Customer]: Porque comprei para viajar sábado, e acho que não vai chegar mais…
[Support Agent]: Falei com o centro de distribuição: houve atraso no processamento manual. Eles garantiram inclusão na rota de amanhã.
[Customer]: Amanhã mesmo?
[Support Agent]: Sim, entre 12h e 18h.
[Customer]: Tá… vou confiar. Obrigada.
[Support Agent]: Qualquer mudança te aviso prontamente.
CHAT24
Conversation.create!(channel: "RA", content: conversas_24, user_id: user.id)

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
Conversation.create!(channel: "Whatsapp", content: conversas_25, user_id: user.id)

conversas_26 = <<~CHAT26
[Customer]: Boa tarde! O pedido #BF-10007, Sandália SoftChic – 35, está parado desde 01/02 com o status “falha na triagem”. A entrega era para 03/02.
[Support Agent]: Boa tarde! Obrigada por relatar. Vou verificar o que ocorreu na triagem.
[Customer]: Eu nunca vi esse tipo de status. Achei que o pacote tivesse quebrado ou algo assim.
[Support Agent]: Não, fique tranquila. “Falha na triagem” geralmente é erro de leitura no sistema. Pedi que o item seja reprocessado.
[Customer]: E a nova previsão?
[Support Agent]: Eles informaram que a entrega deve ocorrer até 09/02.
[Customer]: Ok… vou aguardar então. Obrigada.
[Support Agent]: Estou acompanhando e te aviso qualquer novidade.
CHAT26
Conversation.create!(channel: "Instagram", content: conversas_26, user_id: user.id)

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
Conversation.create!(channel: "Whatsapp", content: conversas_27, user_id: user.id)

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
Conversation.create!(channel: "Whatsapp", content: conversas_28, user_id: user.id)

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
Conversation.create!(channel: "Instagram", content: conversas_29, user_id: user.id)
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
Conversation.create!(channel: "Whatsapp", content: conversas_30, user_id: user.id)

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

Conversation.create!(channel: "RA", content: conversas_31, user_id: user.id)

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

Conversation.create!(channel: "Instagram", content: conversas_32, user_id: user.id)

conversas_33 = <<~CHAT33
 [Customer]: Eu sei que já usei dentro de casa, mas veio no tamanho errado 😔
 [Support Agent]: Fique tranquila, provar não invalida a troca. Qual seu pedido?
 [Customer]: BF-93450. Pedi 40, veio 38.
 [Support Agent]: Obrigada! Vou verificar agora.
 [Support Agent]: Confirmado o erro de tamanho. A troca é autorizada sem custos pra você.
 [Customer]: Ai, ainda bem… achei que ia perder meu dinheiro.
 [Support Agent]: Jamais! Vamos resolver isso direitinho.

CHAT33

Conversation.create!(channel: "Whatsapp", content: conversas_33, user_id: user.id)

conversas_34 = <<~CHAT34
 [Customer]: Oi, acabei de abrir meu pedido aqui no trabalho e veio errado.
 [Support Agent]: Oi! Me conta o que houve.
 [Customer]: Pedido BF-90218. Pedi 35, veio 37.
 [Support Agent]: Entendi. Você consegue me mandar foto da etiqueta da caixa quando chegar em casa?
 [Customer]: Consigo sim, agora não tenho como.
 [Support Agent]: Sem problemas, já deixo o protocolo aberto pra adiantar.
CHAT34

Conversation.create!(channel: "Instagram", content: conversas_34, user_id: user.id)

conversas_35 = <<~CHAT35
 [Customer]: Se não tiver mais meu tamanho, eu faço o quê?
 [Support Agent]: Vamos verificar agora. Qual pedido?
 [Customer]: BF-91844. Pedi 38, veio 36.
 [Support Agent]: Temos apenas 1 unidade no 38 ainda disponível.
 [Customer]: Ai, então separa pra mim pelo amor de Deus
 [Support Agent]: Já deixei reservado no sistema, fica tranquila.
CHAT35

Conversation.create!(channel: "RA", content: conversas_35, user_id: user.id)

conversas_36 = <<~CHAT36
 [Customer]: E se o correio perder meu produto na devolução?
 [Support Agent]: Fique tranquila, o envio é segurado e rastreado.
 [Customer]: Porque é a primeira vez que eu troco online.
 [Support Agent]: Entendo o medo, mas você estará protegida do início ao fim.

CHAT36

Conversation.create!(channel: "Instagram", content: conversas_36, user_id: user.id)

conversas_37 = <<~CHAT37
 [Customer]: Já faz 9 dias que eu enviei a troca e ninguém responde.
 [Support Agent]: Peço mil desculpas pela demora 😞 Pode me passar o número da postagem?
 [Customer]: PX349201BR.
 [Support Agent]: Obrigada! Vejo aqui que chegou ontem no nosso CD.
 [Customer]: Só ontem??
 [Support Agent]: Sim, houve atraso da transportadora, infelizmente.
CHAT37

Conversation.create!(channel: "Instagram", content: conversas_37, user_id: user.id)

conversas_38 = <<~CHAT38
 [Customer]: Meu sapato da troca foi enviado pro endereço antigo 😡
 [Support Agent]: Nossa, sinto muito! Pode me confirmar o atual?
 [Customer]: Rua Bela Vista, 310.
 [Support Agent]: Aqui constou o endereço antigo mesmo. Vou solicitar correção imediata.
CHAT38

 Conversation.create!(channel: "Instagram", content: conversas_38, user_id: user.id)

conversas_39 = <<~CHAT39
 [Customer]: Já errou uma vez, eu não confio mais. Quero cancelar.
 [Support Agent]: Eu entendo sua frustração 😔 Quer que eu siga com estorno total?
 [Customer]: Quero sim.
 [Support Agent]: Perfeito, o valor será estornado em até 5 dias úteis no seu cartão.
 [Customer]: Tá bom. Obrigada.
 [Support Agent]: Sinto muito pela experiência e espero que possamos te atender melhor no futuro.
CHAT39

Conversation.create!(channel: "Whatsapp", content: conversas_39, user_id: user.id)

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

Conversation.create!(channel: "RA", content: conversas_40, user_id: user.id)

conversas_41 = <<~CHAT41
 [Customer]: Eu apliquei o cupom, mas mesmo assim foi cobrado o valor cheio 😡
 [Support Agent]: Sinto muito por isso 😔 Pode me enviar o número do pedido?
 [Customer]: BF-93011.
 [Support Agent]: Obrigada, estou verificando…
 [Support Agent]: Realmente o desconto não foi abatido. Houve falha na integração do pagamento.
 [Customer]: Nossa, isso é muito errado.
 [Support Agent]: Você está certa. Vou solicitar o estorno do valor do desconto imediatamente.
CHAT41

Conversation.create!(channel: "Instagram", content: conversas_41, user_id: user.id)

conversas_42 = <<~CHAT42
 [Customer]: O cupom entra no carrinho mas some quando vou pagar 😤
 [Support Agent]: Entendo, isso realmente gera muita frustração. Qual cupom você usou?
 [Customer]: BFVIP20.
 [Support Agent]: Esse cupom é exclusivo para clientes cadastrados no CPF promocional.
 [Customer]: Mas eu já comprei com vocês várias vezes.
 [Support Agent]: Sim, vejo seu histórico aqui. Vou liberar o desconto manualmente.
CHAT42

Conversation.create!(channel: "Instagram", content: conversas_42, user_id: user.id)

conversas_43 = <<~CHAT43
 [Customer]: No celular o cupom não aplica, só no site normal.
 [Support Agent]: Obrigada por avisar. Isso ajuda muito a gente!
 [Customer]: Eu só consegui testar agora no notebook.
 [Support Agent]: É um bug específico na versão mobile, já está em correção.
 [Customer]: Mas eu perdi a promoção 😔
 [Support Agent]: Não vai perder. Vou gerar um cupom exclusivo válido por 24h pra você.
CHAT43

Conversation.create!(channel: "Whatsapp", content: conversas_43, user_id: user.id)

conversas_44 = <<~CHAT44
 [Customer]: Vi anúncio dizendo 20% OFF com cupom, mas não funciona!
 [Support Agent]: Entendo sua indignação 😔 Você lembra onde viu o anúncio?
 [Customer]: No Instagram de vocês, hoje de manhã.
 [Support Agent]: Obrigada! Vamos reportar isso para o marketing agora mesmo.
 [Customer]: Porque assim parece propaganda enganosa.
 [Support Agent]: Você tem razão. Vou garantir o desconto manualmente pra você agora.

CHAT44

Conversation.create!(channel: "Instagram", content: conversas_44, user_id: user.id)

conversas_45 = <<~CHAT45
 [Customer]: O cupom diz que é válido, mas não entra no meu pedido.
 [Support Agent]: Qual o modelo que você escolheu?
 [Customer]: Bota London Black 38.
 [Support Agent]: Esse modelo infelizmente está fora da campanha promocional.
 [Customer]: Mas isso não tava claro no site 😤
 [Support Agent]: Você tem razão. Vou liberar uma exceção pra você agora.
CHAT45


Conversation.create!(channel: "RA", content: conversas_45, user_id: user.id)

conversas_46 = <<~CHAT46
 [Customer]: Eu já tentei esse cupom umas 6 vezes, nada funciona.
 [Support Agent]: Nossa, sinto muito por isso 😔 Qual cupom é?
 [Customer]: BFMAIO15.
 [Support Agent]: Ele atingiu o limite máximo de usos hoje.
 [Customer]: Então por que continua aparecendo no site?
 [Support Agent]: Ótima observação. Vou repassar isso agora para o time responsável.

CHAT46

Conversation.create!(channel: "Instagram", content: conversas_46, user_id: user.id)

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

Conversation.create!(channel: "RA", content: conversas_47, user_id: user.id)
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

Conversation.create!(channel: "Instagram", content: conversas_48, user_id: user.id)

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

Conversation.create!(channel: "RA", content: conversas_49, user_id: user.id)

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

Conversation.create!(channel: "Whatsapp", content: conversas_50, user_id: user.id)
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

Conversation.create!(channel: "Whatsapp", content: conversas_51, user_id: user.id)

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

Conversation.create!(channel: "Instagram", content: conversas_52, user_id: user.id)

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

Conversation.create!(channel: "Instagram", content: conversas_53, user_id: user.id)
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

Conversation.create!(channel: "Whatsapp", content: conversas_54, user_id: user.id)

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

Conversation.create!(channel: "Whatsapp", content: conversas_55, user_id: user.id)

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

Conversation.create!(channel: "RA", content: conversas_56, user_id: user.id)
