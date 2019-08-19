//
//  UI.swift
//  AppEntities
//
//  Created by Pavel Marchanka on 8/16/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public protocol UIEntity { }


public enum UI { }


public extension UI {
    
}


public extension UI {
    struct WillAppear<Entity: UIEntity & Equatable>: FeatureFlowEvent, Equatable {
        public let uiEntity: Entity
        
        public init(_ uiEntity: Entity ) {
            self.uiEntity = uiEntity
        }
    }
    
    struct DidAppear<Entity: UIEntity & Equatable>: FeatureFlowEvent, Equatable {
        public let uiEntity: Entity
        
        public init(_ uiEntity: Entity ) {
            self.uiEntity = uiEntity
        }
    }
    
    struct Show<Entity: UIEntity & Equatable>: FeatureFlowCommand, Equatable {
        public let uiEntity: Entity
        
        public init(_ uiEntity: Entity ) {
            self.uiEntity = uiEntity
        }
    }
    
    struct Hide<Entity: UIEntity & Equatable>: FeatureFlowCommand, Equatable {
        public let uiEntity: Entity
        
        public init(_ uiEntity: Entity ) {
            self.uiEntity = uiEntity
        }
    }
}
