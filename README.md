# Odara Servers Config

Este repositório contém uma coleção de arquivos de configuração (dotfiles) e scripts para a configuração de servidores utilizados pela OdaraIT.
O objetivo é padronizar e facilitar a configuração de ambientes de desenvolvimento e produção.

## Conteúdo

- **bash/**: Scripts e configurações para o shell Bash.
- **nvim/**: Arquivos de configuração para o editor de texto Neovim.
- **install**: Script de instalação automatizada para configurar o ambiente do servidor.

## Pré-requisitos

Antes de iniciar a instalação, certifique-se de que o servidor atenda aos seguintes requisitos:

- Sistema operacional baseado em Unix (Linux ou macOS).
- Acesso ao terminal com permissões de superusuário.
- Conexão com a internet para instalação de dependências.

## Instalação

Para configurar o ambiente do servidor com os dotfiles deste repositório, execute o seguinte comando:

```sh
curl -fsSL https://raw.githubusercontent.com/OdaraIT/servers/main/install | bash
```

> **Nota:** O script `install` irá sobrescrever configurações existentes. Recomenda-se fazer backup de quaisquer arquivos de configuração atuais antes de prosseguir.

## Uso

Após a instalação, as seguintes configurações estarão disponíveis:

- **Bash**: Alias personalizados, funções e configurações otimizadas para o terminal.
- **Neovim**: Configurações aprimoradas para desenvolvimento, incluindo plugins e mapeamentos de teclas.

Para personalizações adicionais, edite os arquivos correspondentes nos diretórios `bash/` e `nvim/`.

## Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais informações.
