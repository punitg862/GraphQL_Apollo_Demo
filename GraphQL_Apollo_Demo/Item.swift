//
//  Item.swift
//  GraphQL_Apollo_Demo
//
//  Created by Punit Gupta on 29/08/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
