CREATE DATABASE educapp;
USE educapp;

CREATE TABLE Usuario (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  data_nascimento DATE,
  cpf CHAR(11) UNIQUE NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  login VARCHAR(50) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  tipo_usuario ENUM('aluno', 'professor', 'responsavel') NOT NULL
);

CREATE TABLE Aluno (
  id_usuario INT PRIMARY KEY,
  ra VARCHAR(20) NOT NULL UNIQUE,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Professor (
  id_usuario INT PRIMARY KEY,
  especialidade VARCHAR(50) NOT NULL,
  valor_hora_aula DECIMAL(10,2) NOT NULL DEFAULT 20.00,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Responsavel (
  id_usuario INT PRIMARY KEY,
  parentesco VARCHAR(30) NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Turma (
  id_turma INT AUTO_INCREMENT PRIMARY KEY,
  nome_turma VARCHAR(64) NOT NULL,
  ano_letivo INT NOT NULL,
  id_professor INT NOT NULL,

  FOREIGN KEY (id_professor) REFERENCES Professor(id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  UNIQUE (nome_turma, ano_letivo)
);

CREATE TABLE Turma_Aluno (
  id_turma INT NOT NULL,
  id_aluno INT NOT NULL,

  PRIMARY KEY (id_turma, id_aluno),

  FOREIGN KEY (id_turma) REFERENCES Turma(id_turma)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  FOREIGN KEY (id_aluno) REFERENCES Aluno(id_usuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Aula(
  id_aula INT AUTO_INCREMENT PRIMARY KEY,
  id_turma INT NOT NULL,
  data_aula DATE NOT NULL,
  sala VARCHAR(16) NOT NULL,
  status_aula ENUM('agendada', 'realizada', 'cancelada') NOT NULL,

  FOREIGN KEY (id_turma) REFERENCES Turma(id_turma)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE Frequencia(
  id_aula INT NOT NULL,
  id_aluno INT NOT NULL,
  presenca BOOLEAN NOT NULL,
  
  PRIMARY KEY (id_aula, id_aluno),
  
  FOREIGN KEY (id_aula) REFERENCES Aula(id_aula)
  	ON UPDATE CASCADE
  	ON DELETE CASCADE,
  
  FOREIGN KEY (id_aluno) REFERENCES Aluno(id_usuario)
  	ON UPDATE CASCADE
  	ON DELETE CASCADE
);

CREATE TABLE Avaliacao(
  id_avaliacao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_turma INT NOT NULL,
  id_aluno INT NOT NULL,
  nota DECIMAL(5,2) NOT NULL,
  data_avaliacao DATE NOT NULL,
  tipo_prova VARCHAR(64),
  
  FOREIGN KEY (id_turma) REFERENCES Turma(id_turma)
  	ON UPDATE CASCADE
  	ON DELETE CASCADE,
  
  FOREIGN KEY (id_aluno) REFERENCES Aluno(id_usuario)
  	ON UPDATE CASCADE
  	ON DELETE CASCADE
);

CREATE TABLE Financeiro(
  id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
  id_aluno INT NOT NULL,
  valor DECIMAL(15,2) NOT NULL,
  data_vencimento DATE NOT NULL,
  data_pagamento DATE,
  situacao ENUM('pendente', 'pago', 'atrasado', 'cancelado') NOT NULL,
  
  FOREIGN KEY (id_aluno) REFERENCES Aluno(id_usuario) 
  	ON UPDATE CASCADE
  	ON DELETE CASCADE
);

CREATE TABLE Mensagem (
  id_mensagem INT AUTO_INCREMENT PRIMARY KEY,
  id_remetente INT NOT NULL,
  id_destinatario INT NOT NULL,
  conteudo TEXT NOT NULL,
  data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lida BOOLEAN NOT NULL DEFAULT FALSE,

  FOREIGN KEY (id_remetente) REFERENCES Usuario(id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  FOREIGN KEY (id_destinatario) REFERENCES Usuario(id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);
CREATE SCHEMA IF NOT EXISTS `projeto_final` DEFAULT CHARACTER SET latin1 ; 
USE `projeto_final` ; 
-- Table `projeto_final`.`usuario` 
CREATE TABLE IF NOT EXISTS `projeto_final`.`usuario` ( `idusuario` INT(11) NOT NULL AUTO_INCREMENT, `nome` VARCHAR(150) NULL DEFAULT NULL, 
`cpf` VARCHAR(11) NOT NULL, 
`dataNascimento` DATE NULL DEFAULT NULL,  
`email` VARCHAR(150) NULL DEFAULT NULL,  
`senha` VARCHAR(45) NULL DEFAULT NULL,  
PRIMARY KEY (`idusuario`),  
UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC)) 
ENGINE = InnoDB 
DEFAULT CHARACTER SET = latin1;
-- Table `projeto_final`.`formacaoAcademica`  
CREATE TABLE IF NOT EXISTS `projeto_final`.`formacaoAcademica` ( `idformacaoAcademica` INT(11) NOT NULL AUTO_INCREMENT, `idusuario` INT(11) NOT NULL,  
`inicio` DATE NOT NULL,  
`fim` DATE NULL DEFAULT NULL,  
`descricao` VARCHAR(150) NULL DEFAULT NULL,  
PRIMARY KEY (`idformacaoAcademica`),  
INDEX `IDUSUARIO_idx` (`idusuario` ASC),  
CONSTRAINT `IDUSUARIO`  
FOREIGN KEY (`idusuario`)  
REFERENCES `projeto_final`.`usuario` (`idusuario`) 
ON DELETE NO ACTION  
ON UPDATE NO ACTION)  
ENGINE = InnoDB  
DEFAULT CHARACTER SET = latin1;  
SET SQL_MODE=@OLD_SQL_MODE;  
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;  
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS; 

CREATE Table experienciaprofissional (
idexperienciaprofissional INT NOT NULL auto_increment,
idusuario INT NOT NULL,
inicio DATE,
fim DATE,
empresa VARCHAR(45),
descricao VARCHAR(45),
primary key (idexperienciaprofissional),
foreign key (idusuario)
references usuario(idusuario)
);

CREATE TABLE IF NOT EXISTS `projeto_final`.`outrasformacoes` (
  `idoutrasformacoes` INT(11) NOT NULL AUTO_INCREMENT,
  `idusuario` INT(11) NOT NULL,
  `inicio` DATE NULL DEFAULT NULL,
  `fim` DATE NULL DEFAULT NULL,
  `descricao` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`idoutrasformacoes`),
  INDEX `idusuario_idx` (`idusuario` ASC),
  CONSTRAINT `fk_idUsuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `projeto_final`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

