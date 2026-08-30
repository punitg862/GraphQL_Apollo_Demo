//
//  GetProductsUseCaseProtocol.swift
//  GraphQL_Apollo_Demo
//
//  Created by Punit Gupta on 29/08/26.
//


protocol GetCountriesUseCaseProtocol {
    func execute() async throws -> [Country]
}

struct GetCountriesUseCase: GetCountriesUseCaseProtocol {
    private let repository: CountryRepository

    init(repository: CountryRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Country] {
        try await repository.getCountries()
    }
}
