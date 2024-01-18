//
//  ModalNavigationView.swift
//  Workspace
//
//  Created by 김하은 on 1/3/24.
//

import UIKit

final class ModalNavigationView: BaseView {
    
    private lazy var label = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textColor = .bdBlack
        view.textAlignment = .center
        return view
    }()
    
    let backButton = {
       let view = UIButton()
        view.setImage(.iconBack, for: .normal)
        return view
    }()
    
    private let line = {
       let view = UILabel()
        view.backgroundColor = UIColor.bdInactive
        return view
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        backgroundColor = .bgSecondary
        label.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setConfiguration() {
        addSubview(label)
        addSubview(backButton)
        addSubview(line)
    }
    
    override func setConstraints() {
        self.snp.makeConstraints { 
            $0.height.equalTo(60)
        }
        
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(14)
            $0.size.equalTo(20)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
        
        line.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
