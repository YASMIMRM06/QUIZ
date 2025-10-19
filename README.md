[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/vBS0RnPU)
# 📚 Projeto: Code Quiz - Sistema de Avaliação Online (1º Bimestre)

Este projeto consiste em um **sistema de quizzes dinâmico**, onde usuários podem criar, responder e visualizar resultados de questionários com múltiplas escolhas. O sistema possui autenticação, controle de acesso baseado em papéis (roles) e registro detalhado das respostas e pontuações.

---

## 🎯 Objetivo do Projeto

O objetivo é desenvolver uma aplicação web onde:

- **Admins** e **Moderadores** possam criar questionários com perguntas e múltiplas opções de resposta.
- **Estudantes** possam acessar os questionários, respondê-los e visualizar seus resultados.
- O sistema controle permissões com base no papel de cada usuário.
- Resultados sejam armazenados e visíveis conforme as permissões definidas.

---

## 🛠 Tecnologias Utilizadas

- **Ruby on Rails**
- **Devise** – Autenticação
- **Pundit** – Autorização baseada em roles
- **TailwindCSS ou Bootstrap** – Interface
- **Letter Opener** – Simulação de envio de e-mails
- **PostgreSQL** – Banco de dados

---

## 👥 Perfis de Usuário (Roles)

### 👑 Admin
- Acesso total ao sistema.
- Pode gerenciar todos os questionários, perguntas e resultados.

### 🧑‍💼 Moderador
- Pode criar, editar e excluir **apenas seus próprios questionários**.
- Pode criar perguntas **apenas nos seus questionários**.
- Pode visualizar **apenas resultados dos seus questionários**.

### 👨‍🎓 Estudante
- Pode visualizar e responder questionários.
- Pode visualizar apenas **seus próprios resultados**.
- Sem permissão de criação ou edição de conteúdo.

---

## 🗃️ Estrutura do Banco de Dados (Resumo)

### users
Contém informações dos usuários e sua referência à role.

### roles
Define os papéis: admin, moderator e student.

### questionnaires
Contém os questionários criados pelos admins e moderadores.

### questions
Cada pergunta pertence a um questionário.

### question_options
Cada pergunta possui várias opções, com uma marcada como correta.

### user_answer_histories
Histórico das respostas dos usuários.

### user_results
Registro do desempenho do usuário em um questionário.

---

## ⚙️ Funcionalidades Esperadas

### Para todos os usuários autenticados
- Login com Devise
- Interface com TailwindCSS ou Bootstrap
- Visualização da lista de questionários
- Responder perguntas com múltiplas escolhas

### Para Admins
- Acesso total a todos os recursos do sistema

### Para Moderadores
- Gestão apenas de seus próprios conteúdos

### Para Estudantes
- Acesso restrito à resposta e visualização de resultados próprios

---

## 🧪 Testes Manuais Recomendados

### Como Admin
- [ ] Gerenciar qualquer conteúdo
- [ ] Ver todos os resultados

### Como Moderador
- [ ] Criar e gerenciar **apenas seus** questionários e perguntas
- [ ] Visualizar **apenas os resultados dos seus questionários**

### Como Estudante
- [ ] Responder questionários
- [ ] Ver **somente seus resultados**

---

## 📨 Envio de E-mails com Letter Opener

Ao finalizar um questionário, o sistema envia um e-mail (simulado com Letter Opener) com:

- Total de questões
- Número de acertos
- Pontuação final

---

## 📦 Opções de Implementação para a Estrutura de Papéis e Usuários
escolha uma abordagem e aplique a qual você entender e achar melhor par ao projeto!.
###  **Abordagem Simples**: Usando `find_by` para Associar Papéis aos Usuários

Esta abordagem é direta e simples. Ela cria os papéis no banco e, em seguida, associa os usuários a esses papéis com base no título. É uma maneira eficiente para sistemas pequenos ou protótipos.

