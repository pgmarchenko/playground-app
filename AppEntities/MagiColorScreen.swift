//
//  MagiColorScreen.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/10/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public protocol EventParams { }

public struct MagiColorScreen: UIEntity, Equatable { public init() {} }


public extension MagiColorScreen {
    struct ColorButtonTouched: FeatureFlowEvent { public init() {} }
    struct ResetButtonTouched: FeatureFlowEvent { public init() {} }
    
    struct TutorialSwitcherTouched: FeatureFlowEvent { public init() {} }
}


public extension MagiColorScreen {
    struct ColorsParams: Equatable, EventParams {
        public let primary: String
        public let `default`: String
        
        public init(primary: String, default: String) {
            self.primary = primary
            self.default = `default`
        }
    }
    
    struct SetColors: FeatureFlowCommand, Equatable {
        public let params: ColorsParams
        
        public init(params: ColorsParams) {
            self.params = params
        }
    }
    struct SetColorMode: FeatureFlowCommand, Equatable { public init() {} }
    struct SetDefaultMode: FeatureFlowCommand, Equatable { public init() {} }
    
    struct SetTutorialTitle: FeatureFlowCommand, Equatable {
        public let title: String?
        
        public init(_ title: String?) {
            self.title = title
        }
    }
}
