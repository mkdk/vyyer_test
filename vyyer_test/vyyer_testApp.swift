//
//  vyyer_testApp.swift
//  vyyer_test
//
//  Created by Eugen K on 20.03.2025.
//

import SwiftUI
import SwiftData

@main
struct vyyer_testApp: App {
    
    private var rootCoordinator: RootCoordinator = .init(foundation: .init())
    
    var body: some Scene {
        let foundation = rootCoordinator.foundation
        WindowGroup {
            NavigationStack {
                if rootCoordinator.isAuthenticated {
                    ScansView(viewModel: .init(foundation: foundation))
                        .environmentObject(rootCoordinator)
                } else {
                    LoginView(viewModel: .init(foundation: foundation))
                        .environmentObject(rootCoordinator)
                }
            }
        }
    }
}
