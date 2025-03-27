//
//  CredentialUseCases.swift
//  vyyer_test
//
//  Created by Eugen K on 20.03.2025.
//

import Foundation
import JWTDecode
import SDWebImage

enum CredentialUseCaseError: Error {
    case audience(String)
}

protocol CredentialUseCaseProtocol {
    func login(email: String, password: String, clientId: String) async throws
}

final class CredentialUseCases: CredentialUseCaseProtocol {
    
    private let network = NetworkRequestsService()
    
    func login(email: String, password: String, clientId: String) async throws {
        let audienceValue = Stubs.audience //try! await audience(email: email, password: password, clientId: clientId) //TODO: audience value here is EtHf0UdEIJbwmk6kdicIfNq4lGkpZko0 which seems wrong, so better to use stub
        let result = try await network.getAccessToken(username: email, password: password, clientID: clientId, audience: audienceValue)
        print(result.accessToken)
        UserDefaults.standard.set(result.accessToken, forKey: UserDefaultsKeys.accessToken)
        UserDefaults.standard.set(audienceValue, forKey: UserDefaultsKeys.audience)
        setupSDEwebImage()
    }
    
    // TODO: temprorary solution for fast implementation
    private func setupSDEwebImage() {
        SDWebImageDownloader.shared.setValue("Bearer \(UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken) ?? "")", forHTTPHeaderField: "Authorization")
        SDWebImageDownloader.shared.setValue("Auth0User", forHTTPHeaderField: "X-User-Id")
        SDWebImageDownloader.shared.setValue("Auth0Org", forHTTPHeaderField: "X-Org-Id")
    }
    
    private func audience(email: String, password: String, clientId: String) async throws -> String {
        let audienceResponse = try await network.audience(username: email, password: password, clientID: clientId)
        if let audience = try decode(jwt: audienceResponse.idToken ?? "n/a").body["aud"] as? String {
            return audience
        } else {
           throw CredentialUseCaseError.audience("No audience")
        }
    }
}

extension JWT {
    var audience: String? {
        print(self.body.keys)
        return self.body["aud"] as? String
    }
}
