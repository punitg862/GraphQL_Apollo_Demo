//
//  MockApolloClient.swift
//  GraphQL_Apollo_Demo
//
//  Created by Punit Gupta on 31/08/26.
//

import Apollo
@testable import ApolloAPI
import XCTest
import Foundation

@testable import GraphQL_Apollo_Demo

class MockApolloClient: ApolloClientProtocol {
    var shouldFail = false
    var mockData: GraphQLApolloDemo.CountriesQuery.Data?
    var mockError: Error?
    
    func fetchQuery<Query: GraphQLQuery>(
            query: Query,
            cachePolicy: CachePolicy.Query.SingleResponse
    ) async throws -> GraphQLResponse<Query> {
        if shouldFail {
            throw mockError ?? NSError(domain: "MockError", code: 500)
        }
        guard let data = mockData as? Query.Data else {
            throw NSError(domain: "MockError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Mock data type mismatch"])
        }
        return GraphQLResponse<Query>(
            data: data,
            extensions: nil,
            errors: nil,
            source: .server,
            dependentKeys: nil
        )
    }
    
    func createMockCountriesData() -> GraphQLApolloDemo.CountriesQuery.Data {
        let country = GraphQLApolloDemo.CountriesQuery.Data.Country(
            _dataDict: ApolloAPI.DataDict(
                data: [
                    "__typename": "Country",
                    "code": GraphQLApolloDemo.ID("IN"),
                    "name": "India",
                    "emoji": "🇮🇳"
                ],
                fulfilledFragments: [ObjectIdentifier(GraphQLApolloDemo.CountriesQuery.Data.Country.self)]
            )
        )

        return GraphQLApolloDemo.CountriesQuery.Data(
            _dataDict: ApolloAPI.DataDict(
                data: ["countries": [country]],
                fulfilledFragments: [ObjectIdentifier(GraphQLApolloDemo.CountriesQuery.Data.self)]
            )
        )
    }
}
