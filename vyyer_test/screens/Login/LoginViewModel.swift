//
//  LoginViewModel.swift
//  vyyer_test
//
//  Created by Eugen K on 20.03.2025.
//

import Foundation
import SwiftUI

import Foundation

class LoginViewModel: BaseViewModel {
    
    @Published var login: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var showErrorAlert: Bool = false
    @Published var navigateToHome: Bool = false
    
    override init(foundation: AppFoundationProtocol) {
        super.init(foundation: foundation)
        login = Stubs.email
        password = Stubs.password
    }

    
    
    func loginUser() async {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = ""
        }
        
        do {
            try await foundation.creadentialsUseCase.login(email: login, password: password, clientId: Stubs.clientId)
            if foundation.isLogedIn {
                DispatchQueue.main.async {
                    self.navigateToHome = true
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid login or password"
                self.showErrorAlert = true
                self.isLoading = false
            }
        }
    }
}
