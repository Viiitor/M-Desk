
import 'package:mdesk/view/dto/autor.dart';

abstract class AutorInterfaceDAO {
  Future<Autor> salvar (Autor autor);
  Future<bool> excluir (dynamic id);
  Future<Autor> consultar(int id);
  Future<List<Autor>> consultarTodos();
}