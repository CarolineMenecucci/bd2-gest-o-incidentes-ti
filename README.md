
# 🛡️ Sistema de Monitoramento e Gestão de Incidentes de Segurança da Informação

## 📌 Sobre o Projeto

Este projeto apresenta o desenvolvimento de um sistema de monitoramento e gestão de incidentes de segurança da informação, utilizando bancos de dados relacionais e não relacionais.

A solução foi desenvolvida como projeto acadêmico, com o objetivo de aplicar conceitos de modelagem de dados, SQL, NoSQL, consultas, operações CRUD, indexação, agregações e escalabilidade.

O sistema utiliza **MySQL** e **MongoDB**, demonstrando como diferentes tecnologias de banco de dados podem trabalhar de forma complementar.

---

## 🎯 Objetivos

- Registrar e gerenciar incidentes de segurança da informação.
- Armazenar informações sobre usuários, ativos e incidentes.
- Monitorar eventos relacionados à segurança.
- Manter registros de auditoria das operações realizadas.
- Realizar consultas e análises dos dados armazenados.
- Demonstrar operações CRUD em bancos SQL e NoSQL.
- Avaliar estratégias de armazenamento, indexação e escalabilidade.
- Trabalhar com um volume significativo de documentos.

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Finalidade |
|------------|------------|
| MySQL | Banco de dados relacional |
| MongoDB | Banco de dados NoSQL orientado a documentos |
| MongoDB Compass | Gerenciamento visual do MongoDB |
| SQL | Manipulação de dados relacionais |
| JavaScript | Consultas e operações MongoDB |
| JSON | Representação e importação de documentos |
| GitHub | Versionamento e organização do projeto |

---

## 🏗️ Arquitetura da Solução

O projeto utiliza uma arquitetura híbrida de armazenamento.

### MySQL — Banco Relacional

O MySQL é utilizado para representar informações estruturadas que necessitam de relacionamentos e integridade referencial.

A modelagem relacional contempla entidades relacionadas à gestão de incidentes, usuários, ativos e demais informações do sistema.

A implementação relacional aborda:

- Modelagem entidade-relacionamento (MER).
- Modelo relacional.
- Dicionário de dados.
- Criação de tabelas e relacionamentos.
- Chaves primárias e estrangeiras.
- Inserção e manipulação de dados.
- Consultas SQL.
- Views, procedures e triggers.
- Índices e controle de permissões.

### MongoDB — Banco Não Relacional

O MongoDB é utilizado para armazenar documentos relacionados aos incidentes, eventos de segurança e registros de auditoria.

Sua estrutura flexível permite representar informações aninhadas, listas e atributos variáveis.

**Banco de dados:** `seguranca_incidentes`

**Coleções:**

1. `incidentes`
2. `eventos_seguranca`
3. `auditoria_incidentes`

---

## 🍃 Modelagem MongoDB

### 1. Coleção `incidentes`

Armazena os registros de incidentes de segurança.

Entre as informações representadas estão:

- Identificador do incidente.
- Título e descrição.
- Categoria.
- Severidade.
- Status.
- Ativo relacionado.
- Responsável.
- Origem.
- Datas de registro e resolução.

A coleção utiliza documentos incorporados para representar informações relacionadas ao incidente.

### 2. Coleção `eventos_seguranca`

Armazena eventos associados à segurança dos sistemas.

Exemplos de eventos:

- Tentativas de autenticação.
- Falhas de login.
- Alertas de malware.
- Atividades suspeitas.

Os documentos podem conter:

- Tipo do evento.
- Data e horário.
- Usuário relacionado.
- Endereço IP de origem.
- Informações de autenticação.
- Dados específicos de malware.
- Tags.
- Indicador de suspeita.

### 3. Coleção `auditoria_incidentes`

Armazena o histórico de operações realizadas sobre incidentes.

Entre os campos estão:

- Identificador da auditoria.
- Identificador do incidente.
- Tipo da ação.
- Usuário responsável.
- Data e horário.
- Dados anteriores.
- Dados novos.
- Campos alterados.
- Resultado da operação.

