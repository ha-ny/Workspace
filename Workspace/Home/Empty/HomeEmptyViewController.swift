//
//  HomeEmptyViewController.swift
//  Workspace
//
//  Created by 김하은 on 1/17/24.
//

import UIKit
import RxSwift

final class HomeEmptyViewController: UIViewController {

    private let mainView = HomeEmptyView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgSecondary
        
        bind()
    }
    
    private func bind() {
        mainView.navigationView.workSpaceTapView.rx.controlEvent(.touchUpInside).subscribe(with: self) { owner, _ in
            let vc = WSListViewController()
            owner.present(vc, animated: true)
        }.disposed(by: disposeBag)

        
        mainView.createButton.rx.tap.subscribe(with: self) { owner, _ in
            let vc = CreateWSController()
            owner.present(vc, animated: true)
        }.disposed(by: disposeBag)

    }
}
