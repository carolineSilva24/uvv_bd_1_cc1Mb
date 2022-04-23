mysql -u root -p

CREATE USER 'Caroline'@'localhost' identify by 'Cale2407';
GRANT ALL PRIVILEGES ON*.* TO 'Caroline'@'localhost';
quit

mysql -u Caroline -p

create database uvv;
use uvv;

CREATE TABLE funcionario (
  cpf CHAR(11) NOT NULL,
  primeiro_nome VARCHAR(15) NOT NULL,
  nome_meio CHAR(1),
  ultimo_nome VARCHAR(15) NOT NULL,
  data_nascimento DATE,
  endereco VARCHAR(50),
  sexo CHAR(1),
  salario DECIMAL(10,2),
  cpf_supervisor CHAR(11) NOT NULL,
  numero_departamento INT NOT NULL,
  PRIMARY KEY (cpf) 'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a coluna CPF que vai ser uma chave primária.'
  );
ALTER TABLE funcionario COMMENT 'Tabela que armazena as informações dos funcionários.';

CREATE TABLE dependente (
  cpf_funcionario CHAR(11) NOT NULL,
  nome_dependente VARCHAR(15) NOT NULL,
  sexo CHAR(1),
  parentesco VARCHAR(15),
  data_nascimento DATE,
  PRIMARY KEY (cpf_funcionario, nome_dependente) 'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a coluna cpf_funcionario ou a coluna nome_dependente que vão ser uma chave primária.'
  );
ALTER TABLE dependente COMMENT 'Tabela que armazena as informações dos dependentes dos funcionários.';

CREATE TABLE departamento (
  numero_departamento INT NOT NULL,
  nome_departamento VARCHAR(15) NOT NULL,
  cpf_gerente CHAR(11) NOT NULL,
  data_inicio_gerente DATE,
  PRIMARY KEY (numero_departamento)'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a coluna numero_departamento que vai ser uma chave primária.'
  );
ALTER TABLE departamento COMMENT 'Tabela que armazena as informaçoẽs dos departamentos.';

CREATE UNIQUE INDEX nome_departamento
  ON departamento
  ( nome_departamento ); 'Restrição que permite que a coluna nome_departamento da tabela departamento seja uma chave alternativa ou secundaria. É uma combinação de colunas cujo valores são únicos'.
 
  CREATE TABLE projeto (
  numero_projeto INT NOT NULL,
  nome_projeto VARCHAR(15) NOT NULL,
  local_projeto VARCHAR(15),
  numero_departamento INT NOT NULL,
  PRIMARY KEY (numero_projeto)'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a coluna numero_projeto que vai ser uma chave primária.'
  );
ALTER TABLE projeto COMMENT 'Tabela que armazena as informações sobre os projetos dos departamentos.';

CREATE UNIQUE INDEX nome_projeto
  ON projeto
  ( nome_projeto );'Restrição que permite que a coluna nome_projeto da tabela projeto seja uma chave alternativa ou secundaria. É uma combinação de colunas cujo valores são únicos'.  
 
CREATE TABLE trabalha_em (
  cpf_funcionario CHAR(11) NOT NULL,
  numero_projeto INT NOT NULL,
  horas DECIMAL(3,1) NOT NULL,
  PRIMARY KEY (cpf_funcionario, numero_projeto)'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a coluna cpf_funcionario e a coluna numero_projeto que vão ser uma chave primária.'
  );
ALTER TABLE trabalha_em COMMENT 'Tabela para armazenar quais funcionários trabalham em quais projetos.';

CREATE TABLE localizacoes_departamento (
  numero_departamento INT NOT NULL,
  local VARCHAR(15) NOT NULL,
  PRIMARY KEY (numero_departamento, local)'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a coluna numero_departamento e a coluna local que vão ser uma chave primária.'
  );
