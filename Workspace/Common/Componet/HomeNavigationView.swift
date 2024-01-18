//
//  HomeNavigationView.swift
//  Workspace
//
//  Created by 김하은 on 1/17/24.
//

import UIKit

final class HomeNavigationView: BaseView {

    var workSpaceTapView = UIControl()
    
    var workSpaceImage = {
       let view = UIImageView()
        view.layer.cornerRadius = 8
        view.image = .emptyWorkspace
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    let workSpaceTitle = {
       let view = UILabel()
        view.text = "No Workspace"
        view.font = .title1
        view.textColor = .bdBlack
        return view
    }()
    
    var profileButton = {
       let view = UIButton()
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.bdGray.cgColor
        view.setImage(.emptyProfile, for: .normal)
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private let line = {
       let view = UILabel()
        view.backgroundColor = UIColor.bdInactive
        return view
    }()
    
    override func setConfiguration() {
        backgroundColor = .bgSecondary
        
        addSubview(workSpaceTapView)
        addSubview(profileButton)
        addSubview(line)
        
        workSpaceTapView.addSubview(workSpaceImage)
        workSpaceTapView.addSubview(workSpaceTitle)
    }
    
    override func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        workSpaceTapView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(profileButton.snp.leading)
        }
        
        workSpaceImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview().inset(14)
            $0.size.equalTo(32)
        }
        
        workSpaceTitle.snp.makeConstraints {
            $0.leading.equalTo(workSpaceImage.snp.trailing).offset(8)
            $0.trailing.equalTo(profileButton.snp.leading).offset(12)
            $0.verticalEdges.equalToSuperview().inset(12)
        }
        
        profileButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview().inset(14)
            $0.size.equalTo(32)
        }
        
        line.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
