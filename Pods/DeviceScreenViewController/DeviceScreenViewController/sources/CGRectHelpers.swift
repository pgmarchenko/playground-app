//
//  CGRectHelpers.swift
//  DeviceScreenViewController
//
//  Created by Pavel Marchenko on 10/2/18.
//  Copyright © 2018 pgmarchenko. No rights reserved.
//

import Foundation
import CoreGraphics

public extension CGRect {
    public init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width/2,
                             y: center.y - size.height/2)
        
        self = CGRect(origin: origin, size: size)
    }
    
    public var rb: CGPoint {
        get {
            return CGPoint(x: self.origin.x + self.width,
                           y: self.origin.y + self.height)
        }
        set {
            origin = CGPoint(x: newValue.x - width, y: newValue.y - height)
        }
    }
    
    public var rectCenter: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
    
    public var center: CGPoint {
        get {
            return CGPoint(x: self.width / 2, y: self.height / 2)
        }
        set {
            origin = CGPoint(x: newValue.x - width/2, y: newValue.y - height/2)
        }
    }
}
