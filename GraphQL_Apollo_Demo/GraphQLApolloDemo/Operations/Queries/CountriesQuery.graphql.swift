// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension GraphQLApolloDemo {
  nonisolated struct CountriesQuery: GraphQLQuery {
    static let operationName: String = "Countries"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query Countries { countries { __typename code name emoji } }"#
      ))

    public init() {}

    nonisolated struct Data: GraphQLApolloDemo.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { GraphQLApolloDemo.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("countries", [Country].self),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        CountriesQuery.Data.self
      ] }

      var countries: [Country] { __data["countries"] }

      /// Country
      ///
      /// Parent Type: `Country`
      nonisolated struct Country: GraphQLApolloDemo.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { GraphQLApolloDemo.Objects.Country }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", GraphQLApolloDemo.ID.self),
          .field("name", String.self),
          .field("emoji", String.self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          CountriesQuery.Data.Country.self
        ] }

        var code: GraphQLApolloDemo.ID { __data["code"] }
        var name: String { __data["name"] }
        var emoji: String { __data["emoji"] }
      }
    }
  }

}