<div class="header" id="myHeader">
  <div class="navbar" w3-include-html="/menu.inc"> </div>
</div>
<div class="title"><script> document.write(document.title);</script></div>  
<main>
<!-- markdownlint-disable-next-line -->
<span id="topo"><span>

# Bancos de dados do projeto

## Requisitos das tabelas

1. Medicos
    1. Id
    2. Nome
    3. Telefone
    4. Telefone_da_secretaria
    5. Login
    6. Senha

2. Serviço_de_agendas
    1. id
    2. Nome
    3. Login
    4. Senha

3. Convênios
    1. Id
    2. Nome
    3. Login
    4. Senha

4. clientes
    1. Id;
    2. Nome;
    3. Telefone_WhatsApp;
    4. e-mail
    5. Login
    6. senha
    7. Id_Convenio

5. Integração
    1. id
    2. endereço_do_site
    3. login
    4. senha
    5. status // Usado para saber o se o site está conectado

6. Expediente_do_medico_data
    1. id
    2. Data

7. Expediente_do_medico_horas
    1. Id_Expediente_do_medico_Data
    2. Hora_inicial
    3. Hora_final

8. Disponibilidade_do_Paciente
    1. Id
    2. Data
    3. Hora

9. Agenda
    1. Id
    2. Id_Medico
    3. Id_Cliente
    4. Data
    5. Hora
    6. Id_Convenio
    7. Natureza_da_Interação
    8. Observações

## Script SQL para criar as tabelas com base nos requisitos fornecidos:

1. Script sql

    ```sql

        -- Tabela Medicos
        CREATE TABLE Medicos (
            Id SERIAL PRIMARY KEY,
            Nome VARCHAR(255) NOT NULL,
            Telefone VARCHAR(15),
            Telefone_da_secretaria VARCHAR(15),
            Login VARCHAR(50) UNIQUE NOT NULL,
            Senha VARCHAR(50) NOT NULL
        );

        -- Tabela Serviço_de_agendas
        CREATE TABLE Servico_de_agendas (
            Id SERIAL PRIMARY KEY,
            Nome VARCHAR(255) NOT NULL,
            Login VARCHAR(50) UNIQUE NOT NULL,
            Senha VARCHAR(50) NOT NULL
        );

        -- Tabela Convênios
        CREATE TABLE Convenios (
            Id SERIAL PRIMARY KEY,
            Nome VARCHAR(255) NOT NULL,
            Login VARCHAR(50) UNIQUE NOT NULL,
            Senha VARCHAR(50) NOT NULL
        );

        -- Tabela Clientes
        CREATE TABLE Clientes (
            Id SERIAL PRIMARY KEY,
            Nome VARCHAR(255) NOT NULL,
            Telefone_WhatsApp VARCHAR(15),
            Email VARCHAR(255),
            Login VARCHAR(50) UNIQUE NOT NULL,
            Senha VARCHAR(50) NOT NULL,
            Id_Convenio INTEGER REFERENCES Convenios(Id)
        );

        -- Tabela Integração
        CREATE TABLE Integracao (
            Id SERIAL PRIMARY KEY,
            Endereco_do_site VARCHAR(255) NOT NULL,
            Login VARCHAR(50) UNIQUE NOT NULL,
            Senha VARCHAR(50) NOT NULL,
            Status BOOLEAN NOT NULL
        );

        -- Tabela Expediente_do_medico_data
        CREATE TABLE Expediente_do_medico_data (
            Id SERIAL PRIMARY KEY,
            Data DATE NOT NULL
        );

        -- Tabela Expediente_do_medico_horas
        CREATE TABLE Expediente_do_medico_horas (
            Id_Expediente_do_medico_Data INTEGER REFERENCES Expediente_do_medico_data(Id),
            Hora_inicial TIME NOT NULL,
            Hora_final TIME NOT NULL
        );

        -- Tabela Disponibilidade_do_Paciente
        CREATE TABLE Disponibilidade_do_Paciente (
            Id SERIAL PRIMARY KEY,
            Data DATE NOT NULL,
            Hora TIME NOT NULL
        );

        -- Tabela Agenda
        CREATE TABLE Agenda (
            Id SERIAL PRIMARY KEY,
            Id_Medico INTEGER REFERENCES Medicos(Id),
            Id_Cliente INTEGER REFERENCES Clientes(Id),
            Data DATE NOT NULL,
            Hora TIME NOT NULL,
            Id_Convenio INTEGER REFERENCES Convenios(Id),
            Natureza_da_Interacao VARCHAR(255),
            Observacoes TEXT
        );

    ```

