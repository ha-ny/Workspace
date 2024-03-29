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
    
    let startButtonView = {
        let view = TextButtonView(style: .fill, title: "시작하기")
        view.isHidden = true
        return view
    }()
    
    override func setConfiguration() {
        addSubview(label)
        addSubview(image)
        addSubview(startButtonView)
    }

    override func setConstraints() {
        label.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(safeAreaLayoutGuide).offset(39)
        }
        
        image.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(image.snp.width).multipliedBy(1)
            $0.top.equalTo(label.snp.bottom).offset(89)
        }
        
        startButtonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(12)
        }
    }
}
