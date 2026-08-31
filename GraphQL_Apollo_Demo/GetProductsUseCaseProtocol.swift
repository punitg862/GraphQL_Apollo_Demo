//
//  GetProductsUseCaseProtocol.swift
//  GraphQL_Apollo_Demo
//
//  Created by Punit Gupta on 29/08/26.
//
import Apollo

protocol GetCountriesUseCaseProtocol {
    func execute() async throws -> [Country]
//    func execute(completion: @escaping ([Country]?, Error?) -> Void) async
    func execute(completion: @escaping ([Country]?, Error?) -> Void) async -> GraphQLQueryWatcher<GraphQLApolloDemo.CountriesQuery>  // ✅ Return watcher

}

struct GetCountriesUseCase: GetCountriesUseCaseProtocol {
    private let repository: CountryRepository

    init(repository: CountryRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Country] {
        try await repository.getCountries()
    }
    
//    func execute(completion: @escaping ([Country]?, Error?) -> Void) async  {
//        await repository.watchCountries(completion: completion)
//    }
    
    func execute(completion: @escaping ([Country]?, Error?) -> Void) async -> GraphQLQueryWatcher<GraphQLApolloDemo.CountriesQuery>  {
        return await repository.watchCountries(completion: completion)
    }

}
