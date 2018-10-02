//
//  ViewControllerWithStatusBar.swift
//  DeviceScreenViewController
//
//  Created by Pavel Marchenko on 10/2/18.
//

import Foundation
import UIKit

class ViewControllerWithStatusBar: UIViewController {
    init(frame: CGRect, child: UIViewController, showStatusBar: Bool) {
        super.init(nibName: nil, bundle: nil)
        
        addChild(child)
        view.addSubview(child.view)
        view.frame = frame
        view.backgroundColor = .white
        preferredContentSize = view.frame.size

        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.view.frame = view.bounds

        if showStatusBar {
            if #available(iOS 11.0, *) {
                child.additionalSafeAreaInsets = .init(top: 20, left: 0, bottom: 0, right: 0)
            }
            
            timeLabel = UILabel(frame: .init(origin: .zero, size: .init(width: 49, height: 14)))
            timeLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            timeLabel?.textColor = .white
            timeLabel?.text = "9:41 AM"
            timeLabel?.textAlignment = .center
            timeLabel?.sizeToFit()
            timeLabel?.center.x = view.bounds.midX
            timeLabel?.frame.origin.y = 3.5
            
            timeLabel.map(view.addSubview)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) var timeLabel: UILabel?
}
