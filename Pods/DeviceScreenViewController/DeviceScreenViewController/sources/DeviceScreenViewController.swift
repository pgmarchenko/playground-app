//
//  DeviceScreenViewController.swift
//  DeviceScreenViewController
//
//  Created by Pavel Marchenko on 10/2/18.
//  Copyright © 2018 pgmarchenko. No rights reserved.
//

import UIKit

public enum Orientation {
    case portrait
    case landscape
}

public func deviceScreenViewController(
    device: Device = .phone6,
    orientation: Orientation = .portrait,
    child: UIViewController = UIViewController(),
    additionalTraits: UITraitCollection = .init(),
    showStatusBar: Bool = true
) -> (parent: UIViewController, child: UIViewController) {
    
    let parentFrame = orientation == .portrait ? device.portraitRect : device.landscapeRect
    let parent = ViewControllerWithStatusBar(
        frame: parentFrame,
        child: child,
        showStatusBar: showStatusBar
    )

    decorate(vc: parent, for: device, and: orientation)
    
    let allTraits = UITraitCollection.init(
        traitsFrom: [
            makeTraits(for: device, and: orientation),
            additionalTraits
        ]
    )
    
    parent.setOverrideTraitCollection(allTraits, forChild: child)

    return (parent, child)
}

func decorate(vc: ViewControllerWithStatusBar, for device: Device, and orientation: Orientation) {
    switch (device, orientation) {
    case (.phoneX, .portrait): fallthrough
    case (.phoneXSMax, .portrait):
        let (notch, _) = addNotchAndHomeIndicator(to: vc.view)
        vc.timeLabel?.frame.center = .init(
            x: notch.frame.origin.x / 2,
            y: notch.frame.midY
        )
        
        if #available(iOS 11.0, *) {
            vc.children.forEach{
                $0.additionalSafeAreaInsets = .init(top: 44, left: 0, bottom: 34, right: 0)
            }
        }
    default: return
    }
}

@discardableResult
func addNotchAndHomeIndicator(to view: UIView) -> (notch: UIView, homeIndicator: UIView) {
    let notch = UIView(frame: .init(x: 0, y: 0, width: 230, height: 32))
    notch.center.x = view.bounds.midX
    notch.backgroundColor = .black
    notch.layer.borderWidth = 1
    notch.layer.borderColor = UIColor.white.cgColor
    view.addSubview(notch)
    
    let homeIndicator = UIView(frame: .init(x: 0, y: 0, width: 158, height: 5))
    homeIndicator.center.x = view.bounds.midX
    homeIndicator.frame.rb.y = view.bounds.maxY - 8
    homeIndicator.backgroundColor = .black
    homeIndicator.layer.borderWidth = 1
    homeIndicator.layer.borderColor = UIColor.white.cgColor
    
    view.addSubview(homeIndicator)
    
    return (notch, homeIndicator)
}

func makeTraits(for device: Device, and orientation: Orientation) -> UITraitCollection {
    switch (device, orientation) {
    case (.phone4, .portrait): fallthrough
    case (.phone5, .portrait): fallthrough
    case (.phone6, .portrait): fallthrough
    case (.phone6Plus, .portrait): fallthrough
    case (.phoneX, .portrait): fallthrough
    case (.phoneXSMax, .portrait):
        return .init(traitsFrom: [
            .init(horizontalSizeClass: .compact),
            .init(verticalSizeClass: .regular),
            .init(userInterfaceIdiom: .phone)
            ])
        
    case (.phone4, .landscape): fallthrough
    case (.phone5, .landscape): fallthrough
    case (.phone6, .landscape):
        
        return .init(traitsFrom: [
            .init(horizontalSizeClass: .compact),
            .init(verticalSizeClass: .compact),
            .init(userInterfaceIdiom: .phone)
            ])
        
    case (.phone6Plus, .landscape): fallthrough
    case (.phoneX, .landscape): fallthrough
    case (.phoneXSMax, .landscape):
        return .init(traitsFrom: [
            .init(horizontalSizeClass: .regular),
            .init(verticalSizeClass: .compact),
            .init(userInterfaceIdiom: .phone)
            ])
        
    case (.pad, _): fallthrough
    case (.padPro, _):
        return .init(traitsFrom: [
            .init(horizontalSizeClass: .regular),
            .init(verticalSizeClass: .regular),
            .init(userInterfaceIdiom: .pad)
            ])
    }
}
