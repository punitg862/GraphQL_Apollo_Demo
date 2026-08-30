//
//  Item.swift
//  GraphQL_Apollo_Demo
//
//  Created by Punit Gupta on 29/08/26.
//

import Foundation
import SwiftData

//@Model
//final class Item {
//    var timestamp: Date
//    
//    init(timestamp: Date) {
//        self.timestamp = timestamp
//    }
//}

//struct Product: Identifiable, Equatable {
//    let id: String
//    let name: String
//    let price: Double
//}
//
//struct ProductPage {
//    let products: [Product]
//    let nextPageToken: String?
//}

struct Country: Identifiable, Hashable {
    let id: String
    let name: String
    let emoji: String
    let code: String
}
