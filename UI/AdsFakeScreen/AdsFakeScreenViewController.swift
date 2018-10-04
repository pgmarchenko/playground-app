//
//  AdsFakeScreenViewController.swift
//  UI
//
//  Created by Pavel Marchenko on 10/4/18.
//  Copyright © 2018 pgmarchenko. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

public class AdsFakeScreeViewController: UIViewController {
    public var onClose: ControlEvent<()> {
        return mainView.closeButton.rx.controlEvent(.touchUpInside)
    }
    
    public var onGetReward: ControlEvent<()> {
        return mainView.getRewardButton.rx.controlEvent(.touchUpInside)
    }
    
    let mainView = AdsFakeScreeView()
}

extension AdsFakeScreeViewController {
    public override func loadView() {
        view = mainView
    }
}
