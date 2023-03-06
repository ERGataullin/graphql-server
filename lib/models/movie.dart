import 'package:graphql_schema2/graphql_schema2.dart';

class Movie {
  const Movie({
    required this.id,
    required this.originalTitle,
    required this.budget,
    required this.popularity,
    required this.releaseDate,
    required this.revenue,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    this.overview,
    this.tagline,
    required this.uid,
    required this.directorId,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'],
        originalTitle: json['original_title'],
        budget: json['budget'],
        popularity: json['popularity'],
        releaseDate: DateTime.parse(json['release_date']),
        revenue: json['revenue'],
        title: json['title'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
        overview: json['overview'],
        tagline: json['tagline'],
        uid: json['uid'],
        directorId: json['director_id'],
      );

  static final GraphQLType graphQlType = objectType(
    'Movie',
    fields: graphQlFields,
  );

  static final List<GraphQLObjectField> graphQlFields = [
    GraphQLObjectField(
      'id',
      graphQLInt,
      resolve: (movie, __) => movie.id,
    ),
    GraphQLObjectField(
      'original_title',
      graphQLString,
      resolve: (movie, __) => movie.originalTitle,
    ),
    GraphQLObjectField(
      'budget',
      graphQLInt,
      resolve: (movie, __) => movie.budget,
    ),
    GraphQLObjectField(
      'popularity',
      graphQLInt,
      resolve: (movie, __) => movie.popularity,
    ),
    GraphQLObjectField(
      'release_date',
      graphQLDate,
      resolve: (movie, __) => movie.releaseDate,
    ),
    GraphQLObjectField(
      'revenue',
      graphQLInt,
      resolve: (movie, __) => movie.revenue,
    ),
    GraphQLObjectField(
      'title',
      graphQLString,
      resolve: (movie, __) => movie.title,
    ),
    GraphQLObjectField(
      'vote_average',
      graphQLFloat,
      resolve: (movie, __) => movie.voteAverage,
    ),
    GraphQLObjectField(
      'vote_count',
      graphQLInt,
      resolve: (movie, __) => movie.voteCount,
    ),
    GraphQLObjectField(
      'overview',
      graphQLString,
      resolve: (movie, __) => movie.overview,
    ),
    GraphQLObjectField(
      'tagline',
      graphQLString,
      resolve: (movie, __) => movie.tagline,
    ),
    GraphQLObjectField(
      'uid',
      graphQLInt,
      resolve: (movie, __) => movie.uid,
    ),
    GraphQLObjectField(
      'director_id',
      graphQLInt,
      resolve: (movie, __) => movie.directorId,
    ),
  ];

  final int id;
  final String originalTitle;
  final int budget;
  final int popularity;
  final DateTime releaseDate;
  final int revenue;
  final String title;
  final double voteAverage;
  final int voteCount;
  final String? overview;
  final String? tagline;
  final int uid;
  final int directorId;
}
