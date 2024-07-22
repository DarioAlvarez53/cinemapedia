import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  //Aqui van a ir las variables de entorno estaticas
  static String movieDbKey = dotenv.env ['THE_MOVIDB_KEY'] ?? 'No hay api key';
}