import 'dart:io';

import 'package:angel3_container/mirrors.dart';
import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_framework/http.dart';
import 'package:angel3_graphql/angel3_graphql.dart';

import '/services/movie.dart';

const String _graphiqlPath = 'graphiql';

Future<void> start({String host = 'localhost', int port = 8080}) {
  return Future.value(Angel(reflector: MirrorsReflector()))
      .then((app) {
        _onAppCreated(app);
        return AngelHttp(app);
      })
      .then((http) => http.startServer(host, port))
      .then(_onServerStarted);
}

void _onAppCreated(Angel app) {
  MovieService().start(app);

  app.get('/$_graphiqlPath', graphiQL());
}

void _onServerStarted(HttpServer server) {
  final Uri uri = Uri(
    scheme: 'http',
    host: server.address.address,
    port: server.port,
  );
  print('Listening on $uri');
  final Uri graphiqlUri = uri.replace(path: _graphiqlPath);
  print('Access graphiql at $graphiqlUri');
}
