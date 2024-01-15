//
//  SaveToken.swift
//  Workspace
//
//  Created by 김하은 on 1/12/24.
//

import Foundation

enum UserDefaultsKey: String {
    case AccessToken
    case RefreshToken
}

final class SaveToken {
    init(token: Token) {
        UserDefaults.standard.setValue(token.accessToken, forKey: UserDefaultsKey.AccessToken.rawValue)
        UserDefaults.standard.setValue(token.refreshToken, forKey: UserDefaultsKey.RefreshToken.rawValue)
    }
}
