import 'package:mdesk/view/dto/manga.dart';

abstract class MangaInterfaceDAO{
  Future<Manga> salvar(Manga manga);
  Future<bool> excluir(dynamic id);
  Future<Manga> consultar(int id);
  Future<List<Manga>> consultarTodos();
}