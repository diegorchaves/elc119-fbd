import mariadb

def pausar():
    input("\nPressione Enter para continuar...")

def conectar():
    try:
        conexao = mariadb.connect(
            host='localhost',
            user='root',
            password='123456',
            database='trabalho_fbd',
            port=3306  # Porta padrão do MariaDB, ajuste se necessário
        )
        print("Conexão com o banco de dados realizada com sucesso!")
        return conexao
    except mariadb.Error as e:
        print(f"Erro ao conectar ao banco de dados MariaDB: {e}")
        return None

def listar_dados(cursor, tabela):
    if tabela == "Crime":
        query = """
        SELECT 
            c.IdCrime, 
            t.Nome AS TipoCrime, 
            ci.Nome AS Cidade, 
            c.Mes, 
            c.Ano,
            IFNULL(cv.TotalVitimas, 'Não aplicável') AS TotalVitimas
        FROM 
            Crime c
        JOIN 
            TipoCrime t ON c.IdTipoCrime = t.IdTipoCrime
        JOIN 
            Cidade ci ON c.IdCidade = ci.IdCidade
        LEFT JOIN 
            CVLI cv ON c.IdCrime = cv.IdCrime
        """
        cursor.execute(query)
        resultados = cursor.fetchall()
        print("\n--- Lista de Crimes ---")
        print(f"{'ID':<5} {'Tipo de Crime':<20} {'Cidade':<20} {'Mês':<5} {'Ano':<5} {'Vítimas':<15}")
        print("-" * 80)
        for linha in resultados:
            print(f"{linha[0]:<5} {linha[1]:<20} {linha[2]:<20} {linha[3]:<5} {linha[4]:<5} {linha[5]:<15}")

    elif tabela == "TipoCrime":
        query = "SELECT IdTipoCrime, Nome, CVLI FROM TipoCrime"
        cursor.execute(query)
        resultados = cursor.fetchall()
        print("\n--- Lista de Tipos de Crime ---")
        print(f"{'ID':<5} {'Nome':<30} {'CVLI':<10}")
        print("-" * 50)
        for linha in resultados:
            cvli_status = "Sim" if linha[2] else "Não"
            print(f"{linha[0]:<5} {linha[1]:<30} {cvli_status:<10}")

    elif tabela == "Cidade":
        query = "SELECT IdCidade, Nome FROM Cidade"
        cursor.execute(query)
        resultados = cursor.fetchall()
        print("\n--- Lista de Cidades ---")
        print(f"{'ID':<5} {'Nome':<30}")
        print("-" * 50)
        for linha in resultados:
            print(f"{linha[0]:<5} {linha[1]:<30}")
    else:
        print("Tabela desconhecida.")
        return

    pausar()


def criar_crime(cursor, conexao):
    cursor.execute("SELECT IdTipoCrime, Nome, CVLI FROM TipoCrime")
    tipos_crime = cursor.fetchall()
    print("\n--- Tipos de Crime Disponíveis ---")
    for tipo in tipos_crime:
        print(f"ID: {tipo[0]}, Nome: {tipo[1]}, CVLI: {tipo[2]}")
    
    id_tipo_crime = int(input("Digite o ID do tipo de crime: "))

    cursor.execute("SELECT IdCidade, Nome FROM Cidade")
    cidades = cursor.fetchall()
    print("\n--- Cidades Disponíveis ---")
    for cidade in cidades:
        print(f"ID: {cidade[0]}, Nome: {cidade[1]}")

    id_cidade = int(input("Digite o ID da cidade: "))

    mes = int(input("Digite o mês do crime (1-12): "))
    ano = int(input("Digite o ano do crime: "))
    nro_vitimas = int(input("Digite o número de vítimas (0 se não aplicável): "))

    try:
        cursor.callproc('InsertCrimeCVLI', [id_tipo_crime, id_cidade, mes, ano, nro_vitimas])
        conexao.commit()
        print("Crime adicionado com sucesso!")
    except mariadb.Error as e:
        print(f"Erro ao chamar o procedimento: {e}")
    
    pausar()

def alterar_crime(cursor, conexao):
    print("\n--- Crimes Disponíveis ---")
    listar_dados(cursor, "Crime")

    id_crime = int(input("Digite o ID do crime a ser alterado: "))

    print("\n--- Cidades Disponíveis ---")
    listar_dados(cursor, "Cidade")

    nova_cidade = int(input("Digite o novo ID da cidade: "))

    novo_mes = int(input("Digite o novo mês: "))
    novo_ano = int(input("Digite o novo ano: "))
    query = """
    UPDATE Crime
    SET IdCidade = ?, Mes = ?, Ano = ?
    WHERE IdCrime = ?
    """
    try:
        cursor.execute(query, (nova_cidade, novo_mes, novo_ano, id_crime))
        conexao.commit()
        print("Crime alterado com sucesso!")
    except mariadb.Error as e:
        print(f"Erro ao alterar o crime: {e}")
    pausar()

def excluir_crime(cursor, conexao):
    id_crime = int(input("Digite o ID do crime a ser excluído: "))
    query = "DELETE FROM Crime WHERE IdCrime = ?"
    try:
        cursor.execute(query, (id_crime))
        conexao.commit()
        print("Crime excluído com sucesso!")
    except mariadb.Error as e:
        print(f"Erro ao excluir o crime: {e}")
    pausar()