Essa coleção permite acompanhar alterações e manter a rastreabilidade das operações.

---

## 📄 Exemplo de Documento JSON

Exemplo de registro de evento de segurança:

```json
{
  "_id": "EVT-000001",
  "tipo_evento": "tentativa_login",
  "descricao": "Tentativa de acesso malsucedida ao sistema",
  "data_hora": {
    "$date": "2024-01-01T08:30:00Z"
  },
  "usuario": {
    "id": 1,
    "nome": "Melissa Sousa"
  },
  "origem": {
    "endereco_ip": "192.168.1.105",
    "dispositivo": "Computador",
    "sistema_operacional": "Windows"
  },
  "autenticacao": {
    "resultado": "falha",
    "motivo": "Senha incorreta",
    "tentativas": 3
  },
  "tags": [
    "login",
    "autenticacao",
    "falha"
  ],
  "suspeito": true
}
```

Esse exemplo demonstra documentos aninhados, arrays, strings, números, booleanos e datas.

---

## 🔎 Consultas MongoDB

Foram preparadas consultas envolvendo:

- `find()`
- Filtros por igualdade.
- Operadores `$gt`, `$gte`, `$lt` e `$lte`.
- Operadores lógicos `$and` e `$or`.
- Consultas em campos aninhados.
- Consultas em arrays.
- Projeção de campos.
- Ordenação com `sort()`.
- Limitação de resultados com `limit()`.

Exemplo:

```javascript
use seguranca_incidentes

db.incidentes.find({
  "ativo.tipo": "Servidor"
})
```

Consulta utilizando operador lógico:

```javascript
db.incidentes.find({
  $or: [
    { "ativo.tipo": "Servidor" },
    { "ativo.criticidade": "Alta" }
  ]
})
```

---

## 📈 Aggregation Pipeline

Foram executadas duas agregações no MongoDB.

### Agregação 1 — Incidentes por Criticidade do Ativo

```javascript
db.incidentes.aggregate([
  {
    $match: {
      "ativo.criticidade": {
        $exists: true
      }
    }
  },
  {
    $group: {
      _id: "$ativo.criticidade",
      total_incidentes: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      total_incidentes: -1
    }
  }
])
```

Na execução realizada, foram obtidos os seguintes resultados:

| Criticidade | Quantidade |
|-------------|------------|
| Crítica | 8.250 |
| Média | 8.250 |
| Alta | 8.250 |
| Baixa | 8.250 |

Os valores refletem a distribuição dos dados utilizados no teste.

### Agregação 2 — Severidade dos Incidentes em Servidores

```javascript
db.incidentes.aggregate([
  {
    $match: {
      "ativo.tipo": "Servidor"
    }
  },
  {
    $group: {
      _id: "$severidade.nivel",
      quantidade: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      quantidade: -1
    }
  },
  {
    $project: {
      _id: 0,
      nivel_severidade: "$_id",
      quantidade: 1
    }
  }
])
```

Essa agregação agrupa incidentes associados a servidores conforme o nível de severidade.

---

## ⚡ Indexação

Foi criado um índice adicional na coleção `incidentes`.

```javascript
db.incidentes.createIndex(
  {
    "ativo.tipo": 1
  },
  {
    name: "idx_ativo_tipo"
  }
)
```

O objetivo é favorecer consultas que filtram incidentes pelo tipo do ativo.

Para verificar os índices:

```javascript
db.incidentes.getIndexes()
```

Para analisar o plano de execução de uma consulta:

```javascript
db.incidentes.find({
  "ativo.tipo": "Servidor"
}).explain("executionStats")
```

A análise do plano permite verificar se o índice foi utilizado e avaliar as estatísticas de execução.

---

## 📦 Estratégia para Grandes Volumes de Dados

O projeto considera o crescimento contínuo dos registros de segurança.

