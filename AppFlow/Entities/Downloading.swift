//
//  Downloading.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/10/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public enum Downloading {}


public extension Downloading {
    struct Progress: FeatureFlowEvent {
        public let current: Double
        public let total: Double
        
        public init(current: Double, total: Double) {
            self.current = current
            self.total = total
        }
    }
    
    struct Succeeded: FeatureFlowEvent {
        public let presetId: String
        
        public init(presetId: String) {
            self.presetId = presetId
        }
    }
    
    struct Failed: FeatureFlowEvent {
        public let presetId: String
        
        public init(presetId: String) {
            self.presetId = presetId
        }
    }
}


public extension Downloading {
    struct Start: FeatureFlowCommand, Equatable {
        public let presetId: String
        
        public init(presetId: String) {
            self.presetId = presetId
        }
    }
    
    struct Cancel: FeatureFlowCommand, Equatable { public init() {} }
}
