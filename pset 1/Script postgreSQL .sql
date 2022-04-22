psql -U postgres -W 

create user caroline with encrypted password 'Cale2407@' superuser createdb createrole;

psql -U caroline postgres -W
pass:Cale2407@

     create database uvv
     WITH 
     OWNER = caroline
     ENCODING = 'UTF8'
     template = template0
     LC_COLLATE = 'pt_BR.UTF-8'
     LC_CTYPE = 'pt_BR.UTF-8'
        ALLOW_CONNECTIONS = true;
\c uvv ;

create schema elmasri authorization caroline;
grant all privileges on all tables in schema elmasri to caroline;
SET search_path TO elmasri, "$caroline", public;

CREATE TABLE elmasri.funcionario (
              cpf CHAR(11) NOT NULL,
              primeiro_nome VARCHAR(15) NOT NULL,
              nome_meio CHAR(1),
              ultimo_nome VARCHAR(15) NOT NULL,
              data_nascimento DATE,
              endereco VARCHAR(40),
              sexo CHAR(1),
              salario NUMERIC(10,2),
              cpf_supervisor CHAR(11) NOT NULL,
              numero_departamento INTEGER NOT NULL,
              CONSTRAINT funcionario_pk PRIMARY KEY (cpf) 'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a culuna CPF que vai ser uma chave primária.'
);

