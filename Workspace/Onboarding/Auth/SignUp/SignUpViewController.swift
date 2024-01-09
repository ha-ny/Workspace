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
        bindAction()
        bindState()
    }
    
    private func bindAction() {
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
    }
    
    private func bindState() {
        reactor.state.map(\.emailValidate).distinctUntilChanged()
            .subscribe(with: self) { owner, isValidation in
                owner.mainView.activeEmailCheckButton(isActive: isValidation)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map(\.emailCheckMessage).compactMap { $0 }
            .subscribe(with: self) { owner, title in
                owner.toastMessage(title: title, centerView: owner.mainView.signUpButtonView)
            }.disposed(by: disposeBag)
    }
}




//        mainView.signUpButtonView.button.rx.tap
//            .map { .signUpButtonTap }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
