CREATE TABLE formas (
  id_forma INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(30) NOT NULL,
  PRIMARY KEY(id_forma)
)
TYPE=InnoDB;

CREATE TABLE usuarios (
  id_usuario CHAR(10) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL,
  senha VARCHAR(50) NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  numero NUMERIC(4,0) NOT NULL,
  complemento VARCHAR(20) NULL,
  bairro VARCHAR(100) NOT NULL,
  cidade VARCHAR(100) NOT NULL,
  uf CHAR(2) NOT NULL,
  cep VARCHAR(9) NOT NULL,
  rg VARCHAR(12) NULL,
  cpf VARCHAR(11) NOT NULL,
  ativo_sn CHAR(1) NOT NULL DEFAULT S,
  data_cadastro DATE NOT NULL,
  data_inativacao DATE NULL,
  bloqueado_sn CHAR(1) NOT NULL DEFAULT N,
  PRIMARY KEY(id_usuario)
)
TYPE=InnoDB;

CREATE TABLE cores (
  id_cor INTEGER UNSIGNED NOT NULL,
  descricao VARCHAR(20) NOT NULL,
  PRIMARY KEY(id_cor)
)
TYPE=InnoDB;

CREATE TABLE categorias (
  id_categoria INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(100) NOT NULL,
  PRIMARY KEY(id_categoria)
)
TYPE=InnoDB;

CREATE TABLE usuarios_boletos (
  id_boleto INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario CHAR(10) NOT NULL,
  codigo_barras VARCHAR(40) NOT NULL,
  linha_digitavel VARCHAR(40) NOT NULL,
  valor NUMERIC(10,2) NOT NULL,
  dt_vencimento DATE NOT NULL,
  pago_sn CHAR(1) NOT NULL DEFAULT N,
  mes_referencia VARCHAR(6) NOT NULL,
  PRIMARY KEY(id_boleto),
  INDEX FK_USUARIOSBOLETOS_USUARIOS(id_usuario),
  FOREIGN KEY(id_usuario)
    REFERENCES usuarios(id_usuario)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
TYPE=InnoDB;

CREATE TABLE formas_cores (
  id_forma INTEGER UNSIGNED NOT NULL,
  id_cor INTEGER UNSIGNED NOT NULL,
  url_imagem VARCHAR(200) NOT NULL,
  PRIMARY KEY(id_forma, id_cor),
  INDEX FK_FORMASCORES_CORES(id_cor),
  INDEX FK_FORMASCORES_FORMAS(id_forma),
  INDEX PRIMARY(id_forma, id_cor),
  FOREIGN KEY(id_cor)
    REFERENCES cores(id_cor)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY(id_forma)
    REFERENCES formas(id_forma)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)
TYPE=InnoDB;

CREATE TABLE jogos (
  id_jogo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario CHAR(10) NOT NULL,
  id_cor INTEGER UNSIGNED NOT NULL,
  id_forma INTEGER UNSIGNED NOT NULL,
  id_categoria INTEGER UNSIGNED NOT NULL,
  nome VARCHAR(50) NOT NULL,
  descricao TEXT NULL,
  data_criacao DATE NOT NULL,
  ativo_sn CHAR(1) NOT NULL DEFAULT S,
  PRIMARY KEY(id_jogo),
  INDEX FK_JOGOS_CATEGORIAS(id_categoria),
  INDEX FK_JOGOS_FORMASCORES(id_forma, id_cor),
  INDEX FK_JOGOS_USUARIOS(id_usuario),
  FOREIGN KEY(id_categoria)
    REFERENCES categorias(id_categoria)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(id_forma, id_cor)
    REFERENCES formas_cores(id_forma, id_cor)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(id_usuario)
    REFERENCES usuarios(id_usuario)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
TYPE=InnoDB;

CREATE TABLE jogos_atributos (
  id_atributo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  id_jogo INTEGER UNSIGNED NOT NULL,
  nome VARCHAR(30) NOT NULL,
  medida VARCHAR(5) NULL,
  PRIMARY KEY(id_atributo),
  INDEX FK_JOGOSATRIBUTOS_JOGOS(id_jogo),
  FOREIGN KEY(id_jogo)
    REFERENCES jogos(id_jogo)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)
TYPE=InnoDB;

CREATE TABLE jogos_cartas (
  id_carta INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  id_jogo INTEGER UNSIGNED NOT NULL,
  codigo VARCHAR(2) NOT NULL,
  url_imagem VARCHAR(150) NOT NULL,
  atributo_1 NUMERIC(10,5) NOT NULL,
  atributo_2 NUMERIC(10,5) NOT NULL,
  atributo_3 NUMERIC(10,5) NOT NULL,
  atributo_4 NUMERIC(10,5) NOT NULL,
  atributo_5 NUMERIC(10,5) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  img_auxiliar VARCHAR(150) NULL,
  texto_auxiliar VARCHAR(40) NULL,
  PRIMARY KEY(id_carta),
  INDEX FK_JOGOSCARTAS_JOGOS(id_jogo),
  FOREIGN KEY(id_jogo)
    REFERENCES jogos(id_jogo)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)
TYPE=InnoDB;

CREATE TABLE convites (
  id_convite INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  id_jogo INTEGER UNSIGNED NOT NULL,
  id_usuario CHAR(10) NOT NULL,
  email VARCHAR(255) NOT NULL,
  data_convite DATE NOT NULL,
  jogou_sn CHAR(1) NOT NULL DEFAULT S,
  PRIMARY KEY(id_convite),
  INDEX FK_CONVITES_USUARIOS(id_usuario),
  INDEX FK_CONVITES_JOGOS(id_jogo),
  FOREIGN KEY(id_usuario)
    REFERENCES usuarios(id_usuario)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY(id_jogo)
    REFERENCES jogos(id_jogo)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)
TYPE=InnoDB;

CREATE TABLE usuarios_jogos (
  id_jogo INTEGER UNSIGNED NOT NULL,
  id_usuario CHAR(10) NOT NULL,
  data_cadastro DATE NULL,
  PRIMARY KEY(id_jogo, id_usuario),
  INDEX FK_USUARIOSJOGOS_USUARIOS(id_usuario),
  INDEX FK_USUARIOSJOGOS_JOGOS(id_jogo),
  INDEX PRIMARY(id_jogo, id_usuario),
  FOREIGN KEY(id_usuario)
    REFERENCES usuarios(id_usuario)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY(id_jogo)
    REFERENCES jogos(id_jogo)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)
TYPE=InnoDB;


