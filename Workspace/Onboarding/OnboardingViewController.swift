//
//  OnboardingViewController.swift
//  Workspace
//
//  Created by 김하은 on 1/2/24.
//

import UIKit
import RxSwift
import RxCocoa

final class OnboardingViewController: UIViewController {

    private let mainView = OnboardingView()
    private let disposeBag = DisposeBag()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.startButtonView.isHidden = false
        
        let backItem = UIBarButtonItem(image: .iconBack, style: .plain, target: self, action: nil)
        backItem.tintColor = .textPrimary
        navigationItem.backBarButtonItem = backItem
        
        bind()
    }
    
    private func bind() {
        mainView.startButtonView.button.rx.tap.subscribe(with: self) { owner, _ in
            let vc = AuthViewController()
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.custom(resolver: {_ in 269 })]
                sheet.preferredCornerRadius = 10
                sheet.prefersGrabberVisible = true
            }
            
            self.present(vc, animated: true)
        }.disposed(by: disposeBag)
    }
}
