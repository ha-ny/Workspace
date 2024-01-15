//
//  JoinModel.swift
//  Workspace
//
//  Created by 김하은 on 1/9/24.
//

import Foundation

struct JoinModel: Encodable {
    let email: String
    let password: String
    let nickname: String
    let phone: String?
    let deviceToken: String?
}
