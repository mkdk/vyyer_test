//
//  ScansDTO.swift
//  vyyer_test
//
//  Created by Eugen K on 22.03.2025.
//

import Foundation

struct ScansDTO: Identifiable {
    let id: Int
    let name: String
    let valid: String
    let createdAt: String
    let identityID: Int
    
    var imageURL: URL? {
        URL(string: ApiService.avatar(id: identityID).baseURL.absoluteString + ApiService.avatar(id: identityID).path)
    }
    
    var formattedCreatedAt: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM h:mm a"
        if let date = inputFormatter.date(from: createdAt) {
            return outputFormatter.string(from: date)
        } else {
            return createdAt
        }
    }
}
