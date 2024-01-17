//
//  LoginModel.swift
//  Workspace
//
//  Created by 김하은 on 1/16/24.
//

import Foundation

struct LoginModel: Encodable {
    let email: String
    let password: String
    let deviceToken: String?
}
