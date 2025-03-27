//
//  NetworkRequstsService.swift
//  vyyer_test
//
//  Created by Eugen K on 21.03.2025.
//

import Foundation
import Moya


final class NetworkRequestsService {
    let networkProvider = MoyaProvider<ApiService>()
    
    func audience(username: String, password: String, clientID: String) async throws -> AuthResponse {
        let response = try await networkProvider.request(.audience(username: username, password: password, clientID: clientID))
        return try JSONDecoder().decode(AuthResponse.self, from: response.data)
    }

    func getAccessToken(username: String, password: String, clientID: String, audience: String) async throws -> AuthResponse {
        let response = try await networkProvider.request(.getAccessToken(username: username, password: password, clientID: clientID, audience: audience))
        return try JSONDecoder().decode(AuthResponse.self, from: response.data)
    }
    
    func scans(page: Int, perPage: Int) async throws -> ScansResponse {
        let response = try await networkProvider.request(.scans(page: page, perPage: perPage))
        return try JSONDecoder().decode(ScansResponse.self, from: response.data)
    }
    
    func identities(ids: [Int])  async throws -> IdentityResponse {
        let response = try await networkProvider.request(.identities(ids: ids))
        return try JSONDecoder().decode(IdentityResponse.self, from: response.data)
    }
}


extension MoyaProvider {
    func request(_ target: Target) async throws -> Response {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print(jsonString)
                    } else {
                        print("Failed to convert response data to String")
                    }
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
