//
//  JoinResponseModel.swift
//  Workspace
//
//  Created by 김하은 on 1/9/24.
//

import Foundation

struct JoinResponseModel: Decodable {
    let user_id: Int
    let email: String
    let nickname: String
    let profileImage: String?
    let phone: String?
    let vendor: String?
    let createdAt: String
    let token: Token
}

struct Token: Decodable{
    let accessToken: String
    let refreshToken: String
}
