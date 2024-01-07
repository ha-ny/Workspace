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
        mainView.signUpButtonView.button.rx.tap.subscribe(with: self) { owner, _ in
            let vc = HomeViewController()
            owner.present(vc, animated: true)
        }.disposed(by: disposeBag)
    }
}
