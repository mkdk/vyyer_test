//
//  Models.swift
//  vyyer_test
//
//  Created by Eugen K on 21.03.2025.
//

import Foundation

import Foundation

struct AuthResponse: Codable {
    let accessToken: String
    let idToken: String?
    let scope: String?
    let expiresIn: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case idToken = "id_token"
        case scope
        case expiresIn = "expires_in"
        case tokenType = "token_type"
    }
}


struct ScansResponse: Codable {
    let data: [Scan]
    let errors: [String]
    let pagination: Pagination

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case errors = "Errors"
        case pagination = "Pagination"
    }
}

struct Scan: Codable, Identifiable {
    let id: Int
    let userID: String
    let identityID: Int
    let createdAt: String
    let flags: Int
    let verdictType: Int
    let verdictResult: Int
    let verdictName: String
    let verdictValue: String
    let vip: Int
    let ban: Int

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case userID = "UserID"
        case identityID = "IdentityID"
        case createdAt = "CreatedAt"
        case flags = "Flags"
        case verdictType = "VerdictType"
        case verdictResult = "VerdictResult"
        case verdictName = "VerdictName"
        case verdictValue = "VerdictValue"
        case vip = "VIP"
        case ban = "Ban"
    }
    
    var identity: Identity?
    
    mutating func setIdentity(_ identity: Identity) {
        self.identity = identity
    }
}

struct Pagination: Codable {
    let currentPage: Int
    let perPage: Int
    let count: Int
    let pages: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "CurrentPage"
        case perPage = "PerPage"
        case count = "Count"
        case pages = "Pages"
    }
}



struct IdentityResponse: Codable {
    let data: [Identity]
    let errors: [String]
    let pagination: Pagination?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case errors = "Errors"
        case pagination = "Pagination"
    }
}

struct Identity: Codable {
    let id: Int
    let uid: String
    let userID: String
    let orgID: String
    let orientation: Int
    let licenseNumber: String
    let birthday: String
    let issuedAt: String?
    let expiresAt: String
    let height: String
    let weight: String
    let eyeColor: String
    let hairColor: String
    let address: String
    let street: String
    let city: String
    let postalCode: String
    let fullName: String
    let firstName: String
    let middleName: String
    let lastName: String
    let gender: String
    let ban: Int
    let bannedBy: String?
    let banStartAt: String?
    let banEndAt: String?
    let banReasonID: Int?
    let vip: Int
    let vipBy: String?
    let vipStartAt: String?
    let vipEndAt: String?
    let visits: Int
    let state: String
    let createdAt: String
    let lastScannedAt: String?
    let scansInPeriod: Int
    let hasSignature: Bool

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case uid = "UID"
        case userID = "UserID"
        case orgID = "OrgID"
        case orientation = "Orientation"
        case licenseNumber = "LicenseNumber"
        case birthday = "Birthday"
        case issuedAt = "IssuedAt"
        case expiresAt = "ExpiresAt"
        case height = "Height"
        case weight = "Weight"
        case eyeColor = "EyeColor"
        case hairColor = "HairColor"
        case address = "Address"
        case street = "Street"
        case city = "City"
        case postalCode = "PostalCode"
        case fullName = "FullName"
        case firstName = "FirstName"
        case middleName = "MiddleName"
        case lastName = "LastName"
        case gender = "Gender"
        case ban = "Ban"
        case bannedBy = "BannedBy"
        case banStartAt = "BanStartAt"
        case banEndAt = "BanEndAt"
        case banReasonID = "BanReasonID"
        case vip = "VIP"
        case vipBy = "VIPBy"
        case vipStartAt = "VIPStartAt"
        case vipEndAt = "VIPEndAt"
        case visits = "Visits"
        case state = "State"
        case createdAt = "CreatedAt"
        case lastScannedAt = "LastScannedAt"
        case scansInPeriod = "ScansInPeriod"
        case hasSignature = "HasSignature"
    }
}



struct Stubs {
    static let email = "interview_new@vyyer.com"
    static let password = "5nt9wPAhQkMcukPV"
    static let audience = "https://unifiedapi.dev.vyyer.id" // TODO: this supposed to be get from first login request
    static let clientId = "EtHf0UdEIJbwmk6kdicIfNq4lGkpZko0"
}

