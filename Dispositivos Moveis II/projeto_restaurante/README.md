# 🍽️ Restaurante App - Sistema de Pedidos e Kanban

Um aplicativo moderno desenvolvido em Flutter para substituir as comandas de papel por um fluxo totalmente digital e ágil, conectando diretamente o salão (garçons) à cozinha (produção).

## 🚀 Funcionalidades

- **📱 Módulo do Salão (Garçom):** Abertura de pedidos por número da mesa, controle numérico de quantidade de itens e envio instantâneo para a cozinha.
- **🖥️ Módulo da Cozinha (Kanban):** Painel interativo com 3 colunas (A Fazer, Preparando, Pronto). Atualização automática em tempo real (polling) e controle de brilho/inatividade para manter a tela sempre acesa.
- **🍔 Gestão de Cardápio:** Módulo completo com CRUD (Criar, Ler, Atualizar, Deletar) para gerenciar os itens e preços do restaurante.
- **☁️ Sincronização em Nuvem:** Base de dados PostgreSQL totalmente hospedada na nuvem (Neon DB).

## 🛠️ Tecnologias Utilizadas

- **Frontend:** Flutter & Dart
- **Banco de Dados:** PostgreSQL (via [Neon.tech](https://neon.tech/))
- **Gerenciamento de Estado/Rotas:** Nativo do Flutter (Stateful Widgets e Navigator)
- **Pacotes Principais:** 
  - `postgres` (Conexão direta com banco na nuvem)
  - `flutter_dotenv` (Segurança de variáveis de ambiente)
  - `wakelock_plus` (Manutenção da tela sempre ativa)

## ⚙️ Como executar o projeto

### 1. Pré-requisitos
- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.
- Uma conta no [Neon](https://neon.tech/) com um banco de dados PostgreSQL criado.

### 2. Configuração do Banco de Dados
No console do Neon, execute o seguinte script SQL para criar as tabelas necessárias:

```sql
CREATE TABLE itens (
  id SERIAL PRIMARY KEY,
  nome TEXT NOT NULL,
  preco NUMERIC(10,2) NOT NULL
);

CREATE TABLE pedidos (
  id SERIAL PRIMARY KEY,
  mesa TEXT NOT NULL,
  itens_resumo TEXT NOT NULL,
  status TEXT NOT NULL,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 3. Clone e Variáveis de Ambiente
Faça o clone deste repositório e baixe as dependências

Crie um arquivo `.env` na raiz do projeto (mesmo nível do `pubspec.yaml`) e adicione as suas credenciais do banco Neon:
```env
DB_HOST=ep-nome-do-seu-banco.us-east-2.aws.neon.tech
DB_NAME=neondb
DB_USER=seu_usuario
DB_PASS=sua_senha
```

### 4. Rodando o App
Pronto! Agora é só compilar ou rodar no seu emulador/dispositivo físico:
```bash
flutter run
```
*Para compilar o APK de produção para Android:*
```bash
flutter build apk --release
```

## 📝 Autores
- Adson Filho
- Eduardo Henrique
