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

- Definições da equipe:
Definir colunas a serem trabalhadas. <br>
Colunas obrigatórias para a equipe: orgao, item_elemento, item_categoria. <br>
Proposta para o dw: dim_tempo, dim_orgao, dim_item_elemento, dim_item_categoria, fato (5 tabelas).

## 5. Modelagem Lógica para o dw (BdSchema)

## 6. Bd dw (Data Warehouse)

## 7. Conexão dw com Microsoft Power BI

## 8. Dashboard