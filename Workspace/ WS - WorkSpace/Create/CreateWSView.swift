//
//  CreateWSView.swift
//  Workspace
//
//  Created by 김하은 on 1/19/24.
//

import UIKit

class CreateWSView: BaseView {
    
    let navigationView = ModalNavigationView(title: "워크스페이스 생성")
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = .message
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 8
        return view
    }()
    
    let cameraButton = ImageButton(image: .iconCamera)
    
    let titleView = TextFieldView(title: "워크스페이스 이름", placeholder: "워크스페이스 이름을 입력하세요 (필수)")
    
    let descriptionView = TextFieldView(title: "워크스페이스 설명", placeholder: "워크스페이스를 설명하세요 (옵션)")
    
    let createButton: TextButtonView = {
        let view = TextButtonView(style: .fill, title: "완료")
        view.button.backgroundColor = UIColor.bdInactive
        return view
    }()
    
    override func setConfiguration() {
        addSubview(navigationView)
        addSubview(imageView)
        addSubview(titleView)
        addSubview(descriptionView)
        addSubview(createButton)
        imageView.addSubview(cameraButton)
    }
    
    override func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(70)
        }
        
        cameraButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().offset(7)
            $0.size.equalTo(24)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        createButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
        }
    }
}

