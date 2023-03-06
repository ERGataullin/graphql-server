import 'package:graphql_schema2/graphql_schema2.dart';

final GraphQLFieldInput pageInput = GraphQLFieldInput(
      'page',
      graphQLPositiveInt,
    ),
    limitInput = GraphQLFieldInput(
      'limit',
      graphQLPositiveInt,
    ),
    identifierInput = GraphQLFieldInput(
      'id',
      graphQLInt.nonNullable(),
    );
