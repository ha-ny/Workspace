//
//  APIManager.swift
//  Workspace
//
//  Created by 김하은 on 1/8/24.
//

import Foundation
import Moya
import RxMoya
import RxSwift

class APIManager {
    
    static let shared = APIManager()
    private let provider = MoyaProvider<APIService>()
    private let disposeBag = DisposeBag()

    func reqeust<T: Decodable>(endPoint: APIService, returnModel: T.Type) -> Single<T> {
        provider.rx.request(endPoint).flatMap { response -> Single<T> in
            do {
                   let data = try JSONDecoder().decode(returnModel.self, from: response.data)
                   return Single.just(data)
            } catch {
                do {
                    let decodeError = try JSONDecoder().decode(ErrorResponseModel.self, from: response.data)
                    
                    if let commonError = CommonErrorType(rawValue: decodeError.errorCode) {
                        print("공통 에러", commonError)
                        commonError.action
                        return Single.never()
                    } else {
                        print("커스텀 에러", decodeError.errorCode)
                        return Single.error(decodeError)
                    }
                } catch {
                    // decode 실패
                    return Single.error(error)
                }
            }
                   
        }
    }
}
