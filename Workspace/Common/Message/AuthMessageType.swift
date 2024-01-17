//
//  JoinMessageType.swift
//  Workspace
//
//  Created by 김하은 on 1/9/24.
//

import Foundation

enum AuthMessageType {
    case emailCheckNeeded
    case validEmail
    case invalidEmail
    case invalidNumber
    case invalidNickname
    case invalidPhoneNumber
    case invalidPassword
    case passwordMismatch
    case alreadyRegistered
    case otherError
}

extension AuthMessageType {
    var text: String {
        switch self {
        case .emailCheckNeeded: "이메일 중복 확인을 진행해주세요"
        case .validEmail: "사용 가능한 이메일입니다"
        case .invalidEmail: "사용 할 수 없는 이메일입니다"
        case .invalidNumber: "숫자만 입력해주세요"
        case .invalidNickname: "닉네임은 1글자 이상 30글자 이내로 입력해주세요"
        case .invalidPhoneNumber: "잘못된 전화번호 형식입니다."
        case .invalidPassword: "비밀번호는 최소 8자 이상, 하나 이상의 대소문자/숫자/특수 문자를 설정해주세요"
        case .passwordMismatch: "작성한 비밀번호와 일치하지 않습니다"
        case .alreadyRegistered: "이미 가입된 회원입니다. 로그인을 진행해주세요"
        case .otherError: "에러가 발생했어요. 잠시 후 다시 시도해주세요"
        }
    }
}
