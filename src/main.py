import mariadb
from Crimes import listar_dados, criar_crime, alterar_crime, excluir_crime, criar_tipo_crime, alterar_tipo_crime, excluir_tipo_crime, criar_cidade, alterar_cidade, excluir_cidade, listar_crimes, listar_tipos_crime, listar_cidades

def conectar_banco():
    try:
        conexao = mariadb.connect(
            host='localhost',
            user='root',
            password='123456',  # 123456
            database='trabalho_fbd',  # trabalho_fdb
            port=3306
        )
        print("Conexão estabelecida com sucesso!")
        return conexao
    except mariadb.Error as e:
        print(f"Erro ao conectar ao MariaDB: {e}")
        return None

def pausar():
    input("\nPressione Enter para continuar...")

def consultar_tabelas(cursor):
    print("\n--- Consultar Tabelas ---")
    print("1. Listar Crimes")
    print("2. Listar Tipos de Crimes")
    print("3. Listar Cidades")
    opcao = input("Escolha uma opção: ")

    if opcao == "1":
        listar_crimes(cursor)
    elif opcao == "2":
        listar_tipos_crime(cursor)
    elif opcao == "3":
        listar_cidades(cursor)
    else:
        print("Opção inválida. Tente novamente.")

def consultar_logs(cursor):
    """
    Menu para consultar diferentes categorias de logs via views.
    """
    print("\n--- Consultar Logs ---")
    print("1. Logs de Crimes")
    print("2. Logs de Tipos de Crimes")
    print("3. Logs de Cidades")
    opcao = input("Escolha uma opção: ")

    if opcao == "1":
        listar_logs(cursor, "LogsCrimes")
    elif opcao == "2":
        listar_logs(cursor, "LogsTipoCrime")
    elif opcao == "3":
        listar_logs(cursor, "LogsCidades")
    else:
        print("Opção inválida. Tente novamente.")


def listar_logs(cursor, tabela_view):
    """
    Lista os registros da view de logs fornecida.
    """
    query = f"SELECT IdLog, IdRegistro, TipoOperacao, DescricaoAlteracao, DataHora FROM {tabela_view}"
    cursor.execute(query)
    resultados = cursor.fetchall()
    print(f"\n--- Logs da View {tabela_view} ---")
    print(f"{'ID Log':<10} {'ID Registro':<12} {'Operação':<10} {'Descrição':<50} {'Data/Hora':<20}")
    print("-" * 100)
    for linha in resultados:
        print(f"{linha[0]:<10} {linha[1]:<12} {linha[2]:<10} {linha[3]:<50} {linha[4]}")
    pausar()

def alterar_registros(cursor, conexao):
    print("\n--- Alterar Registros ---")
    print("1. Alterar Crime")
    print("2. Alterar Tipo de Crime")
    print("3. Alterar Cidade")
    opcao = input("Escolha uma opção: ")

    if opcao == "1":
        alterar_crime(cursor, conexao)
    elif opcao == "2":
        alterar_tipo_crime(cursor, conexao)
    elif opcao == "3":
        alterar_cidade(cursor, conexao)
    else:
        print("Opção inválida. Tente novamente.")

def excluir_registros(cursor, conexao):
    print("\n--- Excluir Registros ---")
    print("1. Excluir Crime")
    print("2. Excluir Tipo de Crime")
    print("3. Excluir Cidade")
    opcao = input("Escolha uma opção: ")

    if opcao == "1":
        excluir_crime(cursor, conexao)
    elif opcao == "2":
        excluir_tipo_crime(cursor, conexao)
    elif opcao == "3":
        excluir_cidade(cursor, conexao)
    else:
        print("Opção inválida. Tente novamente.")

def inserir_registros(cursor, conexao):
    print("\n--- Inserir Registros ---")
    print("1. Inserir Crime")
    print("2. Inserir Tipo de Crime")
    print("3. Inserir Cidade")
    opcao = input("Escolha uma opção: ")

    if opcao == "1":
        criar_crime(cursor, conexao)
    elif opcao == "2":
        criar_tipo_crime(cursor, conexao)
    elif opcao == "3":
        criar_cidade(cursor, conexao)
    else:
        print("Opção inválida. Tente novamente.")

def imprime_opcoes(cursor, conexao):
    while True:
        print('Seja bem-vindo, selecione uma das opções: ')
        print('1 - Consultar tabelas')
        print('2 - Alterar registros')
        print('3 - Excluir registros')
        print('4 - Inserir registros')
        print('5 - Consultar logs')
        print('6 - Sair')

        opcao_selecionada = input()

        match opcao_selecionada:
            case "1":
                consultar_tabelas(cursor)
            case "2":
                alterar_registros(cursor, conexao)
            case "3":
                excluir_registros(cursor, conexao)
            case "4":
                inserir_registros(cursor, conexao)
            case "5":
                consultar_logs(cursor)
            case "6":
                print('Saindo...')
                break
            case _:
                print("Opção inválida. Tente novamente.")

if __name__ == "__main__":
    conexao = conectar_banco()
    if conexao:
        cursor = conexao.cursor()
        imprime_opcoes(cursor, conexao)
        cursor.close()
        conexao.close()