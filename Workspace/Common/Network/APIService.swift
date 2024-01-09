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
}

extension APIService {
    var baseURL: URL { URL(string: APIInfo.baseURL)! }
    
    var path: String {
        switch self {
        case .validationEmail: "/v1/users/validation/email"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .validationEmail: .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .validationEmail(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .validationEmail:
            ["SesacKey" : APIInfo.key]
        }
    }
}
