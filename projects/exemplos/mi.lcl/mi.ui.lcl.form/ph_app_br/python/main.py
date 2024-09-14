
# Este código em Python utiliza a biblioteca OpenAI para interagir com o serviço GPT-3.5-turbo, 
# que é um modelo de linguagem desenvolvido pela OpenAI. O código cria um assistente virtual 
# chamado "Sara" programado para agir como uma secretária virtual de um médico, com o 
# objetivo de auxiliar nas tarefas diárias de um consultório médico.
# O objetivo final é simular uma interação entre o usuário e a assistente virtual, onde o usuário 
# faz uma pergunta sobre o primeiro horário disponível, e a assistente fornece uma resposta com base 
# no modelo de linguagem GPT-3.5-turbo.

# Importa a classe OpenAI e coloca no objeto openai
from openai import OpenAI

# Conecta-se ao site da OpenAi 
client = OpenAI(api_key="")

# Executa o contructor create para criar um assistente.
assistant = client.beta.assistants.create(
    name="Sara",
    instructions='Você é uma secretária virtual de um médico, programada para auxiliar nas tarefas '+
                 'diárias de um consultório médico com eficiência e profissionalismo. Suas principais '+
                 'responsabilidades e habilidades são: Gestão de Agenda e Compromissos: Você deve '+
                 'gerenciar a agenda do médico de forma organizada, agendando consultas, enviando '+
                 'lembretes de compromissos e ajustando horários conforme necessário, mantendo sempre '+
                 'a eficiência e a pontualidade.',
    tools=[{"type": "code_interpreter"}],
    model="gpt-3.5-turbo"
)

# Criar um Thread
# Um "thread" é criado para armazenar a conversa entre o usuário e o assistente.
thread = client.beta.threads.create()

# Adicionar mensagem ao Thread
# Uma mensagem é adicionada ao thread, simulando uma pergunta do usuário: "Qual é o primeiro horário disponível?"
message = client.beta.threads.messages.create(
    thread_id=thread.id,
    role="user",
    content="Qual é o primeiro horário disponível?"
)

# Rodar a secretária e recuperar a resposta
# O código executa o assistente para gerar uma resposta com base na mensagem do usuário.
run = client.beta.threads.runs.create(
    thread_id=thread.id,
    assistant_id=assistant.id
)

# Recuperar as mensagens da Thread
# Todas as mensagens trocadas no thread são recuperadas.
messages = client.beta.threads.messages.list(
    thread_id=thread.id,
)

# Imprimir as mensagens em ordem reversa
# O código imprime as mensagens em ordem reversa, exibindo o papel (role) da mensagem 
# (se é do usuário ou do assistente) e o conteúdo da mensagem.
for msg in reversed(messages.data):
    # Verificar a estrutura de 'content' e adaptar conforme necessário
    if isinstance(msg.content, str):
        print(msg.role + ": " + msg.content)
    elif isinstance(msg.content, list) and len(msg.content) > 0:
        # Converter 'Text' para string antes de concatenar
        print(msg.role + ": " + str(msg.content[0].text))

