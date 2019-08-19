//
//  MagiColorScreen.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/10/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public struct MagiColorScreen: UIEntity, Equatable { public init() {} }


public extension MagiColorScreen {
    struct RedButtonTouched: FeatureFlowEvent { public init() {} }
    struct ResetButtonTouched: FeatureFlowEvent { public init() {} }
    
    struct TutorialSwitcherTouched: FeatureFlowEvent { public init() {} }
}


public extension MagiColorScreen {
    struct SetRedMode: FeatureFlowCommand, Equatable { public init() {} }
    struct SetWhiteMode: FeatureFlowCommand, Equatable { public init() {} }
    
    struct SetTutorialTitle: FeatureFlowCommand, Equatable {
        public let title: String?
        
        public init(_ title: String?) {
            self.title = title
        }
    }
}
