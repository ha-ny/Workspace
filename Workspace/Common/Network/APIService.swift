//
//  APIService.swift
//  Workspace
//
//  Created by 김하은 on 1/8/24.
//

import Foundation
import Moya

enum APIService: TargetType {
    case validationEmail(String)
    case join(JoinModel)
}

extension APIService {
    var baseURL: URL { URL(string: APIInfo.baseURL)! }
    
    var path: String {
        switch self {
        case .validationEmail: "/v1/users/validation/email"
        case .join: "/v1/users/join"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .validationEmail, .join: .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .validationEmail(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .join(let data):
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .validationEmail:
            ["SesacKey" : APIInfo.key]
        case .join:
            ["SesacKey" : APIInfo.key]
        }
    }
}
