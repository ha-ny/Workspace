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
        view.backgroundColor = .bgPrimary
        mainView.startButton.isHidden = false
        
        bind()
    }
    
    private func bind() {
        mainView.startButton.rx.tap.subscribe(with: self) { owner, _ in
            let vc = AuthViewController()
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.custom(resolver: { _ in
                    return 269
                })]
                sheet.prefersGrabberVisible = true
            }
            owner.present(vc, animated: true)
        }.disposed(by: disposeBag)
    }
}
