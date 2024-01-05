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
        view.backgroundColor = .bgPrimary
        
        bind()
    }
    
    private func bind() {
        
    }
}
