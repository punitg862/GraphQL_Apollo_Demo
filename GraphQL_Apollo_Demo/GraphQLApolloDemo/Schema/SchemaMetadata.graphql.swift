// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

nonisolated protocol GraphQLApolloDemo_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == GraphQLApolloDemo.SchemaMetadata {}

nonisolated protocol GraphQLApolloDemo_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == GraphQLApolloDemo.SchemaMetadata {}

nonisolated protocol GraphQLApolloDemo_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == GraphQLApolloDemo.SchemaMetadata {}

nonisolated protocol GraphQLApolloDemo_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == GraphQLApolloDemo.SchemaMetadata {}

extension GraphQLApolloDemo {
  typealias SelectionSet = GraphQLApolloDemo_SelectionSet

  typealias InlineFragment = GraphQLApolloDemo_InlineFragment

  typealias MutableSelectionSet = GraphQLApolloDemo_MutableSelectionSet

  typealias MutableInlineFragment = GraphQLApolloDemo_MutableInlineFragment

  nonisolated enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    private static let objectTypeMap: [String: ApolloAPI.Object] = [
      "Country": GraphQLApolloDemo.Objects.Country,
      "Query": GraphQLApolloDemo.Objects.Query
    ]

    static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      objectTypeMap[typename]
    }
  }

  nonisolated enum Objects {}
  nonisolated enum Interfaces {}
  nonisolated enum Unions {}

}