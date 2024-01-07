//
//  SplashViewController.swift
//  Workspace
//
//  Created by 김하은 on 1/2/24.
//

import UIKit

final class SplashViewController: UIViewController {

    private let mainView = OnboardingView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
