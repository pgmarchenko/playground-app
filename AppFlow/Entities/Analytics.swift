//
//  Analytics.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/11/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public enum Analytics { }


public extension Analytics {
    
}


public extension Analytics {
    struct LogEvent: FeatureFlowCommand, Equatable {
        public let name: String
        public let params: [String: String]
        
        public init(name: String, params: [String: String] = [:]) {
            self.name = name
            self.params = params
        }
    }
}
