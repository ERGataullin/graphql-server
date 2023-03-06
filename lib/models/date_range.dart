import 'package:graphql_schema2/graphql_schema2.dart';

class DateRange {
  const DateRange({this.from, this.to}) : assert(from != null || to != null);

  static final GraphQLType graphQlType = objectType(
    'DateRange',
    fields: [
      GraphQLObjectField(
        'from',
        graphQLDate,
        resolve: (range, __) => range.from,
      ),
      GraphQLObjectField(
        'to',
        graphQLDate,
        resolve: (range, __) => range.to,
      ),
    ],
  );

  final DateTime? from;
  final DateTime? to;
}
