//
//  DefaultProductRepository.swift
//  GraphQL_Apollo_Demo
//
//  Created by Punit Gupta on 29/08/26.
//

import Apollo
import ApolloAPI

protocol CountryRepository {
    func getCountries() async throws -> [Country]
//    func watchCountries(completion: @escaping ([Country]?, Error?) -> Void) async
    func watchCountries(completion: @escaping ([Country]?, Error?) -> Void) async -> GraphQLQueryWatcher<GraphQLApolloDemo.CountriesQuery>

}

final class DefaultProductRepository: CountryRepository {
    private let apollo: ApolloClient

    init(apollo: ApolloClient) {
        self.apollo = apollo
    }
    
    func watchCountries(completion: @escaping ([Country]?, Error?) -> Void) async -> GraphQLQueryWatcher<GraphQLApolloDemo.CountriesQuery>  {
        let query = GraphQLApolloDemo.CountriesQuery()
        let watcher = await apollo.watch(query: query) { result in
            switch result {
            case .success(let data):
                if let graphQLError = data.errors?.first {
                    completion(nil, graphQLError)
                    return
                }
                guard let countries = data.data?.countries else {
                    completion(nil, ProductError.invalidResponse)
                    return
                }
                let mappedCountries = countries.compactMap { country in
                    Country(
                        id: country.code,
                        name: country.name,
                        emoji: country.emoji,
                        code: country.code
                    )
                }
                completion(mappedCountries, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        return watcher  // ✅ Return watcher
    }

    
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
    
    func getCountries() async throws -> [Country] {
        let query = GraphQLApolloDemo.CountriesQuery()
        let result = try await apollo.fetch(query: query, cachePolicy: .networkOnly)
        
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
                code: country.code
            )
        }
    }
}

enum ProductError: Error {
    case invalidResponse
}
