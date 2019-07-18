//
//  DownloadScreen.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/10/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public enum DownloadScreen {}


public extension DownloadScreen {
    struct DidAppear: FeatureFlowEvent { public init() {} }
    
    struct DownloadAndOpen: FeatureFlowEvent {
        public let premium: Bool
        public let isFree: Bool
        public let id: String
        
        public init(id: String, premium: Bool, isFree: Bool) {
            self.id = id
            self.isFree = isFree
            self.premium = premium
        }
    }
    
    struct OpenForVideo: FeatureFlowEvent { public init() {} }
    
    struct DownloadingCancelled: FeatureFlowEvent { public init() {} }
}


public extension DownloadScreen {
    
}