def criar_tipo_crime(cursor, conexao):
    nome_tipo_crime = input("Digite o nome do tipo de crime: ")
    cvli = int(input("É um crime CVLI? (1 para Sim, 0 para Não): "))
    query = "INSERT INTO TipoCrime (Nome, CVLI) VALUES (?, ?)"
    cursor.execute(query, (nome_tipo_crime, cvli))
    conexao.commit()
    print("Tipo de crime adicionado com sucesso!")
    pausar()

def alterar_tipo_crime(cursor, conexao):
    print("\n--- Tipos de Crimes Disponíveis ---")
    listar_dados(cursor, "TipoCrime")

    id_tipo_crime = int(input("Digite o ID do tipo de crime a ser alterado: "))

    novo_nome = input("Digite o novo nome do tipo de crime: ")
    query = "UPDATE TipoCrime SET Nome = ? WHERE IdTipoCrime = ?"
    try:
        cursor.execute(query, (novo_nome, id_tipo_crime))
        conexao.commit()
    except mariadb.Error as e:
        print(f"Erro ao alterar o tipo de crime: {e}")
    print("Tipo de crime alterado com sucesso!")
    pausar()

def excluir_tipo_crime(cursor, conexao):
    id_tipo_crime = int(input("Digite o ID do tipo de crime a ser excluído: "))
    query = "DELETE FROM TipoCrime WHERE IdTipoCrime = ?"
    cursor.execute(query, (id_tipo_crime,))
    conexao.commit()
    print("Tipo de crime excluído com sucesso!")
    pausar()

def criar_cidade(cursor, conexao):
    nome_cidade = input("Digite o nome da cidade: ")
    query = "INSERT INTO Cidade (Nome) VALUES (?)"
    cursor.execute(query, (nome_cidade,))
    conexao.commit()
    print("Cidade adicionada com sucesso!")
    pausar()

def alterar_cidade(cursor, conexao):
    print("\n--- Cidades Disponíveis ---")
    listar_dados(cursor, "Cidade")

    id_cidade = int(input("Digite o ID da cidade a ser alterada: "))

    novo_nome = input("Digite o novo nome da cidade: ")

    query = "UPDATE Cidade SET Nome = ? WHERE IdCidade = ?"
    try:
        cursor.execute(query, (novo_nome, id_cidade))
        conexao.commit()
        print("Cidade alterada com sucesso!")
    except mariadb.Error as e:
        print(f"Erro ao alterar a cidade: {e}")
    pausar()

def excluir_cidade(cursor, conexao):
    id_cidade = int(input("Digite o ID da cidade a ser excluída: "))
    query = "DELETE FROM Cidade WHERE IdCidade = ?"
    cursor.execute(query, (id_cidade,))
    conexao.commit()
    print("Cidade excluída com sucesso!")
    pausar()

def menu():
    conexao = conectar()
    if not conexao:
        return
    cursor = conexao.cursor()

    while True:
        print("\n--- MENU ---")
        print("1. Gerenciar Crimes")
        print("2. Gerenciar Tipos de Crimes")
        print("3. Gerenciar Cidades")
        print("4. Sair")
        escolha = input("Escolha uma opção: ")

        if escolha == "1":
            while True:
                print("\n--- Gerenciar Crimes ---")
                print("1. Listar Crimes")
                print("2. Criar Crime")
                print("3. Alterar Crime")
                print("4. Excluir Crime")
                print("5. Voltar")
                opcao = input("Escolha uma opção: ")

                if opcao == "1":
                    listar_dados(cursor, "Crime")
                elif opcao == "2":
                    criar_crime(cursor, conexao)
                elif opcao == "3":
                    alterar_crime(cursor, conexao)
                elif opcao == "4":
                    excluir_crime(cursor, conexao)
                elif opcao == "5":
                    break
                else:
                    print("Opção inválida. Tente novamente.")
        elif escolha == "2":
            while True:
                print("\n--- Gerenciar Tipos de Crimes ---")
                print("1. Listar Tipos de Crimes")
                print("2. Criar Tipo de Crime")
                print("3. Alterar Tipo de Crime")
                print("4. Excluir Tipo de Crime")
                print("5. Voltar")
                opcao = input("Escolha uma opção: ")

                if opcao == "1":
                    listar_dados(cursor, "TipoCrime")
                elif opcao == "2":
                    criar_tipo_crime(cursor, conexao)
                elif opcao == "3":
                    alterar_tipo_crime(cursor, conexao)
                elif opcao == "4":
                    excluir_tipo_crime(cursor, conexao)
                elif opcao == "5":
                    break
                else:
                    print("Opção inválida. Tente novamente.")
        elif escolha == "3":
            while True:
                print("\n--- Gerenciar Cidades ---")
                print("1. Listar Cidades")
                print("2. Criar Cidade")
                print("3. Alterar Cidade")
                print("4. Excluir Cidade")
                print("5. Voltar")
                opcao = input("Escolha uma opção: ")

                if opcao == "1":
                    listar_dados(cursor, "Cidade")
                elif opcao == "2":
                    criar_cidade(cursor, conexao)
                elif opcao == "3":
                    alterar_cidade(cursor, conexao)
                elif opcao == "4":
                    excluir_cidade(cursor, conexao)
                elif opcao == "5":
                    break
                else:
                    print("Opção inválida. Tente novamente.")
        elif escolha == "4":
            print("Encerrando o programa.")
            break
        else:
            print("Opção inválida. Tente novamente.")

    cursor.close()
    conexao.close()


menu()
