-- Pset 2 
 -- Resolução das questões em script
 
-- Questão 1
SELECT AVG(salario) AS media_salarial ,numero_departamento
 FROM funcionario
 GROUP BY numero_departamento;

-- Questão 2
SELECT
 CASE f.sexo
 WHEN 'M' THEN 'Homens'
 WHEN 'F' THEN 'Mulheres'
 ELSE ''
 END sexo
 ,AVG(salario) AS media_salarial
 FROM funcionario f
 GROUP BY sexo;

-- Questão 3 
-- OBS: Antes de fazer a questão pedida eu calculei e adicionei as idades dos funcionarios,
-- O comando abaixo serve para adicionar a coluna idade na tabela funcionario.
ALTER TABLE funcionario 
 ADD idade int(3);
 
-- Estou colocando no resultado um número inteiro por ser uma idade, e escrevendo logo embaixo no update para adicionar o valor da idade na nova coluna 'idade' da tabela Funcionario.
SELECT datediff ('2022-05-03','1965-01-09')/365.25 AS 'idade de João';
UPDATE funcionario set idade = 57 WHERE primeiro_nome = 'João';
SELECT datediff ('2022-05-03','1955-12-08')/365.25 AS 'idade de fernando';
UPDATE funcionario set idade = 66 WHERE primeiro_nome = 'Fernando';
SELECT datediff ('2022-05-03','1968-01-19')/365.25 AS 'idade de Alice';
UPDATE funcionario set idade = 54 WHERE primeiro_nome = 'Alice';
SELECT datediff ('2022-05-03','1962-09-15')/365.25 AS 'idade de Ronaldo';
UPDATE funcionario set idade = 59 WHERE primeiro_nome = 'Ronaldo';
SELECT datediff ('2022-05-03','1972-07-31')/365.25 AS 'idade de Joice';
UPDATE funcionario set idade = 49 WHERE primeiro_nome = 'Joice';
SELECT datediff ('2022-05-03','1969-03-29')/365.25 AS 'idade de André';
UPDATE funcionario set idade = 53 WHERE primeiro_nome = 'André';
SELECT datediff ('2022-05-03','1937-11-10')/365.25 AS 'idade de Jorge';
UPDATE funcionario set idade = 84 WHERE primeiro_nome = 'Jorge';
SELECT datediff ('2022-05-03','1941-06-20')/365.25 AS 'idade de Jennifer';
UPDATE funcionario set idade = 80 WHERE primeiro_nome = 'Jennifer';

 -- Após incluir as idades, agora retornei as colunas separando por nome de cada departamento e os dados pessoais pedidos.
SELECT d.nome_departamento
 ,concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nome_completo, f.data_nascimento, f.idade, f.salario
 FROM departamento d
 INNER JOIN funcionario f ON d.numero_departamento=f.numero_departamento;

-- Questão 4
SELECT concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nome_completo,idade,salario AS salario_atual, salario *1.20 AS salario_reajustado
 FROM funcionario f
 WHERE salario < 35000 
 UNION
SELECT concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nome_completo,idade,salario AS salario_atual, salario *1.15 AS salario_reajustado
 FROM funcionario f
 WHERE salario >= 35000;

-- Questão 5
WITH gerente AS (SELECT concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nome,
 f.cpf FROM funcionario f)
SELECT d.nome_departamento,concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nome_funcionario,
 g.nome AS nome_gerente
 FROM departamento d
 INNER JOIN funcionario f ON f.numero_departamento = d.numero_departamento
 INNER JOIN gerente g ON g.cpf = d.cpf_gerente
 ORDER BY d.nome_departamento ASC, f.salario DESC;

-- Questão 6
-- O comando abaixo foi utilizado para adicionar a coluna idade_dependente na tabela dependente.
ALTER TABLE dependente  
 ADD idade_dependente int(3);
 
-- Adicionei o valor da idade inteira para ser adicionado na coluna, depois de ter calculado o valor diminuindo do dia que eu fiz essa questão da data de nascimento.
SELECT datediff ('2022-05-03','1986-04-05')/365.25 AS 'idade de Alicia.W';
UPDATE dependente set idade_dependente = 36 WHERE nome_dependente = 'Alicia' AND cpf_funcionario ='33344555587';
SELECT datediff ('2022-05-03','1958-05-03')/365.25 AS 'idade de Janaína';
UPDATE dependente set idade_dependente = 64  WHERE nome_dependente = 'Janaína';
SELECT datediff ('2022-05-03','1983-10-25')/365.25 AS 'idade de Tiago';
UPDATE dependente set idade_dependente = 38 WHERE nome_dependente = 'Tiago';
SELECT datediff ('2022-05-03','1942-02-28')/365.25 AS 'idade de Antônio';
UPDATE dependente set idade_dependente = 80  WHERE nome_dependente = 'Antônio';
SELECT datediff ('2022-05-03','1988-12-30')/365.25 AS 'idade de Alicia.S';
UPDATE dependente set idade_dependente = 33  WHERE nome_dependente = 'Alicia' AND cpf_funcionario ='12345678966';
SELECT datediff ('2022-05-03','1967-05-05')/365.25 AS 'idade de Elizabeth';
UPDATE dependente set idade_dependente = 54  WHERE nome_dependente = 'Elizabeth';
SELECT datediff ('2022-05-03','1988-01-04')/365.25 AS 'idade de Michael';
UPDATE dependente set idade_dependente = 34 WHERE nome_dependente = 'Michael';

