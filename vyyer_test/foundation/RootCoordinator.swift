//
//  RootCoordinator.swift
//  vyyer_test
//
//  Created by Eugen K on 20.03.2025.
//

import Foundation

enum Screens {
    case login
    case scans
}

final class RootCoordinator: NSObject, ObservableObject {
    @Published var screen: Screens = .login

    let foundation: AppFoundation
    
    init(foundation: AppFoundation) {
        self.foundation = foundation
        super.init()
        if isAuthenticated {
            screen = .scans
        } else {
            screen = .login
        }
    }
    
    var isAuthenticated: Bool {
        foundation.isLogedIn
    }
}
