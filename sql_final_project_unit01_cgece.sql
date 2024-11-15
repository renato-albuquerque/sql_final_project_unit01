-- Visualizar a tabela execucao_financeira_despesa (public), as colunas e os dados.
select * from public.execucao_financeira_despesa
limit 5;

-- Criar o bd STAGE.
create schema stage;

-- Criar tabela execucao_financeira_despesa.
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

-- Carregar dados na tabela stage.execucao_financeira_despesa.
select * from stage.execucao_financeira_despesa;

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

-- Visualizar a tabela execucao_financeira_despesa (stage), as colunas e os dados.
select * from stage.execucao_financeira_despesa
limit 5;

-- Definir colunas a serem trabalhadas. 
-- Obrigatórias para a equipe A: orgao, item_elemento, item_categoria.
-- Proposta para o dw: dim_tempo, dim_orgao, dim_item_elemento, dim_item_categoria, fato (5 tabelas).

-- Tratamento dos dados - Valores nulos. Colunas codigo_orgao, dsc_orgao.
select distinct codigo_orgao, dsc_orgao
from stage.execucao_financeira_despesa;

select count(*) as total, count(codigo_orgao) as total_cod_orgao, count(dsc_orgao) as total_dsc_orgao
from stage.execucao_financeira_despesa; -- Coluna dsc_orgao com valores a menor, checar.

select distinct codigo_orgao, dsc_orgao
from stage.execucao_financeira_despesa
where dsc_orgao is null; -- 22 linhas null.

update stage.execucao_financeira_despesa
set dsc_orgao = 'NÃO INFORMADO'
where dsc_orgao is null; -- Valores atualizados.

select count(*) as total, count(codigo_orgao) as total_cod_orgao, count(dsc_orgao) as total_dsc_orgao
from stage.execucao_financeira_despesa; -- Todas as colunas com valores iguais.

select distinct codigo_orgao, dsc_orgao
from stage.execucao_financeira_despesa;

-- Tratamento dos dados - Valores duplicados. Colunas codigo_orgao, dsc_orgao.
select distinct codigo_orgao, dsc_orgao
from stage.execucao_financeira_despesa
group by codigo_orgao, dsc_orgao; --1086 resultados

select distinct codigo_orgao, dsc_orgao
from stage.execucao_financeira_despesa
group by codigo_orgao, dsc_orgao
having count(codigo_orgao) > 1; --1084 resultados

update stage.execucao_financeira_despesa
set dsc_orgao = 'FUNDO DE PREVIDENCIA PARLAMENTAR DA ASSEMB LEGISL DO CE'
where dsc_orgao = 'FUNDO DE PREVIDENCIA PARLAMENTAR'; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_orgao = 'SECRETARIA DA FAZENDA'
where dsc_orgao = 'SECRETARIA DA FAZENDAsssssssssssssssssss'; -- Valores atualizados.

--
-- Dados com mesmo código e duas descrições (Checar).
-- 

-- Tratamento dos dados. Colunas cod_item_elemento, dsc_item_elemento.
select distinct cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa;

select count(*) as total, 
		count(cod_item_elemento) as total_cod_item_elemento, 
		count(dsc_item_elemento) as total_dsc_item_elemento
from stage.execucao_financeira_despesa; -- Coluna count(*) com valores a menor, checar.

select cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa
where dsc_item_elemento is null; -- 1683 linhas null.

update stage.execucao_financeira_despesa
set cod_item_elemento = '00'
where cod_item_elemento is null; -- Valores atualizados.

update stage.execucao_financeira_despesa
set dsc_item_elemento = 'NÃO INFORMADO'
where dsc_item_elemento is null; -- Valores atualizados.

select count(*) as total, 
		count(cod_item_elemento) as total_cod_item_elemento, 
		count(dsc_item_elemento) as total_dsc_item_elemento
from stage.execucao_financeira_despesa; -- Todas as colunas com valores iguais.

select distinct cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa;

-- Tratamento dos dados - Valores duplicados. Colunas cod_item_elemento, dsc_item_elemento.
select distinct cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa
group by cod_item_elemento, dsc_item_elemento; --82 resultados

select distinct cod_item_elemento, dsc_item_elemento
from stage.execucao_financeira_despesa
group by cod_item_elemento, dsc_item_elemento
having count(dsc_item_elemento) > 1; --82 resultados

-- Corrigir dados duplicados, erro digitacao, texto minúsculo.
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




-- Tratamento dos dados. Colunas cod_item_categoria, dsc_item_categoria.
