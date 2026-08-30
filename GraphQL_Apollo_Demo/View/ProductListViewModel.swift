//
//  ProductListViewModel.swift
//  GraphQL_Apollo_Demo
//
//  Created by Punit Gupta on 29/08/26.
//
import Combine
import Foundation

@MainActor
final class CountryListViewModel: ObservableObject {

    @Published private(set) var countries: [Country] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let getCountriesUseCase: GetCountriesUseCaseProtocol

    init(getCountriesUseCase: GetCountriesUseCaseProtocol) {
        self.getCountriesUseCase = getCountriesUseCase
    }

    func loadCountries() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            // The Countries API returns everything at once. No token needed.
            let fetchedCountries = try await getCountriesUseCase.execute()
            
            // Replace the whole array
            self.countries = fetchedCountries
        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage ?? "")
        }
    }

    func refresh() async {
        await loadCountries()
    }
}
