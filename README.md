# 🛡️ Sistema de Monitoramento e Gestão de Incidentes de Segurança da Informação

## 📌 Sobre o projeto

Projeto acadêmico de modelagem, armazenamento, consulta e análise de dados relacionados à gestão de incidentes de segurança da informação. A solução utiliza **MySQL/MariaDB** (modelo relacional) e **MongoDB** (modelo orientado a documentos), explorando as diferenças e complementaridades entre SQL e NoSQL.

O projeto abrange modelagem de dados, integridade referencial, operações CRUD, consultas, índices, agregações e organização de conjuntos de dados de maior volume.

## 🎯 Objetivos

- Registrar, classificar e acompanhar incidentes de segurança da informação.
- Relacionar incidentes a usuários, equipes, ativos, categorias e status.
- Armazenar eventos de segurança, alertas, evidências digitais e vulnerabilidades.
- Manter trilhas de auditoria e histórico de alterações.
- Consultar e analisar registros em bancos relacionais e orientados a documentos.
- Exercitar operações CRUD, indexação e *Aggregation Pipeline*.
- Avaliar alternativas de organização e armazenamento de grandes volumes de dados.

## 🛠️ Tecnologias utilizadas

| Tecnologia | Aplicação |
|---|---|
| MySQL / MariaDB | Banco de dados relacional |
| SQL | Scripts DDL, DML e consultas |
| MongoDB | Banco de dados NoSQL orientado a documentos |
| MongoDB Compass | Visualização, administração e importação de coleções |
| JavaScript / MongoDB Shell (`mongosh`) | Consultas, agregações e criação de índices |
| JSON / Extended JSON | Representação dos documentos exportados |
| Git e GitHub / GitHub Desktop | Versionamento e publicação dos arquivos |

## 📊 Volume de dados

### Banco relacional — `bd_incidentes_ti`

O export SQL utilizado no projeto foi apresentado com **17 tabelas** e **aproximadamente 67.100 registros**. Os scripts DDL descrevem a estrutura das tabelas, chaves e relacionamentos; os comandos DML carregam os registros.

### Banco não relacional — `seguranca_incidentes`

O conjunto de exports MongoDB apresentado no projeto contém **7 coleções** e **234.105 documentos**:

| Coleção | Documentos | Finalidade |
|---|---:|---|
| `incidentes` | 33.002 | Incidentes registrados e informações operacionais |
| `eventos_seguranca` | 34.002 | Eventos e atividades relevantes à segurança |
| `auditoria_incidentes` | 33.101 | Histórico e rastreabilidade de alterações |
| `alertas_seguranca` | 34.000 | Alertas associados a condições e riscos de segurança |
| `metricas_ativos` | 34.000 | Indicadores e medições relacionadas aos ativos |
| `evidencias_digitais` | 33.000 | Evidências relacionadas a ocorrências e investigações |
| `vulnerabilidades` | 33.000 | Informações sobre vulnerabilidades identificadas |
| **Total** | **234.105** | |

> As quantidades são referentes aos arquivos exportados utilizados na documentação. Caso novas importações ou alterações sejam realizadas, os totais do ambiente MongoDB podem mudar.

## 🏗️ Arquitetura e modelagem

A proposta utiliza **persistência poliglota**, combinando dois modelos de armazenamento.

### MySQL/MariaDB — modelo relacional

Representa informações estruturadas e relacionamentos entre entidades do sistema. O banco inclui tabelas relacionadas a incidentes, usuários, ativos, equipes, categorias, status, permissões e auditoria.

Os elementos abordados incluem:

- Modelo entidade-relacionamento e modelo relacional.
- Tabelas, campos, tipos de dados e relacionamentos.
- Chaves primárias, estrangeiras e índices.
- Scripts **DDL** (definição da estrutura) e **DML** (manipulação e inserção de dados).
- Consultas SQL e recursos adicionais documentados no projeto, quando aplicáveis.

### MongoDB — modelo orientado a documentos

**Banco:** `seguranca_incidentes`

Os documentos JSON podem conter objetos aninhados, arrays, datas, atributos opcionais e estruturas específicas de cada coleção. Isso permite registrar tanto dados de incidentes quanto informações complementares de monitoramento e investigação.

## 🍃 Coleções MongoDB

### 1. `incidentes`

Armazena os incidentes e informações para acompanhamento, incluindo identificador, título, descrição, categoria, severidade, status, origem, ativo, responsável e datas. O modelo utiliza campos aninhados, como `ativo.tipo`, `ativo.criticidade` e `severidade.nivel`.

### 2. `eventos_seguranca`

Reúne eventos relevantes para a segurança, como tentativas de autenticação, falhas de login, atividades suspeitas e eventos associados a possíveis ameaças. Pode conter horários, IPs, informações de origem, usuário, tags e dados específicos do evento.

### 3. `auditoria_incidentes`

