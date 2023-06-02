import 'package:mdesk/view/dto/categoria.dart';

abstract class CategoriaInterfaceDAO {
  Future<Categoria> salvar(Categoria categoria);
  Future<bool> excluir(int id);
  Future<Categoria> consultar(int id);
  Future<List<Categoria>> consultarTodos();
}

