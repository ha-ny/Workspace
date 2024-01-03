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
        view.backgroundColor = .bgPrimary
        
        bind()
    }
    
    private func bind() {
        let taps = Observable.merge(
            mainView.appleButton.rx.tap.map { AuthType.apple },
            mainView.kakaoButton.rx.tap.map { AuthType.kakao },
            mainView.emailButton.rx.tap.map { AuthType.email },
            mainView.joinButton.rx.tap.map { AuthType.join }
        )
        
        taps.subscribe(onNext: { auth in
            auth.action()
        }).disposed(by: disposeBag)
    }
}

extension AuthViewController {
    enum AuthType {
        case apple
        case kakao
        case email
        case join
        
        var action: (() -> Void) {
            switch self {
            case .apple: {
                
            }
            case .kakao: {
                
            }
            case .email: {
                
            }
            case .join: {
                
            }
            }
        }
    }
}
