# Projeto Final Unidade 01 | SQL | Data Analytics | Digital College Brasil

Desenvolvimento de Projeto de Banco de Dados, desde o `RESTORE do bd` até a entrega do `DASHBOARD`.<br>
Tecnologias utilizadas: SQL / PostgreSQL / BdSchema / Microsoft Power BI.<br> 

Instituição: [Digital College Brasil](https://digitalcollege.com.br/) (Fortaleza/CE) <br>
Curso: Data Analytics (Turma 18) <br>
Instrutora: [Nayara Wakweski](https://github.com/NayaraWakewski) <br>

## Etapas de Desenvolvimento
1. Entendimento do Projeto (Kick Off)
2. Bd Produção
3. Bd Stage
4. ETL (Extract, Transform, Load) | Tratamento dos Dados
5. Modelagem Lógica para o dw (BdSchema)
6. Bd dw (Data Warehouse)
7. Conexão dw com Microsoft Power BI
8. Dashboard

Nota: Foi desenvolvida `DOCUMENTAÇÃO DO PROJETO` com informações detalhadas para cada etapa (Anexo pasta `files`).<br>

## 1. Entendimento do Projeto (Kick Off)

### 1.1. Sobre o Projeto
A área de negócio do projeto foi uma base real de Execução Financeira e Despesa da Controladoria Geral do Estado do Ceará (CGE-CE).
O objetivo deste projeto é construir um ambiente de análise de dados robusto a partir de uma base relacional, utilizando as técnicas de ETL para criar um Data Warehouse eficaz.  
O projeto visa desenvolver análises que servirão como base para tomadas de decisões estratégicas para o negócio.

### 1.2. Time envolvido (Data Analysts)
Renato Albuquerque <br>
Vinicius Costa <br>
Alexsandro Cassiano <br>
Antonio Marcos <br>
Emmanuel Pinto

### 1.3. Prazos
Início: 28/10/2024 <br>
Término: 23/11/2024

### 1.4. Planejamento / Kick Off
Leitura e discussão do material (Briefing do Projeto, Dicionário explicando as colunas e dados da tabela, Conhecimento do bd). Material anexo, pasta `files`.

### 1.5. Cronograma 
Desenvolvimento de cronograma para planejar cada fase de execução do projeto.

![screenshot](/images/kick_off.png) <br>

## 2. Bd Produção

- Criar bd `projeto_cgece`.
```
create database projeto_cgece;
```

- Realizar `RESTORE` do bd do projeto. <br>
(image)

- Visualizar a tabela execucao_financeira_despesa (schema public), as colunas e os dados.
```
select * from public.execucao_financeira_despesa
limit 5;
```
(image)

## 3. Bd Stage

- Criar o bd `STAGE`.
```
create schema stage;
```

- Criar tabela execucao_financeira_despesa.
```
create table stage.execucao_financeira_despesa (
	num_ano character varying not null,
	cod_ne character varying not null,
	codigo_orgao character varying not null, 
	dsc_orgao character varying,
	cod_fonte character varying,
	dsc_fonte character varying,
	cod_funcao character varying,
	dsc_funcao character varying,
	cod_item character varying,
	dsc_item character varying,
	cod_item_elemento character varying,
	dsc_item_elemento character varying,
	cod_item_categoria character varying,
	dsc_item_categoria character varying,
	cod_item_grupo character varying,
	dsc_item_grupo character varying,
	dsc_modalidade_licitacao character varying,
	cod_item_modalidade character varying,
	dsc_item_modalidade character varying,
	cod_programa character varying,
	dsc_programa character varying,
	cod_subfuncao character varying,
	dsc_subfuncao character varying,
	cod_np character varying,
	vlr_empenho numeric(18,2),
	vlr_pagamento numeric(18,2),
	dth_empenho date,
	dth_pagamento date,
	id serial not null primary key,
	num_ano_np character varying	
);
```
```
select * from stage.execucao_financeira_despesa;
```
(image)

- Carregar dados na tabela stage.execucao_financeira_despesa.
```
insert into stage.execucao_financeira_despesa (
	num_ano,
	cod_ne,
	codigo_orgao, 
	dsc_orgao,
	cod_fonte,
	dsc_fonte,
	cod_funcao,
	dsc_funcao,
	cod_item,
	dsc_item,
	cod_item_elemento,
	dsc_item_elemento,
	cod_item_categoria,
	dsc_item_categoria,
	cod_item_grupo,
	dsc_item_grupo,
	dsc_modalidade_licitacao,
	cod_item_modalidade,
	dsc_item_modalidade,
	cod_programa,
	dsc_programa,
	cod_subfuncao,
	dsc_subfuncao,
	cod_np,
	vlr_empenho,
	vlr_pagamento,
	dth_empenho,
	dth_pagamento,
	id,
	num_ano_np	
)
select num_ano,
	cod_ne,
	codigo_orgao, 
	dsc_orgao,
	cod_fonte,
	dsc_fonte,
	cod_funcao,
	dsc_funcao,
	cod_item,
	dsc_item,
	cod_item_elemento,
	dsc_item_elemento,
	cod_item_categoria,
	dsc_item_categoria,
	cod_item_grupo,
	dsc_item_grupo,
	dsc_modalidade_licitacao,
	cod_item_modalidade,
	dsc_item_modalidade,
	cod_programa,
	dsc_programa,
	cod_subfuncao,
	dsc_subfuncao,
	cod_np,
	vlr_empenho,
	vlr_pagamento,
	dth_empenho,
	dth_pagamento,
	id,
	num_ano_np
from public.execucao_financeira_despesa;
``` 

- Visualizar a tabela execucao_financeira_despesa (stage), as colunas e os dados.
```
select * from stage.execucao_financeira_despesa
limit 5;
```
(image)

## 4. ETL (Extract, Transform, Load) | Tratamento dos Dados

- Tomada de decisão da equipe: <br>
Definir colunas a serem trabalhadas. <br>
Colunas obrigatórias para a equipe: orgao, item_elemento, item_categoria. <br>
Proposta para o dw: dim_tempo, dim_orgao, dim_item_elemento, dim_item_categoria, fato (5 tabelas).

### Tratamento dos dados - Valores nulos. Colunas codigo_orgao, dsc_orgao.
```
select distinct codigo_orgao, dsc_orgao
from stage.execucao_financeira_despesa;

select count(*) as total, count(codigo_orgao) as total_cod_orgao, count(dsc_orgao) as total_dsc_orgao
from stage.execucao_financeira_despesa; -- Coluna dsc_orgao com valores a menor, checar.
```

```
select distinct codigo_orgao, dsc_orgao
from stage.execucao_financeira_despesa
where dsc_orgao is null; -- 22 linhas null (439 linhas no total).
```

```
update stage.execucao_financeira_despesa
set dsc_orgao = 'NÃO INFORMADO'
where dsc_orgao is null; -- Valores atualizados.
```

```
select count(*) as total, count(codigo_orgao) as total_cod_orgao, count(dsc_orgao) as total_dsc_orgao
from stage.execucao_financeira_despesa; -- Todas as colunas com valores iguais.

select distinct codigo_orgao, dsc_orgao
from stage.execucao_financeira_despesa;
```

Nota: Inserir visualizções das consultas (Em breve).

### Tratamento dos dados - Valores duplicados. Colunas codigo_orgao, dsc_orgao.
```
select distinct codigo_orgao, dsc_orgao
from stage.execucao_financeira_despesa
group by codigo_orgao, dsc_orgao; --1086 resultados

select distinct codigo_orgao, dsc_orgao
from stage.execucao_financeira_despesa
group by codigo_orgao, dsc_orgao
having count(codigo_orgao) > 1; --1084 resultados
```

```
update stage.execucao_financeira_despesa
set dsc_orgao = 'FUNDO DE PREVIDENCIA PARLAMENTAR DA ASSEMB LEGISL DO CE'
where dsc_orgao = 'FUNDO DE PREVIDENCIA PARLAMENTAR'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_orgao = 'SECRETARIA DA FAZENDA'
where dsc_orgao = 'SECRETARIA DA FAZENDAsssssssssssssssssss'; -- Valores atualizados.
```

Nota: Inserir visualizções das consultas (Em breve).

### Tratamento dos dados - Valores nulos. Colunas cod_item_elemento, dsc_item_elemento.
```
select distinct cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa;

select count(*) as total, 
	count(cod_item_elemento) as total_cod_item_elemento, 
	count(dsc_item_elemento) as total_dsc_item_elemento
from stage.execucao_financeira_despesa; -- Coluna count(*) com valores a menor, checar.
```

```
select cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa
where dsc_item_elemento is null; -- 1683 linhas null.
```

```
update stage.execucao_financeira_despesa
set cod_item_elemento = '00'
where cod_item_elemento is null; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'NÃO INFORMADO'
where dsc_item_elemento is null; -- Valores atualizados.
```

```
select count(*) as total, 
	count(cod_item_elemento) as total_cod_item_elemento, 
	count(dsc_item_elemento) as total_dsc_item_elemento
from stage.execucao_financeira_despesa; -- Todas as colunas com valores iguais.

select distinct cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa;
```

Nota: Inserir visualizções das consultas (Em breve).

### Tratamento dos dados - Valores duplicados. Colunas cod_item_elemento, dsc_item_elemento.
```
select distinct cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa
group by cod_item_elemento, dsc_item_elemento; --82 resultados

select distinct cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa
group by cod_item_elemento, dsc_item_elemento
having count(dsc_item_elemento) > 1; --82 resultados
```

Nota: Inserir visualizções das consultas (Em breve).

### Tratamento dos dados - Corrigir dados duplicados, erro digitacao, texto minúsculo. Colunas cod_item_elemento, dsc_item_elemento.

```
update stage.execucao_financeira_despesa
set cod_item_elemento = '11'
where dsc_item_elemento = 'VENCIMENTOS E VANTAGENS FIXAS - PESSOAL'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'OUTRAS DESPESAS VARIÁVEIS - PESSOAL CIVIL'
where dsc_item_elemento = 'OUTRAS DESPESAS VARIÁVEIS - PESSOAL CIVI'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = upper(dsc_item_elemento);

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'PREMIAÇÕES CULTURAIS, ARTÍSTICAS, CIENTÍFICAS, DESPORTIVAS E OUTRAS'
where dsc_item_elemento = 'PREMIAÇÕES CULTURAIS, ARTÍSTICAS, CIENTÍ'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'OUTROS ENCARGOS SOBRE A DÍVIDA POR CONTRATO'
where cod_item_elemento = '22'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'ENCARGOS PELA HONRA DE AVAIS, GARANTIAS, SEGUROS E SIMILARES'
where cod_item_elemento = '27'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'OUTRAS DESPESAS DE PESSOAL DECORRENTES DE CONTRATOS DE TERCEIRIZAÇÃO'
where cod_item_elemento = '34'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'SERVIÇOS DE CONSULTORIA'
where cod_item_elemento = '35'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'OUTROS SERVIÇOS DE TERCEIROS - PESSOA FÍSICA'
where cod_item_elemento = '36'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'OUTROS SERVIÇOS DE TERCEIROS - PESSOA JURÍDICA'
where cod_item_elemento = '39'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'OUTROS AUXÍLIOS FINANCEIROS A PESSOAS FÍSICAS'
where cod_item_elemento = '48'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'PENSÕES ESPECIAIS'
where cod_item_elemento = '59'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'CONSTITUIÇÃO OU AUMENTO DE CAPITAL DE EMPRESAS'
where cod_item_elemento = '65'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'RATEIO PELA PARTICIPAÇÃO EM CONSÓRCIO PÚBLICO'
where cod_item_elemento = '70'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'RESSARCIMENTO DE DESPESAS DE PESSOAL REQUISITADO'
where cod_item_elemento = '96'; -- Valores atualizados.

select cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa
group by cod_item_elemento, dsc_item_elemento;
```

Nota: Inserir visualizções das consultas (Em breve).

### Tratamento dos dados - Valores nulos. Colunas cod_item_categoria, dsc_item_categoria.
```
select distinct cod_item_categoria, dsc_item_categoria
from stage.execucao_financeira_despesa;

select count(*) as total, 
	count(cod_item_categoria) as total_cod_item_categoria, 
	count(dsc_item_categoria) as total_dsc_item_categoria
from stage.execucao_financeira_despesa; -- Todas as colunas com a mesma qtde. de dados. 0 null.
```

Nota: Inserir visualizções das consultas (Em breve).

### Tratamento dos dados - Valores duplicados. Colunas cod_item_categoria, dsc_item_categoria.
```
select distinct cod_item_categoria, dsc_item_categoria
from stage.execucao_financeira_despesa;
```

```
update stage.execucao_financeira_despesa
set dsc_item_categoria = 'DESPESAS CORRENTES'
where dsc_item_categoria = 'DESPESA CORRENTE'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_categoria = 'DESPESAS DE CAPITAL'
where dsc_item_categoria = 'DESPESA DE CAPITAL'; -- Valores atualizados.

select distinct cod_item_categoria, dsc_item_categoria
from stage.execucao_financeira_despesa;
```

Nota: Inserir visualizções das consultas (Em breve).

### Tratamento dos dados - Valores nulos. Colunas vlr_empenho, vlr_pagamento.
```
select * from stage.execucao_financeira_despesa
limit 5;

select distinct vlr_empenho, vlr_pagamento
from stage.execucao_financeira_despesa;

select count(*) as total, 
	count(vlr_empenho) as total_vlr_empenho,
	count(vlr_pagamento) as total_vlr_pagamento
from stage.execucao_financeira_despesa; -- Coluna vlr_pagamento com valores a menor.
```

```
select vlr_pagamento
from stage.execucao_financeira_despesa
where vlr_pagamento is null; -- 111276 linhas null.
```

```
update stage.execucao_financeira_despesa
set vlr_pagamento = '0.00'
where vlr_pagamento is null; -- Valores atualizados.

select count(*) as total, 
	count(vlr_empenho) as total_vlr_empenho,
	count(vlr_pagamento) as total_vlr_pagamento
from stage.execucao_financeira_despesa; -- Valores corrigidos.
```

Nota: Inserir visualizções das consultas (Em breve).

### Tratamento dos dados - Valores negativos. Colunas vlr_empenho, vlr_pagamento.
```
select vlr_pagamento, vlr_empenho
from stage.execucao_financeira_despesa
where vlr_pagamento < 0 or vlr_empenho < 0;
```

Nota: Inserir visualizções das consultas (Em breve).

### Tratamento dos dados - Valores nulos. Colunas dth_empenho, dth_pagamento.
```
select distinct dth_empenho, dth_pagamento
from stage.execucao_financeira_despesa;

select count(*) as total, 
	count(dth_empenho) as total_dth_empenho,
	count(dth_pagamento) as total_dth_pagamento
from stage.execucao_financeira_despesa; -- Coluna dth_pagamento com valores a menor.
```

```
select dth_pagamento
from stage.execucao_financeira_despesa
where dth_pagamento is null; -- 111276 linhas null.
```

```
select count(*) as total, 
	count(dth_empenho) as total_dth_empenho,
	count(dth_pagamento) as total_dth_pagamento
from stage.execucao_financeira_despesa; -- Valores corrigidos.
```

Nota: Inserir visualizções das consultas (Em breve).

## 5. Modelagem Lógica para o dw (DbSchema)

![screenshot](/images/dbschema.png) <br>

## 6. Bd dw (Data Warehouse)

### Criar o bd dw, data_warehouse (Modelagem física).
```
create schema dw;
```

### Criar as tabelas do dw (data warehouse). 
05 tabelas: <br>
dim_tempo <br>  
dim_orgao <br>
dim_item_elemento <br> 
dim_item_categoria <br> 
fato_execucao_financeira

```
-- dim_tempo
create table dw.dim_tempo (
	id serial not null primary key,	
	data_inteira date,
	ano integer,
	mes integer,
	dia integer
);

-- dim_orgao
create table dw.dim_orgao (
	id serial not null primary key,
	codigo_orgao text,
	dsc_orgao text
);

-- dim_item_elemento
create table dw.dim_item_elemento (
	id serial not null primary key,
	cod_item_elemento text,
	dsc_item_elemento text
);

-- dim_item_categoria
create table dw.dim_item_categoria (
	id serial not null primary key,
	cod_item_categoria text,
	dsc_item_categoria text
);

-- fato_execucao_financeira
create table dw.fato_execucao_financeira (
	id serial not null primary key,
	id_orgao INTEGER REFERENCES dw.dim_orgao(id),
	id_item_categoria INTEGER REFERENCES dw.dim_item_categoria(id),
    id_item_elemento INTEGER REFERENCES dw.dim_item_elemento(id),
	id_dth_empenho INTEGER REFERENCES dw.dim_tempo(id),
    id_dth_pagamento INTEGER REFERENCES dw.dim_tempo(id),
	vlr_empenho NUMERIC(18,2),
    vlr_pagamento NUMERIC(18,2)
);
```

### Inserir os dados nas tabelas Dimensão e Fato (dw).

```
-- dim_tempo
INSERT INTO dw.dim_tempo (data_inteira, ano, mes, dia)
SELECT
dt as data_inteira,
EXTRACT (YEAR FROM dt) AS ano,
EXTRACT (MONTH FROM dt) AS mes,
EXTRACT (DAY FROM dt) AS dia
FROM generate_series (CURRENT_DATE -INTERVAL '30 years', CURRENT_DATE + INTERVAL '5 years', INTERVAL '1 day') AS dt;

-- dim_orgao
insert into dw.dim_orgao (codigo_orgao, dsc_orgao)
select distinct codigo_orgao, dsc_orgao
from stage.execucao_financeira_despesa;

-- dim_item_elemento
insert into dw.dim_item_elemento (cod_item_elemento, dsc_item_elemento)
select distinct cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa;

-- dim_item_categoria
insert into dw.dim_item_categoria (cod_item_categoria, dsc_item_categoria)
select distinct cod_item_categoria, dsc_item_categoria
from stage.execucao_financeira_despesa
order by cod_item_categoria;

-- fato_execucao_financeira
insert into dw.fato_execucao_financeira (
	id_orgao, id_item_categoria, id_item_elemento, id_dth_empenho, id_dth_pagamento, vlr_empenho, vlr_pagamento)
select dor.id as id_orgao, 
		dic.id as id_item_categoria, 
		die.id as id_item_elemento, 
		dt_empenho.id as id_data_empenho,
		dt_pagamento.id as id_data_pagamento,
		vlr_empenho as valor_empenho, 
		vlr_pagamento as valor_pagamento
from stage.execucao_financeira_despesa efd
inner join dw.dim_orgao dor on efd.codigo_orgao = dor.codigo_orgao
inner join dw.dim_item_elemento die on efd.cod_item_elemento = die.cod_item_elemento
inner join dw.dim_item_categoria dic on efd.cod_item_categoria = dic.cod_item_categoria
inner join dw.dim_tempo dt_empenho on efd.dth_empenho = dt_empenho.data_inteira
left join dw.dim_tempo dt_pagamento on efd.dth_pagamento = dt_pagamento.data_inteira;

--
select * from dw.dim_tempo;
select * from dw.dim_orgao;
select * from dw.dim_item_elemento;
select * from dw.dim_item_categoria;
select * from dw.fato_execucao_financeira;
--
```

## 7. Conexão dw com Microsoft Power BI
Conexão/integração realizada entre os softwares `PostgreSQL` e `Microsoft Power BI`.

## 8. Dashboard

![screenshot](/images/dashboard.jpg) <br>