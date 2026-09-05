//
//  MockApolloClient.swift
//  GraphQL_Apollo_Demo
//
//  Created by Punit Gupta on 31/08/26.
//

import Apollo
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
    
    func createMockCountriesData() async throws -> GraphQLApolloDemo.CountriesQuery.Data {
        try await GraphQLApolloDemo.CountriesQuery.Data(
            data: [
                "countries": [
                    [
                    "__typename": "Country",
                    "code": "IN",
                    "name": "India",
                    "emoji": "🇮🇳"
                    ]
                ]
            ]
        )
    }
}
