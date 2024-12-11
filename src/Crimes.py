import mariadb

def pausar():
    input("\nPressione Enter para continuar...")

def conectar():
    try:
        conexao = mariadb.connect(
            host='localhost',
            user='root',
            password='lucas', #123456
            database='crimes',  #trabalho_fdb
            port=3306  # Porta padrão do MariaDB
        )
        print("Conexão com o banco de dados realizada com sucesso!")
        return conexao
    except mariadb.Error as e:
        print(f"Erro ao conectar ao banco de dados MariaDB: {e}")
        return None

def listar_dados(cursor, tabela_view):
    """
    Lista os registros da view fornecida com colunas alinhadas.
    """
    if tabela_view == "ViewCrime":
        query = "SELECT IdCrime, TipoCrime, Cidade, Mes, Ano, TotalVitimas FROM ViewCrime"
        headers = ["ID", "Tipo de Crime", "Cidade", "Mês", "Ano", "Vítimas"]
    elif tabela_view == "ViewTipoCrime":
        query = "SELECT IdTipoCrime, Nome, CVLI FROM ViewTipoCrime"
        headers = ["ID", "Nome", "CVLI"]
    elif tabela_view == "ViewCidade":
        query = "SELECT IdCidade, Nome FROM ViewCidade"
        headers = ["ID", "Nome"]
    else:
        print("View desconhecida.")
        return

    try:
        cursor.execute(query)
        resultados = cursor.fetchall()

        col_sizes = [max(len(str(item)) for item in col) for col in zip(*resultados, headers)]

        header_line = " | ".join(f"{header:<{col_sizes[i]}}" for i, header in enumerate(headers))
        print("\n" + header_line)
        print("-" * len(header_line))

        for linha in resultados:
            print(" | ".join(f"{str(campo):<{col_sizes[i]}}" for i, campo in enumerate(linha)))

    except mariadb.Error as e:
        print(f"Erro ao listar dados da view {tabela_view}: {e}")
    pausar()


def listar_crimes(cursor):
    listar_dados(cursor, "ViewCrime")

def listar_tipos_crime(cursor):
    listar_dados(cursor, "ViewTipoCrime")

def listar_cidades(cursor):
    listar_dados(cursor, "ViewCidade")

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
    listar_crimes(cursor)

    id_crime = int(input("Digite o ID do crime a ser alterado: "))

    print("\n--- Cidades Disponíveis ---")
    listar_cidades(cursor)

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
    listar_crimes(cursor)
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
    try:
        cursor.execute(query, (nome_tipo_crime, cvli))
        conexao.commit()
        print("Tipo de crime adicionado com sucesso!")
    except mariadb.Error as e:
        print(f"Erro ao adicionar o tipo de crime: {e}")
    pausar()

def alterar_tipo_crime(cursor, conexao):
    print("\n--- Tipos de Crimes Disponíveis ---")
    listar_tipos_crime(cursor)

    id_tipo_crime = int(input("Digite o ID do tipo de crime a ser alterado: "))

    novo_nome = input("Digite o novo nome do tipo de crime: ")
    query = "UPDATE TipoCrime SET Nome = ? WHERE IdTipoCrime = ?"
    try:
        cursor.execute(query, (novo_nome, id_tipo_crime))
        conexao.commit()
        print("Tipo de crime alterado com sucesso!")
    except mariadb.Error as e:
        print(f"Erro ao alterar o tipo de crime: {e}")
    pausar()

def excluir_tipo_crime(cursor, conexao):
    listar_tipos_crime(cursor)
    id_tipo_crime = int(input("Digite o ID do tipo de crime a ser excluído: "))
    query = "DELETE FROM TipoCrime WHERE IdTipoCrime = ?"
    try:
        cursor.execute(query, (id_tipo_crime,))
        conexao.commit()
        print("Tipo de crime excluído com sucesso!")
    except mariadb.Error as e:
        print(f"Erro ao excluir o tipo de crime: {e}")
    pausar()

def criar_cidade(cursor, conexao):
    nome_cidade = input("Digite o nome da cidade: ")
    query = "INSERT INTO Cidade (Nome) VALUES (?)"
    try:
        cursor.execute(query, (nome_cidade,))
        conexao.commit()
        print("Cidade adicionada com sucesso!")
    except mariadb.Error as e:
        print(f"Erro ao adicionar a cidade: {e}")
    pausar()

def alterar_cidade(cursor, conexao):
    listar_cidades(cursor)

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
    listar_cidades(cursor)
    id_cidade = int(input("Digite o ID da cidade a ser excluída: "))
    query = "DELETE FROM Cidade WHERE IdCidade = ?"
    try:
        cursor.execute(query, (id_cidade,))
        conexao.commit()
        print("Cidade excluída com sucesso!")
    except mariadb.Error as e:
        print(f"Erro ao excluir a cidade: {e}")
    pausar()