## Programa básico em Python para realizar operações CRUD (Create, Read, Update, Delete) na tabela de Médicos

1. Instalação de pacotes:

    ```bash

        mkdir NodeSequelize
        cd NodeSequelize

    ```

2. Programa para incluir, alterar, consultar e excluir cliente:

    ```python
    
    import psycopg2
    from psycopg2 import sql

    # Função para conectar ao banco de dados
    def conectar():
        return psycopg2.connect(
            dbname="seu_banco_de_dados",
            user="seu_usuario",
            password="sua_senha",
            host="localhost"
        )

    # Função para criar a tabela Medicos
    def criar_tabela_medicos(conexao):
        with conexao.cursor() as cursor:
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Medicos (
                    Id SERIAL PRIMARY KEY,
                    Nome VARCHAR(255) NOT NULL,
                    Telefone VARCHAR(15),
                    Telefone_da_secretaria VARCHAR(15),
                    Login VARCHAR(50) UNIQUE NOT NULL,
                    Senha VARCHAR(50) NOT NULL
                );
            """)
        conexao.commit()

    # Função para inserir um novo médico
    def inserir_medico(conexao, nome, telefone, telefone_secretaria, login, senha):
        with conexao.cursor() as cursor:
            cursor.execute("""
                INSERT INTO Medicos (Nome, Telefone, Telefone_da_secretaria, Login, Senha)
                VALUES (%s, %s, %s, %s, %s) RETURNING Id;
            """, (nome, telefone, telefone_secretaria, login, senha))
            medico_id = cursor.fetchone()[0]
        conexao.commit()
        return medico_id

    # Função para buscar todos os médicos
    def buscar_medicos(conexao):
        with conexao.cursor() as cursor:
            cursor.execute("SELECT * FROM Medicos;")
            medicos = cursor.fetchall()
        return medicos

    # Função para buscar um médico por ID
    def buscar_medico_por_id(conexao, medico_id):
        with conexao.cursor() as cursor:
            cursor.execute("SELECT * FROM Medicos WHERE Id = %s;", (medico_id,))
            medico = cursor.fetchone()
        return medico

    # Função para atualizar os dados de um médico
    def atualizar_medico(conexao, medico_id, nome, telefone, telefone_secretaria, login, senha):
        with conexao.cursor() as cursor:
            cursor.execute("""
                UPDATE Medicos
                SET Nome = %s, Telefone = %s, Telefone_da_secretaria = %s, Login = %s, Senha = %s
                WHERE Id = %s;
            """, (nome, telefone, telefone_secretaria, login, senha, medico_id))
        conexao.commit()

    # Função para excluir um médico por ID
    def excluir_medico(conexao, medico_id):
        with conexao.cursor() as cursor:
            cursor.execute("DELETE FROM Medicos WHERE Id = %s;", (medico_id,))
        conexao.commit()

    # Exemplo de uso
    conexao = conectar()
    criar_tabela_medicos(conexao)

    # Inserir um novo médico
    medico_id = inserir_medico(conexao, "Dr. Smith", "123456789", "987654321", "dr_smith", "senha123")

    # Buscar todos os médicos
    todos_medicos = buscar_medicos(conexao)
    print("Todos os médicos:", todos_medicos)

    # Buscar um médico por ID
    medico_encontrado = buscar_medico_por_id(conexao, medico_id)
    print("Médico encontrado:", medico_encontrado)

    # Atualizar os dados do médico
    atualizar_medico(conexao, medico_id, "Dr. Smith Atualizado", "111111111", "222222222", "dr_smith", "nova_senha")

    # Buscar novamente o médico por ID
    medico_atualizado = buscar_medico_por_id(conexao, medico_id)
    print("Médico atualizado:", medico_atualizado)

    # Excluir o médico
    excluir_medico(conexao, medico_id)

    # Buscar todos os médicos após exclusão
    todos_medicos_apos_exclusao = buscar_medicos(conexao)
    print("Todos os médicos após exclusão:", todos_medicos_apos_exclusao)

    # Fechar a conexão
    conexao.close()
    
    
    ```

<!-- markdownlint-disable-next-line -->
</main>

[🔝🔝](#topo "Retorna ao topo")