ALTER TABLE localizacoes_departamento COMMENT 'Tabela que armazena as possíveis localizações dos departamentos.';
 
 ALTER TABLE funcionario MODIFY COLUMN cpf char(11) comment 'CPF do funcionário. Será a PK da tabela.';
 ALTER TABLE funcionario MODIFY COLUMN primeiro_nome varchar(15) comment 'primeiro nome do funcionário.';
 ALTER TABLE funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio do funcionário.'; 
 ALTER TABLE funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) COMMENT 'Sobrenome do funcionário.'; 
 ALTER TABLE funcionario MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do funcionário'; 
 ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(50) COMMENT 'Endereço do funcionário.';
 ALTER TABLE funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do funcionário.'; 
 ALTER TABLE funcionario MODIFY COLUMN salario DECIMAL (10, 2) COMMENT 'Salário do funcionário.';
 ALTER TABLE funcionario MODIFY COLUMN cpf_supervisor CHAR(11) COMMENT 'CPF do supervisor. Será uma FK para a própria tabela.';
 ALTER TABLE funcionario MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento do funcionário.';

 ALTER TABLE dependente MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
 ALTER TABLE dependente MODIFY COLUMN nome_dependente varchar(15) COMMENT 'Nome do dependente. Faz parte da PK desta tabela.';
 ALTER TABLE dependente MODIFY COLUMN sexo char(1) COMMENT 'Sexo do dependente.';
 ALTER TABLE dependente MODIFY COLUMN data_nascimento date COMMENT 'Data de nascimento do dependente.';
 ALTER TABLE dependente MODIFY COLUMN parentesco varchar(15) COMMENT 'Descrição do parentesco do dependente com o funcionário.'; 

 ALTER TABLE departamento MODIFY COLUMN numero_departamento integer COMMENT 'Número do departamento. É a PK desta tabela.';
 ALTER TABLE departamento MODIFY COLUMN nome_departamento varchar(15) COMMENT 'Nome do departamento. Deve ser único.';
 ALTER TABLE departamento MODIFY COLUMN cpf_gerente char(11) COMMENT 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';
 ALTER TABLE departamento MODIFY COLUMN data_inicio_gerente date COMMENT 'Data do início do gerente no departamento.';

 ALTER TABLE projeto MODIFY COLUMN numero_projeto integer COMMENT 'Número do projeto. É a PK desta tabela.';
 ALTER TABLE projeto MODIFY COLUMN nome_projeto varchar(15) COMMENT 'Nome do projeto. Deve ser único.';
 ALTER TABLE projeto MODIFY COLUMN local_projeto varchar(15) COMMENT 'Localização do projeto.';
 ALTER TABLE projeto MODIFY COLUMN numero_departamento integer COMMENT 'Número do departamento. É uma FK para a tabela departamento.';

 ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario char(11) COMMENT 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
 ALTER TABLE trabalha_em MODIFY COLUMN numero_projeto integer COMMENT 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
 ALTER TABLE trabalha_em MODIFY COLUMN horas decimal(3,1) COMMENT 'Horas trabalhadas pelo funcionário neste projeto.';

 ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento integer COMMENT 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.'; 
 ALTER TABLE localizacoes_departamento MODIFY COLUMN local varchar(15)COMMENT 'Localização do departamento. Faz parte da PK desta tabela.';

INSERT INTO funcionario(primeiro_nome,nome_meio,ultimo_nome,cpf,data_nascimento,endereco,sexo,salario,cpf_supervisor,numero_departamento) VALUES (
'João','B','Silva','12345678966','1965-01-09','Rua das Flores,751,São Paulo,SP','M','30000','33344555587','5'),
('Fernando','T','Wong','33344555587','1955-12-08','Rua da Lapa,34,São Paulo,SP','M','40000','33344555587','5'),
('Alice','J','Zelaya','99988777767','1968-01-19','Rua Souza Lima,35,Curitiba,PR','F','25000','98765432168','4');
INSERT INTO funcionario(primeiro_nome,nome_meio,ultimo_nome,cpf,data_nascimento,endereco,sexo,salario,cpf_supervisor,numero_departamento) VALUES (
'Ronaldo','K','Lima','66688444476','1962-09-15','Rua Rebouças,65,Piracicaba,SP','M','38000','33344555587','5'),
('Joice','A','Leite','45345345376','1972-07-31','Av.Lucas Obes,74,São Paulo,SP','F','25000','33344555587','5'),
('André','V','Pereira','98798798733','1969-03-29','Rua Timbira,35,São Paulo,SP','M','25000','98765432168','4');
INSERT INTO funcionario(primeiro_nome,nome_meio,ultimo_nome,cpf,data_nascimento,endereco,sexo,salario,cpf_supervisor,numero_departamento) VALUES (
'Jorge','E','Brito','88866555576','1937-11-10','Rua do Horto,35,São Paulo,SP','M','55000','88866555576','1');
('Jennifer','S','Souza','98765432168','1941-06-20','Av.Arthur de Lima,54,Santo André,Sp','F','43000','98765432168','4');

