//
//  DownloadWaitingOverlay.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/10/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public enum DownloadWaitingOverlay {}

public extension DownloadWaitingOverlay {
    
}

public extension DownloadWaitingOverlay {
    struct Show: FeatureFlowCommand, Equatable { public init() {} }
    
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
    
    struct Hide: FeatureFlowCommand, Equatable { public init() {} }
}
