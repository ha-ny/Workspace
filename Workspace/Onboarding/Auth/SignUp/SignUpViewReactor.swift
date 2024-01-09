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
    
    let apiManager = APIManager.shared
    private let disposeBag = DisposeBag()
    
    enum Action {
        case emailTextChanged(String)
        case emailCheckButtonTap(String)
    }
    
    enum Mutation {
        case isEmailRegex(Bool)
        case isEmailValidation(String)
    }
    
    struct State {
        var emailValidate = false
        var emailCheckMessage: String?
    }
}

extension SignUpViewReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .emailTextChanged(let email):
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
            let isCheck = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
            return .just(.isEmailRegex(isCheck))
        case .emailCheckButtonTap(let email):
            return apiManager.encode(endPoint: .validationEmail(email)).asObservable()
                .flatMap { response -> Observable<Mutation>  in
                    .just(.isEmailValidation("사용 가능한 이메일입니다"))
                }.catch { error in
                    print(error)
                    return .just(.isEmailValidation("사용할 수 없는 이메일입니다"))
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .isEmailRegex(let bool):
            newState.emailValidate = bool
            newState.emailCheckMessage = nil
        case .isEmailValidation(let title):
            newState.emailCheckMessage = title
        }
        return newState
    }
}



//        case signUpButtonTap



//        case isSignUp(Bool)





//        case .signUpButtonTap:
//            // API 통신
//            return .just(.isSignUp(true))
//         }



//        case .isSignUp(_):
//            // 처리할 코드 작성
