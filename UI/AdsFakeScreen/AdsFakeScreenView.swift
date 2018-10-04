//
//  AdsFakeScreenView.swift
//  UI
//
//  Created by Pavel Marchenko on 10/4/18.
//  Copyright © 2018 pgmarchenko. No rights reserved.
//

import Foundation
import UIKit

import SnapKit

public class AdsFakeScreeView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        assemble()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let closeButton = UIButton()
    let getRewardButton = UIButton()
    let adLabel = UILabel()
}

extension AdsFakeScreeView {
    private func assemble() {
        closeButton.setTitle("Close", for: .normal)
        
        getRewardButton.setTitle("Get reward", for: .normal)
        
        adLabel.text = "The place for your ads!"
        adLabel.textColor = .white
        adLabel.textAlignment = .center
        
        addSubview(adLabel)
        addSubview(closeButton)
        addSubview(getRewardButton)
        
        setupLayout()
    }
    
    private func setupLayout() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin).offset(20)
            make.left.equalTo(self.snp.leftMargin)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        
        getRewardButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin).offset(20)
            make.right.equalTo(self.snp.rightMargin)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        
        adLabel.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
