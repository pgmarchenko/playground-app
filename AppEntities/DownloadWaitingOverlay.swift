//
//  DownloadWaitingOverlay.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/10/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public struct DownloadWaitingOverlay: UIEntity, Equatable { public init() {} }

public extension DownloadWaitingOverlay {
    struct Retry: FeatureFlowEvent { public init() {} }
}

public extension DownloadWaitingOverlay {
    struct ShowRetry: FeatureFlowCommand, Equatable { public init() {} }
    struct HideRetry: FeatureFlowCommand, Equatable { public init() {} }
    
    struct ShowProgress: FeatureFlowCommand, Equatable {
        public let current: Double
        public let total: Double
        
        public init(current: Double, total: Double) {
            self.current = current
            self.total = total
        }
    }
}
