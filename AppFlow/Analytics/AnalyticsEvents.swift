//
//  AnalyticsEvents.swift
//  AppFlow
//
//  Created by Pavel Marchenko on 7/18/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public struct TimeParams {
    public let time: TimeInterval
    
    public init(time: TimeInterval) {
        self.time = time
    }
}

public struct FeatureFlowEventWithTime<Event: FeatureFlowAction>: FeatureFlowEvent {
    public let time: TimeInterval
    public let appAction: Event
    
    public init(_ event: Event, time: TimeInterval) {
        self.appAction = event
        self.time = time
    }
}

public struct AnalyticsEvent<Action: FeatureFlowAction, Params>: FeatureFlowEvent {
    public let params: Params
    public let appAction: Action
    
    public init(_ action: Action, params: Params) {
        self.appAction = action
        self.params = params
    }
}


public extension Timer {
    struct OnTick: FeatureFlowEvent {
        public let delta: TimeInterval
        
        public init(delta: TimeInterval) {
            self.delta = delta
        }
    }
}
