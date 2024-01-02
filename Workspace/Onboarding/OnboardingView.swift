//
//  OnboardingView.swift
//  Workspace
//
//  Created by 김하은 on 1/2/24.
//

import UIKit

final class OnboardingView: BaseView {

    private let label = {
        let view = UILabel()
        view.text = "작업공간을 사용하면 어디서나\n팀을 모을 수 있습니다"
        view.font = .title1
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    private let image = {
        let view = UIImageView()
        view.image = UIImage.onboarding
        return view
    }()
    
    let startButton = {
        let view = UIButton()
        view.isHidden = true
        view.titleLabel?.font = .title2
        view.setTitle("시작하기", for: .normal)
        view.setTitleColor(.bdWhite, for: .normal)
        view.backgroundColor = .bdGreen
        view.layer.cornerRadius = 8
        return view
    }()
    
    override func setConfiguration() {
        addSubview(label)
        addSubview(image)
        addSubview(startButton)
    }

    override func setConstraints() {
        label.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self).inset(24)
            $0.top.equalTo(safeAreaLayoutGuide).offset(39)
        }
        
        image.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self).inset(12)
            $0.centerX.equalTo(self)
            $0.height.equalTo(image.snp.width).multipliedBy(1)
            $0.top.equalTo(label.snp.bottom).offset(89)
        }
        
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self).inset(24)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(44)
        }
    }
}
