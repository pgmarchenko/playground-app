//
//  Device.swift
//  DeviceScreenViewController
//
//  Created by Pavel Marchenko on 10/2/18.
//

import Foundation

public enum Device {
    case phone4
    case phone5
    case phone6
    case phone6Plus
    case phoneX
    case phoneXSMax
    case pad
    case padPro
}

extension Device {
    public var portraitRect: CGRect {
        let size: CGSize = {
            switch self {
            case .phone4: return .init(width: 320, height: 480)
            case .phone5: return .init(width: 320, height: 568)
            case .phone6: return .init(width: 375, height: 667)
            case .phone6Plus: return .init(width: 414, height: 736)
            case .phoneX: return .init(width: 375, height: 812)
            case .phoneXSMax: return .init(width: 414, height: 896)
            case .pad: return .init(width: 768, height: 1024)
            case .padPro: return .init(width: 1024, height: 1366)
            }
        }()
        
        return .init(origin: .zero, size: size)
    }
    
    public var landscapeRect: CGRect {
        let size: CGSize = {
            switch self {
            case .phone4: return .init(width: 480, height: 320)
            case .phone5: return .init(width: 568, height: 320)
            case .phone6: return .init(width: 667, height: 375)
            case .phone6Plus: return .init(width: 736, height: 414)
            case .phoneX: return .init(width: 812, height: 375)
            case .phoneXSMax: return .init(width: 896, height: 414)
            case .pad: return .init(width: 1024, height: 768)
            case .padPro: return .init(width: 1366, height: 1024)
            }
        }()
        
        return .init(origin: .zero, size: size)
    }
}
