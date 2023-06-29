//comando para criar tabela
const criarTabelas = [
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

];

const insercoes = [
'''
INSERT INTO categoria (nome)
VALUES ('Ação')
''',
'''
INSERT INTO categoria (nome)
VALUES ('Romance')
''','''
INSERT INTO categoria (nome)
VALUES ('Terror')
''',
'''
INSERT INTO categoria (nome)
VALUES ('Comédia')
''',

'''
INSERT INTO autor (nome)
VALUES ('Masashi Kishimoto')
''',

'''
INSERT INTO manga (nome, descricao,  url_avatar, categoria_id, autor_id)
VALUES ('Naruto','Saske','https://cdn.pixabay.com/photo/2018/10/19/05/12/naruto-3757871_640.jpg', 1, 1)
''',

];
