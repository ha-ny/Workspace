//
//  APIManagerProtocol.swift
//  Workspace
//
//  Created by 김하은 on 1/8/24.
//

import Foundation
import Moya
import RxMoya
import RxSwift

protocol APIManagerProtocol {
    associatedtype APIService: TargetType
    
    var provider: MoyaProvider<APIService> { get }
    func reqeust<Model: Decodable>(endPoint: APIService, returnModel: Model.Type) -> Single<Model>
}

extension APIManagerProtocol {
    func reqeust<Model: Decodable>(endPoint: APIService, returnModel: Model.Type) -> Single<Model> {
        provider.rx.request(endPoint).flatMap { response -> Single<Model> in
            do {
                if response.data.isEmpty {
                    if let emptyModel = returnModel as? EmptyResponseModel.Type {
                       return Single.just(emptyModel.init() as! Model)
                   }
                }

                let data = try JSONDecoder().decode(returnModel.self, from: response.data)
                return Single.just(data)
            } catch {
                do {
                    let decodeError = try JSONDecoder().decode(ErrorResponseModel.self, from: response.data)
                    
                    if let commonError = CommonErrorType(rawValue: decodeError.errorCode) {
                        print("공통 에러", commonError)
                        return Single.error(commonError)
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
