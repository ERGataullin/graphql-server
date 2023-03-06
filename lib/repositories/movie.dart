import 'dart:async';

import 'package:sqlite3/sqlite3.dart';

import '/models/date_range.dart';
import '/models/director.dart';
import '/models/movie.dart';

abstract class MovieRepository {
  FutureOr<Iterable<Movie>> getMovies({
    int? page,
    int? limit,
    DateRange? releaseDate,
    String? orderBy,
  });

  FutureOr<Movie> getMovie(int id);

  FutureOr<Iterable<Director>> getDirectors({int? page, int? limit});

  FutureOr<Director> getDirector(int id);
}

class SqliteMovieRepository implements MovieRepository {
  SqliteMovieRepository();

  static const String _moviesTable = 'movies', _directorsTable = 'directors';

  final Database _database = sqlite3.open('assets/movies.sqlite');

  @override
  Iterable<Movie> getMovies({
    int? page,
    int? limit,
    DateRange? releaseDate,
    String? orderBy,
  }) {
    assert(page == null || limit != null);
    final String query = [
      'SELECT * FROM $_moviesTable',
      if (releaseDate != null) ...[
        'WHERE',
        [
          if (releaseDate.from != null) 'release_date >= ?',
          if (releaseDate.to != null) 'release_date <= ?',
        ].join(' AND '),
      ],
      if (orderBy != null) 'ORDER BY $orderBy DESC',
      if (limit != null) 'LIMIT $limit',
      if (page != null && limit != null) 'OFFSET ${limit * page - limit}',
    ].join(' ');

    final List<Object?> arguments = [
      if (releaseDate?.from != null) releaseDate!.from!.toIso8601String(),
      if (releaseDate?.to != null) releaseDate!.to!.toIso8601String(),
    ];

    return _database.select(query, arguments).map((row) => Movie.fromJson(row));
  }

  @override
  Movie getMovie(int id) {
    return Movie.fromJson(_database.select(
      'SELECT * FROM $_moviesTable WHERE id=?',
      [id],
    ).single);
  }

  @override
  Iterable<Director> getDirectors({int? page, int? limit}) {
    assert(page == null || limit != null);
    final String query = [
      'SELECT * FROM $_directorsTable',
      if (limit != null) 'LIMIT $limit ',
      if (page != null && limit != null) 'OFFSET ${limit * page - limit}',
    ].join(' ');

    return _database.select(query).map((row) => Director.fromJson(row));
  }

  @override
  Director getDirector(int id) {
    return Director.fromJson(_database.select(
      'SELECT * FROM $_directorsTable WHERE id=?',
      [id],
    ).single);
  }
}