As coleções de eventos e auditoria tendem a apresentar crescimento significativo, pois podem receber novos documentos a cada ocorrência ou alteração registrada.

As estratégias consideradas incluem:

- Criação de índices em campos frequentemente consultados.
- Consultas com filtros e projeções.
- Paginação e limitação de resultados.
- Monitoramento do crescimento das coleções.
- Políticas de retenção e arquivamento.
- Avaliação de particionamento e escalabilidade conforme a demanda.

O MongoDB oferece flexibilidade para armazenar eventos com estruturas variáveis, enquanto o MySQL oferece recursos relacionais adequados às informações estruturadas.

---

## 🔗 Integração entre MySQL e MongoDB

A proposta utiliza as duas tecnologias de maneira complementar.

**MySQL:**
- Dados estruturados.
- Relacionamentos entre entidades.
- Integridade referencial.
- Operações que exigem consistência relacional.

**MongoDB:**
- Registros de eventos.
- Documentos de incidentes.
- Histórico de auditoria.
- Informações semiestruturadas.
- Consultas e agregações sobre documentos.

A arquitetura demonstra uma estratégia de persistência poliglota, em que diferentes modelos de dados são utilizados de acordo com as necessidades da aplicação.

---

## 🚀 Como Executar o Projeto

### Pré-requisitos

- MySQL instalado e configurado.
- MongoDB instalado e em execução.
- MongoDB Compass ou MongoDB Shell.
- Arquivos SQL e JSON do projeto.

### 1. Configurar o MySQL

1. Iniciar o servidor MySQL.
2. Executar os scripts de criação do banco e das tabelas.
3. Executar os scripts SQL de consultas e demais recursos disponíveis no repositório.

A ordem de execução deve respeitar as dependências entre tabelas e objetos do banco.

### 2. Configurar o MongoDB

Iniciar o MongoDB e conectar utilizando:

```text
mongodb://localhost:27017
```

Selecionar o banco de dados:

```javascript
use seguranca_incidentes
```

Criar as coleções, caso ainda não existam:

```javascript
db.createCollection("incidentes")
db.createCollection("eventos_seguranca")
db.createCollection("auditoria_incidentes")
db.createCollection("alertas_seguranca")
db.createCollection("metricas_ativos")
db.createCollection("evidencias_digitais")
db.createCollection("vulnerabilidadess")
```

### 3. Importar os Dados JSON

No MongoDB Compass:

1. Acessar o banco `seguranca_incidentes`.
2. Selecionar a coleção desejada.
3. Utilizar a opção de importação de dados.
4. Selecionar o arquivo JSON correspondente.
5. Confirmar a importação.

Repetir o procedimento para as coleções necessárias.

### 4. Quantidade de Documentos

Na base utilizada durante o desenvolvimento, o total confirmado foi de **200.105 documentos**.

---

## 📚 Documentação

O projeto contempla materiais relacionados a:

- Levantamento de requisitos.
- Modelagem entidade-relacionamento.
- Modelo relacional.
- Dicionário de dados.
- Implementação MySQL.
- Modelagem MongoDB.
- Exemplos JSON.
- Consultas SQL e NoSQL.
- Operações CRUD.
- Aggregation Pipeline.
- Indexação.
- Estratégias para grandes volumes de dados.

Os arquivos correspondentes devem ser consultados nas pastas do repositório.

---

## 🎓 Considerações Finais

O desenvolvimento deste projeto permitiu aplicar conceitos de bancos de dados relacionais e não relacionais em um cenário de segurança da informação.

O MySQL foi utilizado para trabalhar com estruturas relacionais, enquanto o MongoDB permitiu explorar documentos flexíveis, registros de eventos, auditoria, consultas e agregações.

A utilização de **200.105 documentos** no ambiente MongoDB contribuiu para a realização de testes com um volume expressivo de dados.

O projeto demonstra como diferentes tecnologias de armazenamento podem ser combinadas para atender às necessidades de um sistema de monitoramento e gestão de incidentes de segurança da informação.

---
