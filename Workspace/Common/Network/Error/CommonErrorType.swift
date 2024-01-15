//
//  CommonErrorType.swift
//  Workspace
//
//  Created by 김하은 on 1/9/24.
//

import Foundation

enum CommonErrorType: String, LocalizedError {
    case E01 //접근권한: Key 관리 -> X
    case E02 //토큰 인증 실패
    case E03 //계정 정보 조회 실패
    case E05 //AccessToken 만료 -> 토큰 갱신
    case E97 //정상 라우터가 아님 -> X
    case E98 //과호출 -> 잠시후 다시 실행해주세요
    case E99 //내부 서버 오류 -> 잠시후 다시 실행해주세요
}

extension CommonErrorType {
    var action: () {
        switch self {
        case .E01:
            break
        case .E02:
            break
        case .E03:
            break
        case .E05:
            break
        case .E97:
            break
        case .E98:
            break
        case .E99:
            break
        }
    }
}
