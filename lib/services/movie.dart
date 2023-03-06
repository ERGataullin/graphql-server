import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_graphql/angel3_graphql.dart';
import 'package:graphql_schema2/graphql_schema2.dart';
import 'package:graphql_server2/graphql_server2.dart';

import '/models/common.dart' as common;
import '/models/date_range.dart';
import '/models/director.dart';
import '/models/movie.dart';
import '/repositories/movie.dart';

class MovieService extends Service<int, Movie> {
  final MovieRepository _repository = SqliteMovieRepository();

  void start(Angel app) {
    app.use<int, Movie, MovieService>('api/movies', MovieService());

    final GraphQLSchema schema = graphQLSchema(
      queryType: objectType(
        'query',
        fields: [
          _movies,
          _movie,
          _directors,
          _director,
        ],
      ),
    );

    app.all('/graphql', graphQLHttp(GraphQL(schema)));
  }

  GraphQLObjectField get _movies => GraphQLObjectField(
        'movies',
        Movie.graphQlType.nonNullable().list(),
        arguments: [
          common.pageInput,
          common.limitInput,
          GraphQLFieldInput(
            'release_date',
            DateRange.graphQlType.coerceToInputObject(),
          ),
          GraphQLFieldInput(
            'order_by',
            GraphQLEnumType<String>(
              'MovieField',
              Movie.graphQlFields
                  .map((field) => GraphQLEnumValue(field.name, field.name))
                  .toList(growable: false),
            ),
          ),
        ],
        resolve: (_, arguments) => _repository.getMovies(
          page: arguments[common.pageInput.name],
          limit: arguments[common.limitInput.name],
          releaseDate: arguments.containsKey('release_date')
              ? DateRange(
                  from: arguments['release_date']['from'],
                  to: arguments['release_date']['to'],
                )
              : null,
          orderBy: arguments['order_by'],
        ),
      );

  GraphQLObjectField get _movie => GraphQLObjectField(
        'movie',
        Movie.graphQlType.nonNullable(),
        arguments: [
          common.identifierInput,
        ],
        resolve: (_, arguments) => _repository.getMovie(
          arguments[common.identifierInput.name],
        ),
      );

  GraphQLObjectField get _directors => GraphQLObjectField(
        'directors',
        GraphQLListType(Director.graphQlType.nonNullable()),
        arguments: [
          common.pageInput,
          common.limitInput,
        ],
        resolve: (_, arguments) => _repository.getDirectors(
          page: arguments[common.pageInput.name],
          limit: arguments[common.limitInput.name],
        ),
      );

  GraphQLObjectField get _director => GraphQLObjectField(
        'director',
        Director.graphQlType.nonNullable(),
        arguments: [
          common.identifierInput,
        ],
        resolve: (_, arguments) => _repository.getDirector(
          arguments[common.identifierInput.name],
        ),
      );
}
