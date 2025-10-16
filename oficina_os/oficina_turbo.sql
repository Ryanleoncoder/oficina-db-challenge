CREATE DATABASE oficina_turbo;
USE oficina_turbo;

CREATE TABLE cliente (
  idCliente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  tipo ENUM('PF','PJ') NOT NULL,
  cpf CHAR(11),
  cnpj CHAR(14),
  telefone CHAR(11),
  email VARCHAR(100),
  CHECK (
    (tipo = 'PF' AND cpf IS NOT NULL AND cnpj IS NULL)
    OR (tipo = 'PJ' AND cnpj IS NOT NULL AND cpf IS NULL)
  )
);

CREATE TABLE veiculo (
  idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
  idCliente INT,
  placa CHAR(7) UNIQUE NOT NULL,
  modelo VARCHAR(50),
  ano INT,
  FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE mecanico (
  idMecanico INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  especialidade VARCHAR(100),
  contato CHAR(11)
);

CREATE TABLE servico (
  idServico INT AUTO_INCREMENT PRIMARY KEY,
  descricao VARCHAR(100) NOT NULL,
  valor_unitario DECIMAL(10,2)
);

CREATE TABLE peca (
  idPeca INT AUTO_INCREMENT PRIMARY KEY,
  descricao VARCHAR(100) NOT NULL,
  valor_unitario DECIMAL(10,2),
  estoque INT DEFAULT 0
);

CREATE TABLE ordem_servico (
  idOS INT AUTO_INCREMENT PRIMARY KEY,
  idVeiculo INT,
  data_emissao DATE,
  status ENUM('Aberta','Em execução','Concluída','Cancelada') DEFAULT 'Aberta',
  valor_total DECIMAL(10,2),
  FOREIGN KEY (idVeiculo) REFERENCES veiculo(idVeiculo)
);

CREATE TABLE servico_os (
  idOS INT,
  idServico INT,
  idMecanico INT,
  quantidade INT DEFAULT 1,
  valor_total DECIMAL(10,2),
  PRIMARY KEY (idOS, idServico, idMecanico),
  FOREIGN KEY (idOS) REFERENCES ordem_servico(idOS),
  FOREIGN KEY (idServico) REFERENCES servico(idServico),
  FOREIGN KEY (idMecanico) REFERENCES mecanico(idMecanico)
);

CREATE TABLE peca_os (
  idOS INT,
  idPeca INT,
  quantidade INT DEFAULT 1,
  valor_total DECIMAL(10,2),
  PRIMARY KEY (idOS, idPeca),
  FOREIGN KEY (idOS) REFERENCES ordem_servico(idOS),
  FOREIGN KEY (idPeca) REFERENCES peca(idPeca)
);
