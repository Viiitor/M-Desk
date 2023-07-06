import 'package:mdesk/view/dto/tipo.dart';

abstract class TipoInterfaceDAO {
  Future<Tipo> salvar(Tipo tipo);
  Future<bool> excluir(dynamic id);
  Future<Tipo> consultar(int id);
  Future<List<Tipo>> consultarTodos();
}