```ruby
Role.find_or_create_by(title: "admin")
Role.find_or_create_by(title: "moderator")
Role.find_or_create_by(title: "student")

admin = User.create!(
  name: "Administrador",
  email: "admin@example.com",
  password: "123456",
  role: Role.find_by(title: "admin")
)

moderator = User.create!(
  name: "Moderador",
  email: "mod@example.com",
  password: "123456",
  role: Role.find_by(title: "moderator")
)

student = User.create!(
  name: "Aluno",
  email: "student@example.com",
  password: "123456",
  role: Role.find_by(title: "student")
)
``` 

**Vantagens**:
- **Simplicidade**: Fácil de entender e aplicar.
- **Rapidez**: Ideal para quando você precisa de uma implementação rápida sem muita complexidade.

**Desvantagens**:
- Menos flexível quando se trata de controle avançado sobre os dados de roles e usuários.

###  **Abordagem Avançada**: Usando `enum` e `find_or_create_by!`

A segunda abordagem é mais flexível e robusta, usando `enum` no modelo `User` para definir papéis de forma explícita. Com isso, o código fica mais estruturado e você ganha controle sobre as operações no banco.

```ruby
# Criando as roles com segurança e criando a estrutura com enums no modelo User
Role.find_or_create_by!(title: "admin")
Role.find_or_create_by!(title: "moderator")
Role.find_or_create_by!(title: "student")

admin_role = Role.find_by!(title: "admin")
moderator_role = Role.find_by!(title: "moderator")
student_role = Role.find_by!(title: "student")

admin = User.create!(
  name: "Administrador",
  email: "admin@example.com",
  password: "123456",
  role: admin_role
)

moderator = User.create!(
  name: "Moderador",
  email: "mod@example.com",
  password: "123456",
  role: moderator_role
)

student = User.create!(
  name: "Aluno",
  email: "student@example.com",
  password: "123456",
  role: student_role
)
``` 

**Vantagens**:
- **Mais Seguro**: Usando `find_by!` e `create_by!`, você garante que a criação das roles e usuários seja feita com segurança. Se algum dado não for encontrado ou não for criado, o sistema lançará um erro claro.
- **Estruturado**: O uso de `enum` para os papéis no modelo `User` torna o código mais organizado, permitindo maior flexibilidade e controle.

**Desvantagens**:
- **Complexidade**: Requer mais configuração e é um pouco mais complexo para iniciantes.
- **Mais Verboso**: Requer mais código e pode ser um pouco excessivo para projetos menores ou mais simples.

---

### **Qual escolher?**

- **Escolha a abordagem simples** se você precisa de uma implementação rápida e não precisa de muita flexibilidade ou controle sobre os dados.
- **Escolha a abordagem avançada** se o seu sistema exigir mais segurança, flexibilidade e organização, especialmente se você planeja adicionar funcionalidades mais complexas no futuro.

Ambas as abordagens são válidas, depende do seu projeto e das necessidades da sua aplicação! 
ruby



## 📋 Entrega


**Data de entrega do projeto:** `20/10/2025` (em sala)

- Todos os deverão apresentar o projeto no dia 20/10.
- Caso **não haja tempo suficiente para a apresentação em sala**, cada um deverá produzir um vídeo demonstrando o projeto com duração entre **3 a 5 minutos**.
- A entrega do código é obrigatória **mesmo com o vídeo** via gitclassroom.

---

## 📊 Critérios de Avaliação (Conceito)

A avaliação será feita com base nos seguintes aspectos:

| Critério | Avaliação Conceitual |
|----------|----------------------|
| Estrutura do projeto e uso correto do Rails | A / B / C / D |
| Implementação correta das funcionalidades principais | A / B / C / D |
| Aplicação das permissões com Pundit | A / B / C / D |
| Autenticação com Devise funcionando corretamente | A / B / C / D |
| Interface clara e funcional com Tailwind ou Bootstrap | A / B / C / D |
| Organização, clareza e demonstração do projeto | A / B / C / D |

**O conceito final será atribuído após a apresentação.**

---

**Boa sorte! Capriche na estrutura, teste todas as funcionalidades e prepare uma boa apresentação. Qualquer dúvida, volte nas aulas ou revise os exemplos. 🚀**
