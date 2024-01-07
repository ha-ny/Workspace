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
    let isEmailValidation = BehaviorSubject(value: false)
    
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
        
//        mainView.emailCheckButton.rx.tap
//            .map { .emailCheckButtonTap }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
//        mainView.signUpButtonView.button.rx.tap
//            .map { .signUpButtonTap }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
    }
    
    private func bindState() {
        reactor.state
            .map { $0.emailValidate }
            .distinctUntilChanged()
            .subscribe(with: self) { owner, isValidation in
                owner.mainView.activeEmailCheckButton(isActive: isValidation)
            }
            .disposed(by: disposeBag)
    }
}
