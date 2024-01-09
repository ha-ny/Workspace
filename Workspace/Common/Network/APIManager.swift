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
    
    func decode<T>(endPoint: APIService, decodingType: T.Type) {
        //provider.rx.request(endPoint).filterSuccessfulStatusCodes()
    }
    
    func encode(endPoint: APIService) -> Single<Response> {
        provider.rx.request(endPoint).filterSuccessfulStatusCodes()
            .catch { error -> Single<Response> in
                if let data = (error as? MoyaError)?.response?.data {
                    do {
                        let decodeError = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        
                        guard let commonError = CommonErrorType(rawValue: decodeError.errorCode) else { return Single.error(error) }
                        commonError.action
                    } catch {
                        //Decode 실패 -> action
                    }
                } else {
                    //JSON 형식의 오류가 아님
                    //CommonErrorType.E02.action -> 이런식으로 action
                }
                
                return Single.never()
            }
    }
}
