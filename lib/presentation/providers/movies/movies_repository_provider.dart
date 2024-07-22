import 'package:cinemapedia/infrastructure/datasource/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este es un provider de solo lectura o inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImplementation(
    datasources: MoviedbDatasource()
  );
});