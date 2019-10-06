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
    
    struct Succeeded: FeatureFlowEvent { public init() {} }
    struct Failed: FeatureFlowEvent { public init() {} }
}


public extension Downloading {
    struct Start: FeatureFlowCommand, Equatable { public init() {} }
    struct Cancel: FeatureFlowCommand, Equatable { public init() {} }
}

extension Downloading.Start {
    public struct Params: Equatable {
        public let url: String
        
        public init(url: String) {
            self.url = url
        }
    }
}
