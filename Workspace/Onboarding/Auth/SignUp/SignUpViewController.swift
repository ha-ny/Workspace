//
//  SignUpViewController.swift
//  Workspace
//
//  Created by 김하은 on 1/3/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: UIViewController {
    
    private let mainView = SignUpView()
    private let reactor = SignUpViewReactor()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        view.addGestureRecognizer(tapGesture)
        
        // 키보드가 나타날 때 키보드를 감지하는 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        bind()
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        // 특정 UITextField가 가려지지 않도록 스크롤
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            let phone = mainView.phoneView.textField
            let password = mainView.passwordView.textField
            let passwordCheck = mainView.passwordCheckView.textField
            
            UIView.animate(withDuration: 0.3) {
                if phone.isFirstResponder {
                    self.mainView.fieldView.transform = CGAffineTransform(translationX: 0, y: -(keyboardHeight/3))
                } else if password.isFirstResponder {
                    self.mainView.fieldView.transform = CGAffineTransform(translationX: 0, y: -(keyboardHeight/2))
                } else if passwordCheck.isFirstResponder {
                    self.mainView.fieldView.transform = CGAffineTransform(translationX: 0, y: -(keyboardHeight/2))
                } else {
                    self.mainView.fieldView.transform = CGAffineTransform.identity
                }
            }
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.mainView.fieldView.transform = CGAffineTransform.identity
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func endEdit() {
        self.view.endEditing(true)
    }
    
    private func bind() {
        bindAction()
        bindState()
    }
    
    private func bindAction() {
        mainView.navigationView.backButton.rx.tap.subscribe(with: self) { owner, _ in
            owner.dismiss(animated: true)
        }.disposed(by: disposeBag)

        
        mainView.emailView.textField.rx.text.orEmpty.changed
            .map { .emailTextChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.emailCheckButton.rx.tap
            .map { [weak self] _ in
                .emailCheckButtonTap(self?.mainView.emailView.textField.text ?? "")
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        mainView.phoneView.textField.rx.text.orEmpty
            .map { .phoneTextChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            mainView.emailView.textField.rx.text.orEmpty.changed.asObservable().map { !$0.isEmpty },
            mainView.nickNameView.textField.rx.text.orEmpty.changed.asObservable().map { !$0.isEmpty },
            mainView.nickNameView.textField.rx.text.orEmpty.changed.asObservable().map { !$0.isEmpty },
            mainView.passwordCheckView.textField.rx.text.orEmpty.changed.asObservable().map { !$0.isEmpty }
        )
        .map { $0 && $1 && $2 && $3 }
        .distinctUntilChanged()
        .subscribe(with: self) { owner, isActive in
            owner.mainView.signUpButtonView.button.activeState(isActive: isActive)
        }
        .disposed(by: disposeBag)

        mainView.signUpButtonView.button.rx.tap
            .map { [weak self] _ -> SignUpViewReactor.Action? in
                guard let self else { return nil }
                guard mainView.passwordView.textField.text == mainView.passwordCheckView.textField.text else {
                    toastMessage(title: AuthMessageType.passwordMismatch.text, centerView: self.mainView.signUpButtonView)
                    return nil
                }
                
                let email = self.mainView.emailView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                let password = self.mainView.passwordView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                let nickname = self.mainView.nickNameView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                let phone = self.mainView.phoneView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

                let model = JoinModel(email: email, password: password, nickname: nickname, phone: phone, deviceToken: nil)
                return .signUpButtonTap(model)
            }
            .compactMap { $0 }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState() {
        reactor.state.map(\.emailValidate).distinctUntilChanged()
            .subscribe(with: self) { owner, isValidate in
                owner.mainView.emailCheckButton.activeState(isActive: isValidate)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map(\.emailCheck).compactMap { $0 }
            .subscribe(with: self, onNext: { owner, bool in
                let type = bool ? AuthMessageType.validEmail : AuthMessageType.invalidEmail
                owner.toastMessage(title: type.text, centerView: owner.mainView.signUpButtonView)
            }).disposed(by: disposeBag)

        reactor.state.map(\.phoneHyphen).compactMap { $0 }
            .subscribe(with: self) { owner, text in
                owner.mainView.phoneView.textField.text = text
            }.disposed(by: disposeBag)
        
        reactor.state.map(\.signUpMessage).compactMap { $0 }
            .subscribe(with: self) { owner, type in
                owner.mainView.passwordView.label.textColor = .textPrimary
                owner.mainView.nickNameView.label.textColor = .textPrimary
                
                switch type {
                case .invalidNickname:
                    owner.mainView.nickNameView.label.textColor = .bdError
                    owner.mainView.nickNameView.textField.becomeFirstResponder()
                case .invalidPassword:
                    owner.mainView.passwordView.label.textColor = .bdError
                    owner.mainView.passwordView.textField.becomeFirstResponder()
                default:
                    break
                }
                
                owner.toastMessage(title: type.text, centerView: owner.mainView.signUpButtonView)
            }.disposed(by: disposeBag)

        reactor.state.map(\.signUpModel).compactMap { $0 }
            .subscribe(with: self) { owner, data in
                _ = SaveToken(token: data.token)
            }.disposed(by: disposeBag)
    }
}
