//
//  CommonErrorType.swift
//  Workspace
//
//  Created by 김하은 on 1/9/24.
//

import UIKit

enum CommonErrorType: String, CaseIterable, Error {
    case E01 //접근권한: Key 관리 -> X
    case E02 //토큰 인증 실패
    case E03 //계정 정보 조회 실패
    case E05 //AccessToken 만료 -> 토큰 갱신
    case E97 //정상 라우터가 아님 -> X
    case E98 //과호출 -> 잠시후 다시 실행해주세요
    case E99 //내부 서버 오류 -> 잠시후 다시 실행해주세요
}



//enum LoginErrorType: String, CaseIterable, Error {
//    case E11 //잘못된 요청
//    case E12 //이메일 중복 데이터
//    case E21 //코인 부족
//}
//
////enum CommonErrorType: String, CaseIterable, Error {
////    case E01
////    case E02
////    case E03
////}
//
//enum SignUpErrorType: String, CaseIterable, Error {
//    case E11 //잘못된 요청
//    case E12 //이메일 중복 데이터
//}
//
//class SignUpErrorTest {
//    
//    func aa() {
//        
//        do {
////            let responseData = ErrorResponseModel(errorCode: "E13")
//            let decodeError = try JSONDecoder().decode(ErrorResponseModel.self, from: .init())
//            
//            decodeError.errorCode.map {
//                switch CommonErrorType(rawValue: String($0)) {
//                case .E01: break
//                case .E02: break
//                case .E03: break
//                case .none: break
//                }
//                
//                switch SignUpErrorType(rawValue: String($0)) {
//                case .E11: break
//                case .E12: break
//                case .none: break
//                }
//            }
//        }
//        catch {
//           
//        }
//    }
//}
