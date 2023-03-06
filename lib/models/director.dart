import 'package:graphql_schema2/graphql_schema2.dart';

class Director {
  const Director({
    required this.id,
    required this.name,
    required this.gender,
    required this.uid,
    required this.department,
  });

  factory Director.fromJson(Map<String, dynamic> json) => Director(
        id: json['id'],
        name: json['name'],
        gender: json['gender'],
        uid: json['uid'],
        department: json['department'],
      );

  static final GraphQLType graphQlType = objectType(
    'Director',
    fields: [
      GraphQLObjectField(
        'id',
        graphQLInt,
        resolve: (director, __) => director.id,
      ),
      GraphQLObjectField(
        'name',
        graphQLString,
        resolve: (director, __) => director.name,
      ),
      GraphQLObjectField(
        'gender',
        graphQLPositiveInt,
        resolve: (director, __) => director.gender,
      ),
      GraphQLObjectField(
        'uid',
        graphQLInt,
        resolve: (director, __) => director.uid,
      ),
      GraphQLObjectField(
        'department',
        graphQLString,
        resolve: (director, __) => director.department,
      ),
    ],
  );

  final int id;
  final String name;
  final int gender; // Хотел энам, но там трансгендеры. Не понял кто есть кто.
  final int uid;
  final String department;
}
