//
//  AuthViewController.swift
//  Workspace
//
//  Created by 김하은 on 1/2/24.
//

import UIKit
import RxSwift
import RxCocoa

final class AuthViewController: UIViewController {
    
    private let mainView = AuthView()
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
        let taps = Observable.merge(
            mainView.appleButton.rx.tap.map { AuthType.apple },
            mainView.kakaoButton.rx.tap.map { AuthType.kakao },
            mainView.emailButton.rx.tap.map { AuthType.email },
            mainView.signButton.rx.tap.map { AuthType.sign }
        )
        
        taps.subscribe(onNext: { [weak self]auth in
            guard let self, let pvc = self.presentingViewController else { return }
            
            self.dismiss(animated: true) {
                auth.action(pvc)
            }
        }).disposed(by: disposeBag)
    }
}

extension AuthViewController {
    enum AuthType {
        case apple
        case kakao
        case email
        case sign
        
        var action: ((UIViewController) -> Void) {
            switch self {
            case .apple: { view in
                
            }
            case .kakao: { view in
                
            }
            case .email: { view in
                view.bottomSheet(view: EmailLoginViewController(), detent: .large)
            }
            case .sign: { view in
                view.bottomSheet(view: SignUpViewController(), detent: .large)
            }
            }
        }
    }
}