Registra ações e alterações vinculadas aos incidentes. Nos documentos apresentados aparecem campos como `tipo_acao`, `data_hora`, `usuario`, `alteracoes.dados_anteriores`, `alteracoes.dados_novos` e, conforme o documento, `incidente_id`, `campos_alterados` e `sucesso`.

### 4. `alertas_seguranca`

Organiza alertas de segurança para apoiar a identificação, o acompanhamento e a priorização de situações potencialmente relevantes. Os atributos específicos dependem do tipo de alerta registrado.

### 5. `metricas_ativos`

Armazena métricas relacionadas a ativos de tecnologia, possibilitando análises de monitoramento e acompanhamento operacional.

### 6. `evidencias_digitais`

Mantém documentos associados a evidências digitais de eventos ou incidentes, auxiliando a documentação e a rastreabilidade de análises.

### 7. `vulnerabilidades`

Reúne informações sobre vulnerabilidades e possíveis riscos relacionados ao ambiente monitorado.

> Os documentos podem apresentar conjuntos de campos diferentes dentro de uma mesma coleção, característica do modelo flexível do MongoDB.

## 📄 Exemplo de documento JSON

Exemplo baseado na estrutura de um registro da coleção `incidentes`:

```json
{
  "_id": "INC-2026-00125",
  "titulo": "Tentativas de acesso não autorizado",
  "categoria": {
    "id": 3,
    "descricao": "Acesso não autorizado"
  },
  "severidade": {
    "id": 4,
    "descricao": "Alta"
  },
  "status": {
    "id": 2,
    "descricao": "Em investigação"
  },
  "tags": [
    "login",
    "forca_bruta",
    "acesso_nao_autorizado"
  ],
  "data_resolucao": null
}
```

O exemplo demonstra objetos aninhados, arrays, textos, números e valores nulos. Os exports também utilizam **Extended JSON**, como `{"$date": "2025-02-02T10:45:00.000Z"}`, para representar tipos de data do MongoDB.

## 🔎 Consultas MongoDB

As consultas podem utilizar `find()`, filtros por igualdade, operadores relacionais (`$gt`, `$gte`, `$lt`, `$lte`), operadores lógicos (`$and`, `$or`), campos aninhados, projeções, `sort()` e `limit()`.

Selecionar o banco no MongoDB Shell:

```javascript
use seguranca_incidentes
```

**Incidentes associados a servidores:**

```javascript
db.incidentes.find({
  "ativo.tipo": "Servidor"
})
```

**Incidentes associados a servidores ou ativos de alta criticidade:**

```javascript
db.incidentes.find({
  $or: [
    { "ativo.tipo": "Servidor" },
    { "ativo.criticidade": "Alta" }
  ]
})
```

**Exemplo de projeção e limitação:**

```javascript
db.incidentes.find(
  { "ativo.tipo": "Servidor" },
  { titulo: 1, "ativo.nome": 1, "status.nome": 1 }
).limit(10)
```

## 📈 Aggregation Pipeline

### Agregação 1 — Incidentes por criticidade do ativo

```javascript
db.incidentes.aggregate([
  {
    $match: {
      "ativo.criticidade": { $exists: true }
    }
  },
  {
    $group: {
      _id: "$ativo.criticidade",
      total_incidentes: { $sum: 1 }
    }
  },
  {
    $sort: { total_incidentes: -1 }
  }
])
```

**Resultados apresentados na execução documentada:**

| Criticidade | Incidentes |
|---|---:|
| Crítica | 8.250 |
| Média | 8.250 |
| Alta | 8.250 |
| Baixa | 8.250 |

Esses resultados somam 33.000 incidentes com o campo de criticidade utilizado na agregação. A coleção exportada possui 33.002 documentos no total; portanto, nem todos necessariamente participam dessa consulta.

