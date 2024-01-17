//
//  EmailLoginViewReactor.swift
//  Workspace
//
//  Created by 김하은 on 1/15/24.
//

import Foundation
import RxSwift
import ReactorKit

final class EmailLoginViewReactor: Reactor {
    var initialState = State()
    
    let apiManager = AuthAPIManager()
    private let disposeBag = DisposeBag()
    
    enum Action {
        case emailTextChanged(String)
        case passwordTextChanged(String)
        case loginButtonTap(LoginModel)
    }
    
    enum Mutation {
        case isEmailRegex(Bool)
        case passwordRegex(Bool)
        case loginFailedType(AuthMessageType)
        case loginsuccessModel(AuthResponseModel)
    }
    
    struct State {
        var emailValidate: Bool?
        var passwordValidate: Bool?
        var loginFailed: AuthMessageType?
        var loginModel: AuthResponseModel?
    }
}

extension EmailLoginViewReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .emailTextChanged(let email):
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
            let isCheck = email.isRegexValid(regex: regex)
            return .just(.isEmailRegex(isCheck))
        case .passwordTextChanged(let password):
            let regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$"
            let isCheck = password.isRegexValid(regex: regex)
            return .just(.passwordRegex(isCheck))
        case .loginButtonTap(let data):
            return apiManager.reqeust(endPoint: .login(data), returnModel: AuthResponseModel.self).asObservable()
                .flatMap { data -> Observable<Mutation> in
                    return .just(.loginsuccessModel(data))
                }.catch { error in
                    return .just(.loginFailedType(.otherError))
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        newState.loginFailed = nil
        newState.loginModel = nil
        
        switch mutation {
        case .isEmailRegex(let bool):
            newState.emailValidate = bool
        case .passwordRegex(let bool):
            newState.passwordValidate = bool
        case .loginFailedType(let type):
            newState.loginFailed = type
        case .loginsuccessModel(let data):
            newState.loginModel = data
        }
        
        return newState
    }
}
