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
        case phoneTextChanged(String)
        case signUpButtonTap(JoinModel)
    }
    
    enum Mutation {
        case isEmailRegex(Bool)
        case isEmailValidation(Bool)
        case phoneRegex(String?)
        case signUpValidationType(JoinMessageType)
        case signUpValidationModel(JoinResponseModel)
    }
    
    struct State {
        var emailValidate = false
        var emailCheck: Bool?
        var phoneHyphen: String?
        var signUpMessage: JoinMessageType?
        var signUpModel: JoinResponseModel?
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
            return apiManager.reqeust(endPoint: .validationEmail(email), returnModel: EmptyResponseModel.self).asObservable()
                .flatMap { response -> Observable<Mutation>  in
                        .just(.isEmailValidation(true))
                }.catch { error in
                    guard let customError = error as? ErrorResponseModel else {
                        print(error.localizedDescription)
                        return .just(.signUpValidationType(.otherError))
                    }

                    switch customError.errorCode {
                    case "E11", "E12": return .just(.isEmailValidation(false))
                    default:
                        return .just(.signUpValidationType(.otherError))
                    }
                }
        case .phoneTextChanged(let number):
            let numerOnly = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            let format = numerOnly.enumerated().map { index, num in
                    return index == 3 || index == 7 ? "-\(num)" : "\(num)"
                }.joined()
            
            return .just(.phoneRegex(format))
        case .signUpButtonTap(let model):
            guard let _ = currentState.emailCheck else { return .just(.signUpValidationType(.emailCheckNeeded))}
            guard (1...30).contains(model.nickname.count) else { return .just(.signUpValidationType(.invalidNickname))}

            let data = JoinModel(email: model.email, password: model.password, nickname: model.nickname, phone: model.phone, deviceToken: nil)
            
            return apiManager.reqeust(endPoint: .join(data), returnModel: JoinResponseModel.self).asObservable()
                .flatMap { data -> Observable<Mutation> in
                    return .just(.signUpValidationModel(data))
                }.catch { error in
                    guard let customError = error as? ErrorResponseModel else {
                        print(error.localizedDescription)
                        return .just(.signUpValidationType(.otherError))
                    }
                    
                    switch customError.errorCode {
                    case "E11": return .just(.signUpValidationType(.otherError))
                    case "E12": return .just(.signUpValidationType(.alreadyRegistered))
                    default:
                        return .just(.signUpValidationType(.otherError))
                    } 
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        newState.signUpMessage = nil
        newState.signUpModel = nil
        newState.phoneHyphen = nil
        
        switch mutation {
        case .isEmailRegex(let bool):
            newState.emailValidate = bool
            newState.emailCheck = nil
        case .isEmailValidation(let bool):
            newState.emailCheck = bool
        case .signUpValidationType(let type):
            newState.signUpMessage = type
        case .signUpValidationModel(let data):
            newState.signUpModel = data
        case .phoneRegex(let text):
            newState.phoneHyphen = text
        }
        
        return newState
    }
}
