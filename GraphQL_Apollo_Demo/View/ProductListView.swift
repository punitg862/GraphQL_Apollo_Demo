//
//  ProductListView.swift
//  GraphQL_Apollo_Demo
//
//  Created by Punit Gupta on 29/08/26.
//

import SwiftUI

struct CountryListView: View {
    @StateObject var viewModel: CountryListViewModel

    var body: some View {
        List(viewModel.countries) { country in
            VStack(alignment: .leading) {
                HStack {
                    Text(country.emoji)
                    Text(country.name).frame(maxWidth: .infinity, alignment: .leading)
//                    Spacer()
                    Text(country.id)
                }
            }
        }
        .task { // When call only once
            await viewModel.loadCountries()
        }
        .refreshable {
            await viewModel.refresh()
        }
        .overlay {
            if viewModel.isLoading && viewModel.countries.isEmpty {
                ProgressView()
            }
        }
//        .onDisappear {
//            viewModel.stopWatching()
//        }
    }
}
