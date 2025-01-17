import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalListView extends StatelessWidget {

  final List<Movie> movie;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListView({
    super.key, 
    required this.movie, 
    this.title, 
    this.subTitle, 
    this.loadNextPage
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column (
        children: [
          if(title != null || subTitle != null)
            _Title( title: title, subTitle: subTitle ),

          Expanded(
            child: ListView.builder(
              itemCount: movie.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _Slide(movie: movie[index]);
              },
            )
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Imagen o poster de la pelicula
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                fit: BoxFit.cover,
                movie.posterPath,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2,)
                      ),
                    );
                  }

                  return FadeIn(
                    child: child,
                  );

                  // return child;
                },
              ),
            ),
          ),

          const SizedBox(height: 5),

          //Nombre de la pelicula
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),

          //Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_rounded, color: Colors.yellow.shade800,),
                const SizedBox(width: 3),
                Text('${movie.voteAverage}', style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800)),
                const SizedBox(width: 10),
                const Spacer(),
                // Text('${movie.popularity}', style: textStyles.bodySmall,)
                Text(HumanFormat.number(movie.popularity), style: textStyles.bodySmall,)
              ],
            ),
          )

        ],
      ),
    );
  }
}



class _Title extends StatelessWidget {

  final String? title;
  final String? subTitle;
  const _Title({
    this.title, 
    this.subTitle
  });

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if(title != null)
          Text(title!, style: titleStyle,),

          const Spacer(),

          if(subTitle != null)
          FilledButton.tonal(
            onPressed: (){},
            style: const ButtonStyle(
              visualDensity: VisualDensity.compact
            ),
            child: Text( subTitle! )
          ),
        ],
      ),
    );
  }
}