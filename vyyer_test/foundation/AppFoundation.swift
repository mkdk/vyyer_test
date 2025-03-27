//
//  Foundation.swift
//  vyyer_test
//
//  Created by Eugen K on 20.03.2025.
//

import Foundation

struct UserDefaultsKeys {
    static let username = "key_username"
    static let accessToken = "key_accessToken"
    static let audience = "key_audience"
}

protocol AppFoundationProtocol {
    var creadentialsUseCase: CredentialUseCaseProtocol { get }
    var userDataUseCase: UserDataUseCaseProtocol { get }

    var isLogedIn: Bool { get }
    var accessToken: String? { get }
    
    func clearUserData()
}


class AppFoundation: AppFoundationProtocol {
    
    private(set)var creadentialsUseCase: CredentialUseCaseProtocol = CredentialUseCases()
    private(set)var userDataUseCase: UserDataUseCaseProtocol = UserDataUseCase()
    
    var isLogedIn: Bool {
        accessToken != nil
    }
    
    var accessToken: String? {
        UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
    }
    
    func clearUserData() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.accessToken)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.audience)
    }
}
