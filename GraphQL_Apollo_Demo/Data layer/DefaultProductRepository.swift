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
}

final class DefaultProductRepository: CountryRepository {
    private let apollo: ApolloClient

    init(apollo: ApolloClient) {
        self.apollo = apollo
    }
    
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
