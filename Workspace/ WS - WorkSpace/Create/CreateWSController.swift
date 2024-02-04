//
//  CreateWSController.swift
//  Workspace
//
//  Created by 김하은 on 1/19/24.
//

import UIKit

final class CreateWSController: UIViewController {

    private let mainView = CreateWSView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
