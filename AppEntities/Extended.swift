//
//  Extended.swift
//  AppEntities
//
//  Created by Pavel Marchanka on 8/19/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public struct ExtendedEvent<Action: FeatureFlowEvent, Params>: FeatureFlowEvent {
    public let params: Params
    public let appAction: Action
    
    public init(_ action: Action, params: Params) {
        self.appAction = action
        self.params = params
    }
}

public struct ExtendedCommand<Action: FeatureFlowCommand, Params: Equatable>: FeatureFlowCommand, Equatable {
    public let params: Params
    public let appAction: Action
    
    public init(_ action: Action, params: Params) {
        self.appAction = action
        self.params = params
    }
}

extension ExtendedCommand {
    public static func == (lhs: ExtendedCommand<Action, Params>, rhs: ExtendedCommand<Action, Params>) -> Bool {
        return lhs.appAction.isEqualTo(rhs.appAction) && lhs.params == rhs.params
    }
}
