# Documentação PSet 2
### Aluno: Caroline Andrade Silva - CC1Mb
### Professor: Abrantes Araújo Silva Filho
### Monitora: Suellen Miranda Amorim

#### Explicação

 Esse subdiretório é a resolução do segundo pset proposto pelo professor, que contêm varios relatórios escrito no formato SQL pelo SGBD MariaDB, que quando colado no terminal aparecerá uma tabela com o que cada questão pede. Os dados e as tabelas foram implementados anteriormente no banco de dados "uvv" do modelo MySQL criado por mim durante o PSet 1, o projeto desenvolvido é o que está nos capítulos 6 e 7 do livro texto de referência da disciplina, chamado sistemas de banco de dados dos autores Elmasri e Navathe.

**OBS:** Alguns comentários estão escritos dentro de cada questão no Script, pois tive que fazer algumas mudanças para um melhor resultado.
 
-- questao 15 
SELECT concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS nome_completo
 ,d.nome_departamento, p.nome_projeto
 FROM funcionario f
 INNER JOIN trabalha_em t ON t.cpf_funcionario = f.cpf 
 INNER JOIN projeto p ON t.numero_projeto = p.numero_projeto 
 INNER JOIN departamento d ON d.numero_departamento = f.numero_departamento 
 WHERE f.numero_departamento = p.numero_departamento;
