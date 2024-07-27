//este archivo solo va a ser utilizado por the movie db

import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/movie_db_response.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/config/constants/env.dart';
import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasources {

  //El paquete "dio" nos sirve para hacer peticiones http
  final dio = Dio(
    BaseOptions(
      //aqui definimos la base url
      baseUrl: 'https://api.themoviedb.org/3',
      //aqui definimos los parametros de ser necesarios
      queryParameters: {
        'api_key': Env.movieDbKey,
        'language': 'es-MX'
      }
    )
  );
  //aqui se va a implementar lo que el datasource pida
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    
    //aqui se pone el path para terminar la peticion http
    final response = await dio.get('/movie/now_playing');
    
    final movieDBResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList(); 

    return movies;
  }

}