### Agregação 2 — Severidade dos incidentes em servidores

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
      quantidade: { $sum: 1 }
    }
  },
  {
    $sort: { quantidade: -1 }
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

Essa consulta agrupa incidentes relacionados a servidores pelo nível de severidade. O resultado exato depende dos dados presentes na coleção no momento da execução.

## ⚡ Indexação

Exemplo de índice utilizado para favorecer consultas por tipo de ativo:

```javascript
db.incidentes.createIndex(
  { "ativo.tipo": 1 },
  { name: "idx_ativo_tipo" }
)
```

Para verificar os índices:

```javascript
db.incidentes.getIndexes()
```

Para inspecionar o plano de execução de uma consulta:

```javascript
db.incidentes.find({
  "ativo.tipo": "Servidor"
}).explain("executionStats")
```

O resultado de `explain()` ajuda a verificar se um índice foi utilizado e a examinar estatísticas de execução.

## 📦 Organização dos arquivos no repositório

Uma organização possível é:

```text
projeto/
├── README.md
├── mysql/
│   ├── ddl_bd_incidentes_ti.sql
│   └── dml_bd_incidentes_ti.sql
└── mongodb/
    ├── incidentes.json
    ├── eventos_seguranca.json
    ├── auditoria_incidentes.json
    ├── alertas_seguranca.json
    ├── metricas_ativos.json
    ├── evidencias_digitais.json
    └── vulnerabilidades.json
```

**Observação:** a estrutura acima é uma sugestão de organização. Ajuste os nomes e caminhos para corresponder aos arquivos realmente publicados no seu repositório. Se alguma coleção estiver dividida em partes, mantenha os nomes correspondentes, como `incidentes_parte_1.json` e `incidentes_parte_2.json`.

## 🚀 Como executar e importar os dados

### Pré-requisitos

- Um servidor MySQL ou MariaDB disponível.
- MongoDB em execução.
- MongoDB Compass ou MongoDB Shell (`mongosh`).
- Arquivos SQL e JSON do projeto.

### 1. MySQL/MariaDB

1. Criar ou selecionar o banco `bd_incidentes_ti`.
2. Executar o script DDL para criar as tabelas, índices e relacionamentos.
3. Executar o script DML para inserir os registros.
4. Executar as consultas SQL e demais scripts documentados, conforme as dependências entre objetos.

> Evite executar comandos de recriação ou exclusão de tabelas sobre um banco que contenha dados importantes sem antes realizar backup.

### 2. MongoDB

Conectar ao servidor, por exemplo, usando a URI local:

```text
mongodb://localhost:27017
```

Selecionar o banco de dados:

```javascript
use seguranca_incidentes
```

Se necessário, criar as coleções:

```javascript
db.createCollection("incidentes")
db.createCollection("eventos_seguranca")
db.createCollection("auditoria_incidentes")
db.createCollection("alertas_seguranca")
db.createCollection("metricas_ativos")
db.createCollection("evidencias_digitais")
db.createCollection("vulnerabilidades")
```

### 3. Importar os JSONs no MongoDB Compass

1. Abrir o banco `seguranca_incidentes`.
2. Selecionar a coleção correspondente.
3. Usar a opção **Add Data / Import JSON or CSV** (o texto pode variar conforme a versão).
4. Selecionar o arquivo JSON da coleção.
5. Confirmar a importação e conferir a quantidade de documentos.

Caso um JSON tenha sido **dividido em partes para publicação no GitHub**, importe cada parte para a **mesma coleção**, em sequência. Não é necessário criar uma coleção diferente para cada parte.

Arquivos `.zip` precisam ser extraídos antes de selecionar os JSONs no importador do Compass. Evite importar novamente documentos que já estejam cadastrados, pois identificadores `_id` repetidos podem provocar erros de chave duplicada.

## 📦 Grandes volumes de dados e GitHub

O projeto trabalha com conjuntos de dados relativamente grandes. Para facilitar o versionamento, os arquivos podem ser organizados por coleção e, quando necessário, subdivididos em arquivos JSON válidos.

- Pelo navegador, o GitHub limita arquivos individuais a 25 MiB.
- Com Git/GitHub Desktop, arquivos individuais maiores podem ser enviados até o limite de 100 MiB.
- Arquivos individuais acima de 100 MiB exigem divisão ou uma solução como Git LFS.
- É recomendável não publicar credenciais, tokens, senhas ou dados pessoais reais em repositórios públicos.

## 🔗 Integração conceitual entre MySQL e MongoDB

A combinação dos bancos demonstra como tecnologias diferentes podem atender a necessidades complementares:

- **MySQL/MariaDB:** dados estruturados, relações entre entidades, chaves e integridade referencial.
- **MongoDB:** incidentes enriquecidos, eventos, alertas, evidências, métricas, vulnerabilidades e trilhas de auditoria em documentos flexíveis.

A proposta exemplifica uma estratégia de **persistência poliglota**. A presença dos dois bancos no projeto não implica, por si só, uma sincronização automática entre eles.

## 📚 Documentação do projeto

O repositório pode conter materiais relativos a:

- Levantamento de requisitos e modelagem entidade-relacionamento.
- Modelo relacional e dicionário de dados.
- Scripts DDL e DML do MySQL/MariaDB.
- Exports JSON das sete coleções do MongoDB.
- Consultas SQL e NoSQL.
- Exemplos CRUD e *Aggregation Pipeline*.
- Índices e estratégias de gerenciamento de grandes volumes.

## 🎓 Considerações finais

O projeto explora o uso conjunto de bancos relacionais e não relacionais em um cenário de gestão e monitoramento de incidentes de segurança da informação.

A estrutura relacional oferece organização e integridade para entidades relacionadas; já o MongoDB permite representar registros com diferentes atributos e informações aninhadas. Os exports utilizados na documentação reúnem **17 tabelas no banco relacional** e **7 coleções com 234.105 documentos no MongoDB**, proporcionando uma base para estudos de modelagem, consultas, agregações e indexação.
