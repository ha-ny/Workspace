//
//  SplashViewController.swift
//  Workspace
//
//  Created by 김하은 on 1/2/24.
//

import UIKit

final class SplashViewController: UIViewController {

    let mainView = OnboardingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgPrimary
    }
}
