//
//  DownloadScreen.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/10/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public struct DownloadScreen: UIEntity, Equatable { public init() {} }



public extension DownloadScreen {
    struct OpenMagicolorScreen: FeatureFlowEvent {
        public let id: String
        
        public init(id: String) {
            self.id = id
        }
    }
    
    struct DownloadingCancelled: FeatureFlowEvent { public init() {} }
}


