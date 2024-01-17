//
//  EmailLoginViewController.swift
//  Workspace
//
//  Created by 김하은 on 1/5/24.
//

import UIKit
import RxSwift
import RxCocoa

final class EmailLoginViewController: UIViewController {

    private let mainView = EmailLoginView()
    private let reactor = EmailLoginViewReactor()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        bindAction()
        bindState()
    }
    
    private func bindAction() {
        mainView.emailView.textField.rx.text.orEmpty.changed
            .map { .emailTextChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.passwordView.textField.rx.text.orEmpty.changed
            .map { .passwordTextChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        mainView.loginButtonView.button.rx.tap.map { [weak self] _ -> EmailLoginViewReactor.Action? in
                guard let self else { return nil }
                guard let email = mainView.emailView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }
                    guard let password = mainView.passwordView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }

                let model = LoginModel(email: email, password: password, deviceToken: nil)
                return .loginButtonTap(model)
            }
            .compactMap { $0 }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState() {
        reactor.state
            .map { $0.emailValidate ?? false && $0.passwordValidate ?? false }
            .subscribe(with: self) { owner, isValidate in
                owner.mainView.loginButtonView.button.activeState(isActive: isValidate)
            }.disposed(by: disposeBag)
        
        reactor.state
            .map(\.emailValidate)
            .compactMap { $0 }
            .subscribe(with: self) { owner, isValidate in
                owner.mainView.emailView.label.textColor = isValidate ? .bdBlack : .bdError
            }.disposed(by: disposeBag)
        
        reactor.state
            .map(\.passwordValidate)
            .compactMap { $0 }
            .subscribe(with: self) { owner, isValidate in
                owner.mainView.passwordView.label.textColor = isValidate ? .bdBlack : .bdError
            }.disposed(by: disposeBag)
        
        reactor.state
            .map(\.loginFailed)
            .compactMap{ $0 }
            .subscribe(with: self) { owner, type in
                owner.toastMessage(title: type.text, centerView: owner.mainView.loginButtonView)
            }.disposed(by: disposeBag)
        
        reactor.state
            .map(\.loginModel)
            .compactMap{ $0 }
            .subscribe(with: self) { owner, data in
                _ = SaveToken(token: data.token)
            }.disposed(by: disposeBag)
    }
}


//mainView.loginButtonView.button.rx.tap.subscribe(with: self) { owner, _ in
//    let vc = HomeViewController()
//    owner.present(vc, animated: true)
//}.disposed(by: disposeBag)
