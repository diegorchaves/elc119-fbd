import mariadb

def conectar_banco():
    try:
        conexao = mariadb.connect (
            host='localhost',
            user='root',
            password='123456',
            database='trabalho_fbd',
        )
        print("Conexão estabelecida com sucesso!")
        return conexao
    
    except mariadb.Error as e:
        print(f"Erro ao conectar ao MariaDB: {e}")
        return None

def imprime_opcoes():
    print('Seja bem-vindo, seleciona uma das opcoes: ')
    print('1 - Consultar tabelas')
    print('2 - Alterar registros')
    print('3 - Excluir registros')
    print('4 - Inserir registros')
    print('5 - Sair')

    opcao_selecionada = input()

    match opcao_selecionada:
        case 1:
            consultar_tabelas()
        case 2:
            alterar_registros()
        case 3:
            excluir_registros()
        case 4:
            inserir_registros()
        case 5:
            print('Saindo...')

if __name__ == "__main__":
    conexao = conectar_banco()
    if conexao:
        imprime_opcoes()

        conexao.close()  # Não esqueça de fechar a conexão


