/* import 'package:mdesk/database/daofake/dados_fake.dart';
import 'package:mdesk/view/dto/manga.dart';
import 'package:mdesk/view/interface/manga_interface_dao.dart';

class MangaDAOFake implements MangaInterfaceDAO {

  @override
  Future<Manga> consultar(int id) {
    return Future.value(mangas[id - 1]);
  }

  @override
  Future<List<Manga>> consultarTodos() {
    return Future.value(mangas);
  }

  @override
  Future<bool> excluir(dynamic id) {
    print('excluir ${mangas[id - 1]}');
    mangas.remove(mangas[id - 1]);
    return true;
  }

  @override
  Future<Manga> salvar(Manga manga) {
    if (manga.id == null) {
      manga = Manga(
        id: mangas.length,
        nome: manga.nome,
        descricao: manga.descricao,
        urlAvatar: manga.urlAvatar,
      );
      mangas.add(manga);
    } else {
      int i = (manga.id as int) -1;
      mangas[i] = manga;
    }
    print(manga);
    return manga;
  }
}

*/