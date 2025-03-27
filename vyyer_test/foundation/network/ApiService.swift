//
//  ApiService.swift
//  vyyer_test
//
//  Created by Eugen K on 21.03.2025.
//

import Foundation
import Moya


enum ApiService {
    
    case audience(username: String, password: String, clientID: String)
    case getAccessToken(username: String, password: String, clientID: String, audience: String)
    
    case scans(page: Int, perPage: Int)
    case identities(ids: [Int])
    
    case avatar(id: Int)
    
}


extension ApiService: TargetType {
    var baseURL: URL {
        switch self {
        case .scans(page: _, _), .identities(_), .avatar(_):
            return URL(string: audience)! // TODO: to clean force unwraping
        default:
            return URL(string: "https://vyyer.us.auth0.com")!
        }
    }
    
    var path: String {
        switch self {
        case .scans(_, _):
            return "/api/v2/scans/get"
        case .identities(_):
            return "/api/v2/identities/get"
        case .avatar(let id):
            return "/api/v2/identities/avatar?id=\(id)&quality=90&format=jpg"
        case .audience, .getAccessToken:
            return "/oauth/token"
        }
    }
    
    var method: Moya.Method {
         .post
    }
    
    var task: Task {
        switch self {
        case .scans(let page, let perPage):
            return .requestParameters(
                parameters: [
                    "Page": page,
                    "PerPage": perPage
                ],
                encoding: JSONEncoding.default
            )
        case .identities(let ids):
            return .requestParameters(
                    parameters: [
                       "IDs": ids
                    ],
                    encoding: JSONEncoding.default
                )
        case .audience(let username, let password, let clientID):
            return .requestParameters(
                parameters: [
                    "grant_type": "password",
                    "username": username,
                    "password": password,
                    "client_id": clientID
                ],
                encoding: URLEncoding.httpBody
            )
            
        case .getAccessToken(let username, let password, let clientID, let audience):
            return .requestParameters(
                parameters: [
                    "grant_type": "password",
                    "username": username,
                    "password": password,
                    "client_id": clientID,
                    "audience": audience
                ],
                encoding: URLEncoding.httpBody
            )
        case .avatar(let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.queryString) // TODO: not used
        }
    }
    
    private var token: String {
        UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken) ?? ""
    }
    
    private var audience: String {
        UserDefaults.standard.string(forKey: UserDefaultsKeys.audience) ?? ""
    }
    
    var headers: [String: String]? {
        switch self {
        case .avatar(_):
            return nil
        case .audience, .getAccessToken:
            return ["content-type": "application/x-www-form-urlencoded"]
        case .scans, .identities:
            return ["Authorization": "Bearer \(token)",
                    "content-type": "application/json",
                    "X-User-Id": "Auth0User",
                    "X-Org-Id": "Auth0Org"
            ]
        }
    }
}
