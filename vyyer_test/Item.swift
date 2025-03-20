//
//  Item.swift
//  vyyer_test
//
//  Created by Eugen K on 20.03.2025.
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