SELECT dpt.nome_departamento
 ,concat(f.primeiro_nome, " ", f.nome_meio, ". ", f.ultimo_nome) AS nome_funcionario
 ,concat(dpd.nome_dependente, " ",f.nome_meio, ". ",f.ultimo_nome) AS nome_completo_dependente
 ,dpd.idade_dependente
 ,CASE dpd.sexo
 WHEN 'M' THEN 'Masculino'
 WHEN 'F' THEN 'Feminino'
 ELSE ''
 END sexo_dependente
 FROM funcionario AS f
 INNER JOIN departamento dpt ON (dpt.numero_departamento = f.numero_departamento)
 LEFT JOIN dependente dpd ON (dpd.cpf_funcionario = f.cpf)
 WHERE NOT dpd.nome_dependente IS null;

-- Questão 7
SELECT dpt.nome_departamento 
 ,concat(f.primeiro_nome, " ", f.nome_meio, " ", f.ultimo_nome) AS nome_completo
 ,f.salario
 FROM funcionario AS f
 INNER JOIN departamento dpt ON (dpt.numero_departamento = f.numero_departamento)
 LEFT JOIN dependente dpd ON (dpd.cpf_funcionario = f.cpf)
 WHERE dpd.nome_dependente IS null;

-- Questão 8
SELECT DISTINCT d.nome_departamento
 ,concat('(Nº',t.numero_projeto, ')', p.nome_projeto) AS numero_e_nome_projeto
 ,concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nome_completo 
 ,t.horas 
 FROM funcionario AS f
 INNER JOIN departamento AS d
 INNER JOIN projeto AS p
 INNER JOIN trabalha_em AS t
 INNER JOIN funcionario ON f.cpf = t.cpf_funcionario
 WHERE f.numero_departamento = d.numero_departamento
 AND p.numero_projeto = t.numero_projeto 
 ORDER BY p.numero_projeto;

-- Questão 9
SELECT p.nome_projeto , d.nome_departamento , SUM(t.horas) AS horas_trabalhadas
 FROM trabalha_em AS t
 INNER JOIN projeto AS p ON p.numero_projeto = t.numero_projeto 
 INNER JOIN departamento AS d ON p.numero_departamento = d.numero_departamento
 GROUP BY t.numero_projeto, p.nome_projeto , d.nome_departamento;

 -- Questão 10
SELECT concat('(Nº',d.numero_departamento, ')', d.nome_departamento) AS Numero_e_nome_departamento
 ,AVG(SALARIO) AS media_salarial 
 FROM funcionario AS f
 INNER JOIN departamento AS d ON f.numero_departamento = d.numero_departamento
 GROUP BY d.nome_departamento
 ORDER BY numero_e_nome_departamento;

-- Questão 11
SELECT concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nome_completo 
 ,p.nome_projeto 
 ,t.horas *50 AS valor_recebido
 FROM trabalha_em AS t 
 INNER JOIN projeto AS p ON p.numero_projeto = t.numero_projeto
 INNER JOIN funcionario AS f ON f.cpf = t.cpf_funcionario
 ORDER BY nome_completo;

-- Questão 12
SELECT d.nome_departamento, p.nome_projeto
 ,concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nome_completo 
 FROM trabalha_em AS t
 INNER JOIN projeto AS p ON p.numero_projeto = t.numero_projeto
 INNER JOIN departamento AS d ON d.numero_departamento = p.numero_departamento
 INNER JOIN funcionario AS f ON f.cpf = t.cpf_funcionario
 WHERE t.horas is NULL ;

-- Questão 13
SELECT *
 FROM (SELECT concat(f.primeiro_nome, " ",f.nome_meio, ". ",f.ultimo_nome, " (funcionario)") AS nome_completo
 ,f.idade
 ,CASE f.sexo
 WHEN 'M' THEN 'Masculino'
 WHEN 'F' THEN 'Feminino'
 END AS sexo
 FROM funcionario AS f, departamento AS d
 UNION
SELECT concat(dpd.nome_dependente, " ",f.nome_meio, ". ",f.ultimo_nome, " (dependente)") AS nome_completo
 ,dpd.idade_dependente
 ,CASE dpd.sexo
 WHEN 'M' THEN 'Masculino'
 WHEN 'F' THEN 'Feminino'
 END AS sexo     
 FROM funcionario AS f, departamento AS d, dependente AS dpd
 WHERE dpd.cpf_funcionario = f.cpf AnD d.numero_departamento = f.numero_departamento) AS presenteados
 ORDER BY idade DESC;
 
-- Questão 14
SELECT concat('(Nº',d.numero_departamento, ')', d.nome_departamento) AS Numero_e_nome_departamento
 ,count(*) AS quantidade_de_funcionarios
 FROM departamento AS d
 JOIN funcionario f ON (f.numero_departamento = d.numero_departamento)
 GROUP BY numero_e_nome_departamento;

-- Questão 15
-- Todos os funcionários estão alocados em algum projeto.
SELECT concat(f.primeiro_nome,' ',f.nome_meio,'. ',f.ultimo_nome) AS nome_completo_funcionario
 ,d.nome_departamento, p.nome_projeto
 FROM funcionario f
 INNER JOIN trabalha_em t ON t.cpf_funcionario = f.cpf 
 INNER JOIN projeto p ON t.numero_projeto = p.numero_projeto 
 INNER JOIN departamento d ON d.numero_departamento = f.numero_departamento 
 WHERE f.numero_departamento = d.numero_departamento
 ORDER BY nome_completo;
