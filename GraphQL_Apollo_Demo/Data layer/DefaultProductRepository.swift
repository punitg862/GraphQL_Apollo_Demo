//
//  DefaultProductRepository.swift
//  GraphQL_Apollo_Demo
//
//  Created by Punit Gupta on 29/08/26.
//

import Apollo
import ApolloAPI

public protocol ApolloClientProtocol {
    func fetchQuery<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy.Query.SingleResponse
    ) async throws -> GraphQLResponse<Query>
    where Query.ResponseFormat == SingleResponseFormat
}

extension ApolloClient: ApolloClientProtocol {
    public func fetchQuery<Query>(query: Query, cachePolicy: Apollo.CachePolicy.Query.SingleResponse) async throws -> Apollo.GraphQLResponse<Query> where Query : ApolloAPI.GraphQLQuery, Query.ResponseFormat == ApolloAPI.SingleResponseFormat {
        try await self.fetch(query: query, cachePolicy: cachePolicy)
    }
}

public protocol CountryRepository {
    func getCountries() async throws -> [Country]
//    func watchCountries(completion: @escaping ([Country]?, Error?) -> Void) async
//    func watchCountries(completion: @escaping ([Country]?, Error?) -> Void) async -> GraphQLQueryWatcher<GraphQLApolloDemo.CountriesQuery>
}

public final class DefaultProductRepository: CountryRepository {
    private let apollo: ApolloClientProtocol

    public init(apollo: ApolloClientProtocol) {
        self.apollo = apollo
    }
    
    public func getCountries() async throws -> [Country] {
        let query = GraphQLApolloDemo.CountriesQuery()
        let result = try await apollo.fetchQuery(query: query, cachePolicy: .cacheFirst)
        
        if let graphQLError = result.errors?.first {
            throw graphQLError
        }
        
        guard let countries = result.data?.countries else {
            throw ProductError.invalidResponse
        }

        // The key fix: explicitly map to 'Country' using its full name
        return countries.compactMap { (country: GraphQLApolloDemo.CountriesQuery.Data.Country) -> Country in
            return Country(
                id: country.code,
                name: country.name,
                emoji: country.emoji,
            )
        }
    }
    
//    func watchCountries(completion: @escaping ([Country]?, Error?) -> Void) async -> GraphQLQueryWatcher<GraphQLApolloDemo.CountriesQuery>  {
//        let query = GraphQLApolloDemo.CountriesQuery()
//        let watcher = await apollo.watch(query: query) { result in
//            switch result {
//            case .success(let data):
//                if let graphQLError = data.errors?.first {
//                    completion(nil, graphQLError)
//                    return
//                }
//                guard let countries = data.data?.countries else {
//                    completion(nil, ProductError.invalidResponse)
//                    return
//                }
//                let mappedCountries = countries.compactMap { country in
//                    Country(id: country.code, name: country.name, emoji: country.emoji, code: country.code)
//                }
//                completion(mappedCountries, nil)
//            case .failure(let error):
//                completion(nil, error)
//            }
//        }
//        return watcher  // ✅ Return watcher
//    }

    // Memory leak
//    func watchCountries(completion: @escaping ([Country]?, Error?) -> Void) async {
//        let query = GraphQLApolloDemo.CountriesQuery()
//        let _ = await apollo.watch(query: query) { result in
//            switch result {
//            case .success(let data):
//                if let graphQLError = data.errors?.first {
//                    completion(nil, graphQLError)
//                    return
//                }
//                
//                guard let countries = data.data?.countries else {
//                    completion(nil, ProductError.invalidResponse)
//                    return
//                }
//                
//                let mappedCountries = countries.compactMap { country in
//                    Country(
//                        id: country.code,
//                        name: country.name,
//                        emoji: country.emoji,
//                        code: country.code
//                    )
//                }
//                completion(mappedCountries, nil)
//                
//            case .failure(let error):
//                completion(nil, error)
//            }
//        }
//    }

}

enum ProductError: Error {
    case invalidResponse
}
