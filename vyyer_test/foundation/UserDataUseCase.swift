//
//  UserDataUseCase.swift
//  vyyer_test
//
//  Created by Eugen K on 21.03.2025.
//

import Foundation


protocol UserDataUseCaseProtocol {
    func getScans(page: Int, perPage: Int) async throws  -> [ScansDTO]
}

final class UserDataUseCase: UserDataUseCaseProtocol {
    
    private let network = NetworkRequestsService()
    
    func getScans(page: Int, perPage: Int) async throws -> [ScansDTO] {
        let scansResponse = try await network.scans(page: page, perPage: perPage)
        let ids = scansResponse.data.map { $0.identityID }
        let identities = try await network.identities(ids: Array(Set(ids)))
        let scansUpdated = scansResponse.data.map { scan in
            var updatedScan = scan
            if let scansIdentity = identities.data.first(where: { $0.id == scan.identityID }) {
                updatedScan.setIdentity(scansIdentity)
            }
            return updatedScan
        }
        return scansUpdated.map {
            ScansDTO(id: $0.id,
                     name: $0.identity?.fullName ?? "N/A",
                     valid: $0.verdictName,
                     createdAt: $0.createdAt,
                     identityID: $0.identityID
            )
        }
    }
}
