//
//  AnalyticsCommands.swift
//  AppFlow
//
//  Created by Pavel Marchenko on 7/18/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation


public extension Analytics {
    enum Timer {}
}


public extension Analytics.Timer {
    struct Start: FeatureFlowCommand, Equatable {}
    struct Stop: FeatureFlowCommand, Equatable {}
}
