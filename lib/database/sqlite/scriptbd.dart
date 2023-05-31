//comando para criar tabela
const criarManga = '''
 CREATE TABLE Manga(
    id INTEGER NOT NULL PRIMARY KEY
    ,nome VARCHAR(200) NOT NULL
    ,descricao VARCHAR(200) NOT NULL
    ,url_avatar VARCHAR(300) NOT NULL 
  )
''';
//array de inserções
const insercoesManga = [
  '''
INSERT INTO manga (nome, descricao, url_avatar)
VALUES ('Naruto','Saske,'https://cdn.pixabay.com/photo/2018/10/19/05/12/naruto-3757871_640.jpg')
'''
];