insert into elmasri.funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
values ('João', 'B', 'Silva', '12345678966', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP','M','30000', '33344555587', '5'),
       ('Fernando', 'T', 'Wong', '33344555587', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M','40000', '33344555587', '5'),
       ('Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', '25000', '98765432168', '4'),
       ('Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av.Arthur de Lima, 54, Santo André, SP', 'F', '43000', '98765432168', '4'),
       ('Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', '38000', '33344555587', '5'),
       ('Joice', 'A', 'Leite', '45345345376', '1972-07-31', 'Av.Lucas Obes, 74, São Paulo, SP', 'F', '25000', '33344555587', '5'),
       ('André', 'V', 'Pereira', '98798798733', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', '25000', '98765432168', '4'),
       ('Jorge', 'E', 'Brito', '88866555576', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', '55000', '88866555576', '1');


COMMENT ON COLUMN elmasri.funcionario.cpf IS 'o cpf do funcionario vai ser o PK dessa tabela';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'primeiro nome do funcionario';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'inicial do nome do meio';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'sobrenome do funcionario';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'endereço do funcionario';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'sexo do funcionario';
COMMENT ON COLUMN elmasri.funcionario.salario IS 'salario do funcionario';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'o cpf supervisor vai sar uma FK para a propia tabela';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'numero do departamento do funcionario';


CREATE TABLE elmasri.departamento (
              numero_departamento INTEGER NOT NULL,
              nome_departamento VARCHAR(15) NOT NULL,
              cpf_gerente CHAR(11) NOT NULL,
              data_inicio_gerente DATE,
              CONSTRAINT departamento_pk PRIMARY KEY (numero_departamento)'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a coluna numero_departamento que vai ser uma chave primária.'
);

insert into elmasri.departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
values ('Pesquisa', '5', '33344555587', '1988-05-22'),
       ('Administração', '4', '98765432168', '1995-01-01'),
       ('Matriz', '1', '88866555576', '1981-06-19');


COMMENT ON TABLE elmasri.departamento IS 'tabela que armazena as informaçoes dos departamentos';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'é o pk dessa tabela';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'deve ser unico';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'é uma FK para a tabela de funcionarios';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'data do inicio do gerente no departamento';


CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento );'Restrição que permite que a coluna nome_departamento da tabela departamento seja uma chave alternativa ou secundaria. É uma combinação de colunas cujo valores são únicos'.  

CREATE TABLE elmasri.projeto (
              numero_projeto INTEGER NOT NULL,
              nome_projeto VARCHAR(15) NOT NULL,
              local_projeto VARCHAR(15),
              numero_departamento INTEGER NOT NULL,
              CONSTRAINT projeto_pk PRIMARY KEY (numero_projeto)'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a coluna numero_projeto que vai ser uma chave primária.'
);

insert into elmasri.projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) 
values ('ProdutoX', '1', 'Santo André', '5'),
       ('ProdutoY', '2', 'Itu', '5'),
       ('ProdutoZ', '3', 'São Paulo', '1'),
       ('Informação', '10', 'Mauá', '4'),
       ('Reorganização', '20', 'São Paulo', '1'),
       ('Novosbeneficios','30', 'Mauá', '4');

COMMENT ON TABLE elmasri.projeto IS 'tabela que armazena as informaçoes sobre os projetos dos departamentos';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'é a pK dessa tabela';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'deve ser unico';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'localizaçao do projeto';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'é uma FK para tabela departamento';


CREATE UNIQUE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto ); 'Restrição que permite que a coluna nome_projeto da tabela projeto seja uma chave alternativa ou secundaria. É uma combinação de colunas cujo valores são únicos'.  

CREATE TABLE elmasri.trabalha_em (
              numero_projeto INTEGER NOT NULL,
              cpf_funcionario CHAR(11) NOT NULL,
              horas NUMERIC(3,1) NOT NULL,
              CONSTRAINT trabalha_em_pk PRIMARY KEY (numero_projeto, cpf_funcionario)'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a coluna cpf_funcionario e a coluna numero_projeto que vão ser uma chave primária.'
);

insert into elmasri.trabalha_em (cpf_funcionario, numero_projeto, horas) 
values ('12345678966', '1', '32.5'),
       ('12345678966', '2', '7.5'),
       ('66688444476', '3', '40'),
       ('45345345376', '1', '20'),
       ('45345345376', '2', '20'),
       ('33344555587', '2', '10'),
       ('33344555587', '3', '10'),
       ('33344555587', '10', '10'),
       ('33344555587', '20', '10'),
       ('99988777767', '30', '30'),
       ('99988777767', '10', '10'),
       ('98798798733', '10', '35'),
       ('98798798733', '30', '5'),
       ('98765432168', '30', '20'),
       ('98765432168', '20', '15'),
       ('88866555576', '20', '0');


COMMENT ON TABLE elmasri.trabalha_em IS 'tabela que armazena quais funcionarios trabalham em quais projetos';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'é uma PK dessa tabela fazendo FK para tabela projeto';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'é PK dessa tabela e uma FK para tabela funcionarios';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'horas trabalhadas pelo funcionario neste projeto';


CREATE TABLE elmasri.localizacoes_departamento (
              local VARCHAR(15) NOT NULL,
              numero_departamento INTEGER NOT NULL,
              CONSTRAINT localizacoes_departamento_pk PRIMARY KEY (numero_departamento,local)'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a coluna numero_departamento e a coluna local que vão ser uma chave primária.'
);

insert into elmasri.localizacoes_departamento (numero_departamento, local) 
values ('1', 'São Paulo'),
       ('4', 'Mauá'),
       ('5', 'Santo André'),
       ('5', 'Itu'),
       ('5', 'São Paulo');

COMMENT ON TABLE elmasri.localizacoes_departamento IS 'tabela que armazena as possiveis localizaçoes dos departamentos';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'é a PK dessa tabela';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'é PK dessa tabela e tambem é FK para tabela departamento';


CREATE TABLE elmasri.dependente (
              nome_dependente VARCHAR(15) NOT NULL,
              cpf_funcionario CHAR(11) NOT NULL, 
              sexo CHAR(1),
              data_nascimento DATE,
              parentesco VARCHAR(15),
              CONSTRAINT dependentes_pk PRIMARY KEY (nome_dependente, cpf_funcionario)'Chave que serve como um índice de referencia para criar relacionamentos com as demais tabelas do banco de dados. Nesse caso é a coluna cpf_funcionario ou a coluna nome_dependente que vão ser uma chave primária.'
);

insert into elmasri.dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) 
values ('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
       ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
       ('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa'),
       ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
       ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
       ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'), 
       ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

COMMENT ON TABLE elmasri.dependente IS 'tabela que armazena as informaçoes dos dependentes dos funcionarios';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'é uma pk da tabela';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'é a PK dessa tabela fazendo uma FK para tabela funcionarios';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'sexo do dependente';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'data de nascimento do dependente';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'descriçao do parentesco do dependente com o funcionario';


ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna cpf_funcionario dessa tabela à coluna cpf da tabela funcionario. '

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna cpf_supervisor dessa tabela à coluna cpf da tabela funcionario.'

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna cpf_gerente dessa tabela à coluna cpf da tabela funcionario.'

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna cpf_funcionario dessa tabela à coluna cpf da tabela funcionario.'

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna numero_departamento dessa tabela à coluna numero_departamento da tabela departamento.'

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna numero_departamento dessa tabela à coluna numero_departamento da tabela departamento.'

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;'É uma coluna em uma tabela cujo valores devem corresponder aos valores de uma outra coluna em outra tabela. Nesse caso a chave estrangeira está relacionando a coluna numero_projeto dessa tabela à coluna numero_projeto da tabela projeto.'
 

ALTER TABLE elmasri.dependente ADD CONSTRAINT sexo_m_f_dependente CHECK( sexo IN ('M', 'F'));'É uma restrição para permitir que somente a letra F-feminino e a letra M-masculino sejam inseridas no campo sexo da tabela dependente.'

ALTER TABLE elmasri.funcionario ADD CONSTRAINT Sexo_m_f_funcionario CHECK ( sexo IN ('M', 'F'));'É uma restrição para permitir que somente a letra F-feminino e a letra M-masculino sejam inseridas no campo sexo da tabela funcionario.'

ALTER TABLE elmasri.funcionario ADD CONSTRAINT salario_funcionario CHECK (salario BETWEEN '1000' AND '200000' ) ;'É uma restrição para permitir que o salário do funcionário seje somente entre 1000 e 200000 reais.'

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT horas_trabalha_em CHECK (horas BETWEEN '0' AND '200'); 'É uma restrição para permitir que o número de horas trabalhadas seje somente entre 0 e 200 horas'

