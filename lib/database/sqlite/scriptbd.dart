//comando para criar tabela
const criarTabelas = [
  '''
  CREATE TABLE usuario(
    id INTEGER NOT NULL PRIMARY KEY
    ,usuario VARCHAR(200) NOT NULL
    ,email VARCHAR(150) NOT NULL
    ,senha VARCAHR(200) NOT NULL
  )
  ''',
  '''
 CREATE TABLE Tipo(
    id INTEGER NOT NULL PRIMARY KEY
    ,nome VARCHAR(200) NOT NULL
  )
''',
  '''
 CREATE TABLE Categoria(
    id INTEGER NOT NULL PRIMARY KEY
    ,nome VARCHAR(200) NOT NULL
  )
''',
  '''
 CREATE TABLE Autor(
    id INTEGER NOT NULL PRIMARY KEY
    ,nome VARCHAR(200) NOT NULL
    ,tipo_id INTEGER NOT NULL
    ,FOREIGN KEY (tipo_id) REFERENCES tipo (id)
  )
''',
  '''
CREATE TABLE Manga(
    id INTEGER NOT NULL PRIMARY KEY
    ,nome VARCHAR(200) NOT NULL
    ,descricao VARCHAR(200) NOT NULL
    ,url_avatar VARCHAR(300) NOT NULL
    ,categoria_id INTEGER NOT NULL
    ,autor_id INTEGER NOT NULL
    ,FOREIGN KEY (categoria_id) REFERENCES categoria (id)
    ,FOREIGN KEY (autor_id) REFERENCES autor (id)
  )
''',
  '''
 CREATE TABLE manga_categoria(
    manga_id INTEGER NOT NULL 
    ,categoria_id INTEGER NOT NULL 
    ,PRIMARY KEY (manga_id,categoria_id) 
    ,FOREIGN KEY (manga_id) REFERENCES manga (id)
    ,FOREIGN KEY (categoria_id) REFERENCES categoria (id)
  )
''',
  '''
 CREATE TABLE manga_autor(
    manga_id INTEGER NOT NULL 
    ,autor_id INTEGER NOT NULL 
    ,PRIMARY KEY (manga_id,autor_id) 
    ,FOREIGN KEY (manga_id) REFERENCES manga (id)
    ,FOREIGN KEY (autor_id) REFERENCES autor (id)
  )
''',
];

const insercoes = [
  '''
  INSERT INTO usuario (usuario, email, senha)
  VALUES ('vitor', 'vitor@hotmail.com','vitor')
''',
  '''
INSERT INTO tipo (nome)
VALUES ('Manga')
''',
  '''
INSERT INTO tipo (nome)
VALUES ('Livro')
''',
  '''
INSERT INTO tipo (nome)
VALUES ('Historias em Quadrinhos (HQ)')
''',
  '''
INSERT INTO tipo (nome)
VALUES ('Novel')
''',
  '''
INSERT INTO categoria (nome)
VALUES ('Ação')
''',
  '''
INSERT INTO categoria (nome)
VALUES ('Romance')
''',
  '''
INSERT INTO categoria (nome)
VALUES ('Terror')
''',
  '''
INSERT INTO categoria (nome)
VALUES ('Comédia')
''',
  '''
INSERT INTO autor (nome, tipo_id)
VALUES ('Masashi Kishimoto', 1)
''',
  '''
INSERT INTO manga (nome, descricao,  url_avatar, categoria_id, autor_id)
VALUES ('Naruto','Saske','https://cdn.pixabay.com/photo/2018/10/19/05/12/naruto-3757871_640.jpg', 1, 1)
''',
];
