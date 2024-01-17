//
//  AuthAPIManager.swift
//  Workspace
//
//  Created by 김하은 on 1/8/24.
//

import Foundation
import Moya

final class AuthAPIManager: APIManagerProtocol {
    typealias APIService = AuthAPIService
    var provider = MoyaProvider<APIService>()
}

enum AuthAPIService: TargetType {
    case validationEmail(String)
    case join(JoinModel)
    case login(LoginModel)
}

extension AuthAPIService {
    var baseURL: URL { URL(string: APIInfo.baseURL)! }
    
    var path: String {
        switch self {
        case .validationEmail: "/v1/users/validation/email"
        case .join: "/v1/users/join"
        case .login: "/v2/users/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .validationEmail, .join, .login: .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .validationEmail(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .join(let data):
            return .requestJSONEncodable(data)
        case .login(let data):
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .validationEmail, .join, .login:
            ["SesacKey" : APIInfo.key]
        }
    }
}