INSERT INTO departamento (nome_departamento,numero_departamento,cpf_gerente,data_inicio_gerente) VALUES (
'Pesquisa','5','33344555587','1988-05-22'),
('Administração','4','98765432168','1995-01-01'),
('Matriz','1','88866555576','1981-06-19');

INSERT INTO dependente (cpf_funcionario,nome_dependente,sexo,data_nascimento,parentesco) VALUES (
'33344555587','Alicia','F','1986-04-05','Filha'),
('33344555587','Tiago','M','1983-10-25','Filho'),
('33344555587','Janaína','F','1958-05-03','Esposa'),
('98765432168','Antônio','M','1942-02-28','Marido');
INSERT INTO dependente (cpf_funcionario,nome_dependente,sexo,data_nascimento,parentesco) VALUES (
'12345678966','Michael','M','1988-01-04','Filho'),
('12345678966','Alicia','F','1988-12-30','Filha'),
('12345678966','Elizabeth','F','1967-05-05','Esposa');

INSERT INTO localizacoes_departamento (numero_departamento,local) VALUES (
'1','São Paulo'),
('4','Mauá'),
('5','Santo André'),
('5','Itu'),
('5','São Paulo');

INSERT INTO projeto (nome_projeto,numero_projeto,local_projeto,numero_departamento) VALUES (
'ProdutoX','1','Santo André','5'),
('ProdutoY','2','Itu','5'),
('ProdutoZ','3','São Paulo','5'),
('Informatização','10','Mauá','4'),
('Reorganização','20','São Paulo','1'),
('Novosbenefícios','30','Mauá','4');

INSERT INTO trabalha_em (cpf_funcionario,numero_projeto,horas) VALUES (
'12345678966','1','32.5'),
('12345678966','2','07.5'),
('66688444476','3','40'),
('45345345376','1','20'),
('45345345376','2','20');
INSERT INTO trabalha_em (cpf_funcionario,numero_projeto,horas) VALUES (
'33344555587','2','10'),
('33344555587','3','10'),
('33344555587','10','10'),
('33344555587','20','10'),
('99988777767','30','30');
INSERT INTO trabalha_em (cpf_funcionario,numero_projeto,horas) VALUES (
'99988777767','10','10'),
('98798798733','10','35'),
('98798798733','30','05'),
('98765432168','30','20'),
('98765432168','20','15');
INSERT INTO trabalha_em (cpf_funcionario,numero_projeto,horas) VALUES (
'88866555576','20','0');

ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
  FOREIGN KEY (cpf_funcionario)
  REFERENCES funcionario (cpf)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna cpf_funcionario dessa tabela à coluna cpf da tabela funcionario.'

ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
  FOREIGN KEY (cpf_funcionario)
  REFERENCES funcionario (cpf)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna cpf_funcionario dessa tabela à coluna cpf da tabela funcionario.'

 ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
  FOREIGN KEY (numero_departamento)
  REFERENCES departamento (numero_departamento)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna numero_departamento dessa tabela à coluna numero_departamento da tabela departamento.'

 ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
  FOREIGN KEY (numero_departamento)
  REFERENCES departamento (numero_departamento)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna numero_departamento dessa tabela à coluna numero_departamento da tabela departamento.'

 ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
  FOREIGN KEY (numero_projeto)
  REFERENCES projeto (numero_projeto)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna numero_projeto dessa tabela à coluna numero_projeto da tabela projeto.'
 
 ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
  FOREIGN KEY (cpf_gerente)
  REFERENCES funcionario (cpf)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna cpf_gerente dessa tabela à coluna cpf da tabela funcionario.'

 ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
  FOREIGN KEY (cpf_supervisor)
  REFERENCES funcionario (cpf)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna cpf_supervisor dessa tabela à coluna cpf da tabela funcionario.'

 ALTER TABLE dependente add constraint check (sexo in('M','F'));'É uma restrição para permitir que somente a letra F-feminino e a letra M-masculino sejam inseridas no campo sexo da tabela dependente.'

 ALTER TABLE funcionario add constraint check (sexo in('M','F'));'É uma restrição para permitir que somente a letra F-feminino e a letra M-masculino sejam inseridas no campo sexo da tabela funcionario.'

 ALTER TABLE funcionario add constraint check (salario between '1000' and '200000');'É uma restrição para permitir que o salário do funcionário seje somente entre 1000 e 200000 reais.'

 ALTER TABLE trabalha_em  add constraint check (horas between '0' and '200');'É uma restrição para permitir que o número de horas trabalhadas seje somente entre 0 e 200 horas'

