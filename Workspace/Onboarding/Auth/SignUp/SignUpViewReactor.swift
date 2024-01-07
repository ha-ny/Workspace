//
//  SignUpViewReactor.swift
//  Workspace
//
//  Created by 김하은 on 1/7/24.
//

import Foundation
import RxSwift
import ReactorKit

final class SignUpViewReactor: Reactor {
    var initialState = State()

    enum Action {
        case emailTextChanged(String)
//        case emailCheckButtonTap
//        case signUpButtonTap
    }

    enum Mutation {
        case isEmailRegex(Bool)
//        case isEmailValidation(Bool)
//        case isSignUp(Bool)
    }

    struct State {
        var emailValidate = false
    }
}

extension SignUpViewReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .emailTextChanged(let email):
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
            let isCheck = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
            return .just(.isEmailRegex(isCheck))

//        case .emailCheckButtonTap:
//            // API 통신
//            return .just(.isEmailValidation(true))
//
//        case .signUpButtonTap:
//            // API 통신
//            return .just(.isSignUp(true))
         }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case .isEmailRegex(let bool):
            newState.emailValidate = bool
//        case .isEmailValidation(_):
//            // 처리할 코드 작성
//
//        case .isSignUp(_):
//            // 처리할 코드 작성
         }

        return newState
    }
}
