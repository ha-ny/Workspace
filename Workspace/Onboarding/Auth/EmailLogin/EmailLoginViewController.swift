//
//  EmailLoginViewController.swift
//  Workspace
//
//  Created by 김하은 on 1/5/24.
//

import UIKit
import RxSwift
import RxCocoa

class EmailLoginViewController: UIViewController {

    private let mainView = EmailLoginView()
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
        mainView.loginButtonView.button.rx.tap.subscribe(with: self) { owner, _ in
            let vc = HomeViewController()
            owner.present(vc, animated: true)
        }.disposed(by: disposeBag)
    }
}
